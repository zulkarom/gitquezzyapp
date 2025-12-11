enum SocketIoEvent {
  getPackage('getPackage'),

  //////////////////////////////////////////
  packageRetrieved('packageListJson');

  final String eventName;
  const SocketIoEvent(this.eventName);
}

class Event {
  late final String eventName;
  late final Map<String, dynamic> parameters;
  late final Map<String, dynamic> result;
  late final String? error;
  late final String? errorMessage;

  Event(this.eventName, this.parameters, this.result,
      [this.error, this.errorMessage]);

  Event.fromJson(Map<String, Object?> json) {
    if (json['issue'] != null) {
      eventName = json['issue'].toString();
      parameters = json['parameters']! as Map<String, dynamic>;
      result =
          json['result'] != null ? json['result']! as Map<String, dynamic> : {};
      error = json['error'] != null ? json['error']!.toString() : '';
      errorMessage =
          json['errorMessage'] != null ? json['errorMessage']!.toString() : '';
    } else {
      eventName = json['eventName'].toString();
      parameters = {};
      result = json['data']! as Map<String, dynamic>;
    }
  }
}
