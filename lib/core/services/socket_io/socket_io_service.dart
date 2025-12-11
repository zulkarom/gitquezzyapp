import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';

import '../../error/exceptions/socket_exception.dart';

typedef Issue = Map<String, Object>;

class IssueSent {
  final String id;
  final List<String> pendingReceived = [];

  IssueSent(this.id);
}

class SocketIoService {
  static final SocketIoService _service = SocketIoService._internal();

  factory SocketIoService() {
    return _service;
  }

  SocketIoService._internal();

  static const int kMaxHttpBufferSize = 100000000;

  Socket? _socket;
  // posting issue timer
  Timer? _issuePostingTimer;

  // keeps those long commnuique string and after combined all of them, get cleared
  final List<String> _overflowedEvent = [];

  // queue for packaged issues to send to server
  final List<Issue> _issueQueue = [];
  // queue for issues when the previous issues are being sent to server
  final List<Issue> _backupQueue = [];
  // flag for queues
  bool _sendingIssues = false;
  // issues sent to server are kept on client side until acknowledgement returned
  final Map<String, IssueSent> _issuesSent = {};

  final _encoder = const JsonEncoder();
  final _decoder = const JsonDecoder();

  final _socketStream = StreamController<dynamic>.broadcast();

  Stream<dynamic> get socketStream => _socketStream.stream;

