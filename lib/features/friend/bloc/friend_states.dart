import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

class FriendStates extends Equatable {
  const FriendStates({
    this.friendItem = const <StudentItem>[],
    this.sendFriendItem,
    this.requestFriendItem = const <FriendItem>[],
    this.actionFriendItem,
  });

  final List<StudentItem> friendItem;
  final FriendItem? sendFriendItem;
  final List<FriendItem> requestFriendItem;
  final FriendItem? actionFriendItem;

  @override
  List<Object?> get props => [
        friendItem,
        sendFriendItem,
        requestFriendItem,
        actionFriendItem,
      ];

  FriendStates copyWith({
    List<StudentItem>? friendItem,
    FriendItem? sendFriendItem,
    List<FriendItem>? requestFriendItem,
    FriendItem? actionFriendItem,
  }) {
    return FriendStates(
        friendItem: friendItem ?? this.friendItem,
        sendFriendItem: sendFriendItem ?? this.sendFriendItem,
        requestFriendItem: requestFriendItem ?? this.requestFriendItem,
        actionFriendItem: actionFriendItem ?? this.actionFriendItem);
  }
}

class DoneSendFriendRequestStates extends FriendStates {
  const DoneSendFriendRequestStates({
    required super.friendItem,
    required super.sendFriendItem,
    required super.requestFriendItem,
    required super.actionFriendItem,
  });
}

class DoneActionFriendRequestStates extends FriendStates {
  final String? message;
  const DoneActionFriendRequestStates({
    required super.friendItem,
    required super.sendFriendItem,
    required super.requestFriendItem,
    required super.actionFriendItem,
    required this.message,
  });
}

class InitialRequestedFriendStates extends FriendStates {
  const InitialRequestedFriendStates({
    required super.friendItem,
    required super.sendFriendItem,
    required super.requestFriendItem,
    required super.actionFriendItem,
  });
}

class LoadingRequestedFriendStates extends FriendStates {
  const LoadingRequestedFriendStates({
    required super.friendItem,
    required super.sendFriendItem,
    required super.requestFriendItem,
    required super.actionFriendItem,
  });
}

class DoneLoadingRequestedFriendStates extends FriendStates {
  const DoneLoadingRequestedFriendStates({
    required super.friendItem,
    required super.sendFriendItem,
    required super.requestFriendItem,
    required super.actionFriendItem,
  });
}

class LoadedRequestedFriendStates extends FriendStates {
  const LoadedRequestedFriendStates({
    required super.friendItem,
    required super.sendFriendItem,
    required super.requestFriendItem,
    required super.actionFriendItem,
  });
}
