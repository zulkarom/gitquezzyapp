part of 'friend_bloc.dart';

class FriendState extends Equatable {
  final List<StudentItem>? friendItem;
  final List<FriendItem>? requestFriendItem;
  // final Map<String, String> btnName;
  final FriendItem? friendItemOne;
  const FriendState({
    required this.friendItem,
    required this.friendItemOne,
    required this.requestFriendItem,
  });

  @override
  List<Object?> get props => [friendItem];
}

class FriendInitial extends FriendState {
  const FriendInitial({
    required super.friendItem,
    required super.friendItemOne,
    required super.requestFriendItem,
  });
}

class InitialMyFriendStates extends FriendState {
  const InitialMyFriendStates({
    required super.friendItem,
    required super.friendItemOne,
    required super.requestFriendItem,
  });
}

class LoadingMyFriendStates extends FriendState {
  const LoadingMyFriendStates({
    required super.friendItem,
    required super.friendItemOne,
    required super.requestFriendItem,
  });
}

class DoneLoadingMyFriendStates extends FriendState {
  const DoneLoadingMyFriendStates({
    required super.friendItem,
    required super.friendItemOne,
    required super.requestFriendItem,
  });
}

class LoadedMyFriendStates extends FriendState {
  const LoadedMyFriendStates({
    required super.friendItem,
    required super.friendItemOne,
    required super.requestFriendItem,
  });
}

class DoneTriggerBtnNameStates extends FriendState {
  const DoneTriggerBtnNameStates({
    required super.friendItem,
    required super.friendItemOne,
    required super.requestFriendItem,
  });
}