  void newSocket() {
    // when pressing acknowledge alarm from scall ui, newSocket function is called,
    // this results in multiple sockets spawned in an app instance
    if (_socket != null) {
      return;
    }

    _socket = io(
        'http://192.168.0.44:8000/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableForceNew()
            .setExtraHeaders({'foo': 'bar'})
            .build());

    _socket?.onAny(
        (event, data) => log('onAny $event: $data , ${DateTime.now()}'));
    _socket?.onConnect((data) {
      log('socket io client connected');
      log(_socket!.toString());
    });
    _socket?.onConnectError((data) {
      log('socket io client connection error:$data');
      _socketStream.add({
        'eventName': 'connection_error',
        'parameters': {},
        'data': {'error': data},
      });
    });
    _socket?.onDisconnect((data) {
      log('socket io client disconnected');
      _socketStream.add({
        'eventName': 'connection_error',
        'parameters': {},
        'data': {'error': data},
      });
      disconnect();
    });
    _socket?.onError((data) => log('socket io client event error:$data'));

    _socket?.on('communique', (events) {
      for (final event in events as List<dynamic>) {
        try {
          // if( Fmc.communique.bulletins[event['eventName']] )
          //     Fmc.communique.bulletins[event['eventName']]( event );
          _socketStream.add(event);
        } catch (error) {
          log(error.toString());
        }
      }
    });

    _socket?.on('communique_overflow', (args) {
      _overflowedEvent.add(args as String);
    });

    _socket?.on('communique_overflow_end', (args) {
      _overflowedEvent.add(args as String);

      final overflowedEventJoined = _decoder.convert(_overflowedEvent.join());

      try {
        _socketStream.add(overflowedEventJoined);
      } catch (error) {
        log(error.toString());
      }

      _overflowedEvent.clear();
    });

    _socket?.on('issue_responses_overflow', (args) {
      _issuesSent[(args as Map<String, dynamic>)['id'] as String]!
          .pendingReceived
          .add(args['result'] as String);
    });

    _socket?.on('issue_responses_overflow_end', (args) {
      _issuesSent[(args as Map<String, dynamic>)['id'] as String]!
          .pendingReceived
          .add(args['result'] as String);

      final overflowedResponsesJoined = _decoder
          .convert(_issuesSent[args['id'] as String]!.pendingReceived.join());

      for (final response in overflowedResponsesJoined as List<dynamic>) {
        try {
          // if (Fmc.communique.issues[response['issue']]) {
          //   Fmc.communique.issues[response['issue']](response);
          // }
          _socketStream.add(response);
        } catch (error) {
          log(error.toString());
        }
      }

      _issuesSent.remove(args['id'] as String);
    });

    _socket?.on('invalid_session', (_) {
      _socketStream.add({
        'eventName': 'invalid_session',
        'parameters': {},
        'data': {'key': 'value'},
      });
    });

    _issuePostingTimer ??= Timer.periodic(const Duration(seconds: 2), (_) {
      if (_issueQueue.isEmpty || _sendingIssues) {
        return;
      }

      _sendingIssues = true;

      int totalByteLength = 0;
      int currentByteLength = 0;
      final List<Issue> filteredIssues = [];
      String dataString = '';
      String result = '';
      final Map<String, dynamic> collectiveIssues = {};

      for (final issue in _issueQueue) {
        currentByteLength = utf8.encode(_encoder.convert(issue)).length;

        if (currentByteLength >= (kMaxHttpBufferSize - 1000)) {
          if (filteredIssues.isNotEmpty) {
            collectiveIssues.clear();

            collectiveIssues['id'] =
                'collectiveIssues_${DateTime.now().millisecondsSinceEpoch}';
            collectiveIssues['issues'] = List.from(filteredIssues);

            _socket?.emitWithAck('issues', collectiveIssues, ack: (responses) {
              if ((responses as Map<String, dynamic>)['overflow'] != null &&
                  responses['overflow'] as bool) {
                return;
              }

              _issuesSent.remove(responses['id'] as String);

              for (final response in responses['responses'] as List<dynamic>) {
                // if( Fmc.communique.issues[response['issue']] )
                //     Fmc.communique.issues[response['issue']]( response );
                _socketStream.add(response);
              }
            });

            _issuesSent[collectiveIssues['id'] as String] =
                IssueSent(collectiveIssues['id'] as String);
          }

          collectiveIssues.clear();

          collectiveIssues['id'] =
              '${issue['issue']}_${DateTime.now().millisecondsSinceEpoch}';
          collectiveIssues['issues'] = List.from([issue]);

          dataString = _encoder.convert(collectiveIssues);

          for (final char in dataString.split('')) {
            result += char;

            if (utf8.encode(_encoder.convert(result)).length >=
                (kMaxHttpBufferSize - 1000)) {
              result = result.substring(0, result.length - 1);

              _socket?.emit('issues_overflow', result);

              result = char;
            }
          }

          _socket?.emitWithAck('issues_overflow_end', result, ack: (responses) {
            if ((responses as Map<String, dynamic>)['overflow'] != null &&
                responses['overflow'] as bool) {
              return;
            }

            _issuesSent.remove(responses['id'] as String);

            // if( Fmc.communique.issues[(responses['responses'] as List<dynamic>)[0]['issue']] )
            //     Fmc.communique.issues[(responses['responses'] as List<dynamic>)[0]['issue']]( (responses['responses'] as List<dynamic>)[0] );

            _socketStream.add((responses['responses'] as List<dynamic>)[0]);
          });

          _issuesSent[collectiveIssues['id'] as String] =
              IssueSent(collectiveIssues['id'] as String);

          filteredIssues.clear();
          totalByteLength = 0;
          result = '';
        } else {
          totalByteLength += currentByteLength;

          if (totalByteLength < (kMaxHttpBufferSize - 1000)) {
            filteredIssues.add(issue);
          } else {
            if (filteredIssues.isNotEmpty) {
              collectiveIssues.clear();

              collectiveIssues['id'] =
                  'collectiveIssues_${DateTime.now().millisecondsSinceEpoch}';
              collectiveIssues['issues'] = List.from(filteredIssues);

              _socket?.emitWithAck('issues', collectiveIssues,
                  ack: (responses) {
                if ((responses as Map<String, dynamic>)['overflow'] != null &&
                    responses['overflow'] as bool) {
                  return;
                }

                _issuesSent.remove(responses['id'] as String);

                for (final response
                    in responses['responses'] as List<dynamic>) {
                  // if( Fmc.communique.issues[response['issue']] )
                  //     Fmc.communique.issues[response['issue']]( response );
                  _socketStream.add(response);
                }
              });

              _issuesSent[collectiveIssues['id'] as String] =
                  IssueSent(collectiveIssues['id'] as String);
            }

            filteredIssues
              ..clear()
              ..add(issue);
            totalByteLength = currentByteLength;
          }
        }
      }

      if (filteredIssues.isNotEmpty) {
        collectiveIssues.clear();

        collectiveIssues['id'] =
            'collectiveIssues_${DateTime.now().millisecondsSinceEpoch}';
        collectiveIssues['issues'] = List.from(filteredIssues);

        _socket?.emitWithAck('issues', collectiveIssues, ack: (responses) {
          if ((responses as Map<String, dynamic>)['overflow'] != null &&
              responses['overflow'] as bool) {
            return;
          }

          _issuesSent.remove(responses['id'] as String);

          for (final response in responses['responses'] as List<dynamic>) {
            // if( Fmc.communique.issues[response['issue']] )
            //     Fmc.communique.issues[response['issue']]( response );
            _socketStream.add(response);
          }
        });

        _issuesSent[collectiveIssues['id'] as String] =
            IssueSent(collectiveIssues['id'] as String);
      }

      filteredIssues.clear();
      totalByteLength = 0;
      result = '';

      _issueQueue
        ..clear()
        ..addAll(_backupQueue);
      _backupQueue.clear();
      _sendingIssues = false;
    });
  }

  void addIssue(String issueName, Map<String, Object> parameters) {
    if (_socket == null) {
      throw SocketIoException(error: 'socket is disconnected');
    }
    if (!_sendingIssues) {
      _issueQueue.add({'issue': issueName, 'parameters': parameters});
    } else {
      _backupQueue.add({'issue': issueName, 'parameters': parameters});
    }
  }

  void disconnect() {
    _socket?.dispose();
    _socket = null;
    _issuePostingTimer?.cancel();
    _issuePostingTimer = null;
    _sendingIssues = false;
    _issueQueue.clear();
    _backupQueue.clear();
    _overflowedEvent.clear();
    _issuesSent.clear();
  }
}
