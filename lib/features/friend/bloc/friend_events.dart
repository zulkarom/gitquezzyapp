import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';

class FriendEvents extends Equatable {
  const FriendEvents();

  @override
  List<Object> get props => [];
}

class InitialSearchFriendEvents extends FriendEvents {
  final List<StudentItem> friendItem;
  const InitialSearchFriendEvents(this.friendItem);
}

class TriggerSearchEvents extends FriendEvents {
  const TriggerSearchEvents(this.friendItem);
  final List<StudentItem> friendItem;
}

class SendFriendRequestEvent extends FriendEvents {
  const SendFriendRequestEvent(this.sendFriendItem);
  final FriendItem sendFriendItem;
}

class ActionFriendRequestEvent extends FriendEvents {
  const ActionFriendRequestEvent(this.actionFriendItem, this.message);
  final FriendItem actionFriendItem;
  final String message;
}

//For request action
class TriggerInitialRequestedFriendEvent extends FriendEvents {
  const TriggerInitialRequestedFriendEvent();
}

class TriggerLoadingRequestedFriendEvent extends FriendEvents {
  const TriggerLoadingRequestedFriendEvent();
}

class TriggerDoneLoadingRequestedFriendEvent extends FriendEvents {
  const TriggerDoneLoadingRequestedFriendEvent();
}

class TriggerLoadedRequestedFriendEvent extends FriendEvents {
  const TriggerLoadedRequestedFriendEvent(this.requestedFriendItem);
  final List<FriendItem> requestedFriendItem;
}
