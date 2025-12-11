part of 'friend_bloc.dart';

class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyFriendEvent extends FriendEvent {
  const TriggerInitialMyFriendEvent();
}

class TriggerLoadingMyFriendEvent extends FriendEvent {
  const TriggerLoadingMyFriendEvent();
}

class TriggerDoneLoadingMyFriendEvent extends FriendEvent {
  const TriggerDoneLoadingMyFriendEvent();
}

class TriggerLoadedMyFriendEvent extends FriendEvent {
  const TriggerLoadedMyFriendEvent(this.friendItem);
  final List<StudentItem> friendItem;
}

class TriggerButtonNameEvent extends FriendEvent {
  const TriggerButtonNameEvent(this.friendItemOne);
  final FriendItem friendItemOne;
}

//For request action
class TriggerInitialRequestedFriendEvent extends FriendEvent {
  const TriggerInitialRequestedFriendEvent();
}

class TriggerLoadingRequestedFriendEvent extends FriendEvent {
  const TriggerLoadingRequestedFriendEvent();
}

class TriggerDoneLoadingRequestedFriendEvent extends FriendEvent {
  const TriggerDoneLoadingRequestedFriendEvent();
}

class TriggerLoadedRequestedFriendEvent extends FriendEvent {
  const TriggerLoadedRequestedFriendEvent(this.requestedFriendItem);
  final List<FriendItem> requestedFriendItem;
}
