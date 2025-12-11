part of 'quiz_room_bloc.dart';

class QuizRoomEvent extends Equatable {
  const QuizRoomEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyFriendEvent extends QuizRoomEvent {
  const TriggerInitialMyFriendEvent();
}

class TriggerLoadingMyFriendEvent extends QuizRoomEvent {
  const TriggerLoadingMyFriendEvent();
}

class TriggerDoneLoadingMyFriendEvent extends QuizRoomEvent {
  const TriggerDoneLoadingMyFriendEvent();
}

class TriggerLoadedMyFriendEvent extends QuizRoomEvent {
  const TriggerLoadedMyFriendEvent(this.friendItem);
  final List<StudentItem> friendItem;
}

class TriggerSearchMyFriendEvents extends QuizRoomEvent {
  const TriggerSearchMyFriendEvents(this.friendItem);
  final List<StudentItem> friendItem;
}

class TriggerInviteFriendEvent extends QuizRoomEvent {
  const TriggerInviteFriendEvent(this.friendItem);
  final StudentItem friendItem;
}

//Quiz Loby

//Add
class TriggerInvitedFriendList extends QuizRoomEvent {
  const TriggerInvitedFriendList(this.invitedFriend);
  final Player invitedFriend;

  @override
  List<Object> get props => [invitedFriend];
}

//Remove
class TriggerRemoveInvitedFriend extends QuizRoomEvent {
  const TriggerRemoveInvitedFriend(this.invitedFriend);
  final Player invitedFriend;

  @override
  List<Object> get props => [invitedFriend];
}

class TriggerAdminToken extends QuizRoomEvent {
  const TriggerAdminToken(this.adminToken, this.roomDocId, this.levelItem);
  final String adminToken;
  final String roomDocId;
  final LevelItem levelItem;
}

class TriggerPlayQuiz extends QuizRoomEvent {
  const TriggerPlayQuiz(this.invitedFriend);
  final Player invitedFriend;

  @override
  List<Object> get props => [invitedFriend];
}

class TriggerChangeAdmin extends QuizRoomEvent {
  const TriggerChangeAdmin(this.invitedFriend);
  final Player invitedFriend;

  @override
  List<Object> get props => [invitedFriend];
}

class TriggerStatusInvitedFriend extends QuizRoomEvent {
  const TriggerStatusInvitedFriend(this.invitedFriend);
  final Player invitedFriend;

  @override
  List<Object> get props => [invitedFriend];
}

class TriggerClearInvitedFriendList extends QuizRoomEvent {
  const TriggerClearInvitedFriendList();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyInvitationEvent extends QuizRoomEvent {
  const TriggerInitialMyInvitationEvent();
}

class TriggerLoadingMyInvitationEvent extends QuizRoomEvent {
  const TriggerLoadingMyInvitationEvent();
}

class TriggerDoneLoadingMyInvitationEvent extends QuizRoomEvent {
  const TriggerDoneLoadingMyInvitationEvent();
}

class TriggerLoadedMyInvitationEvent extends QuizRoomEvent {
  const TriggerLoadedMyInvitationEvent(this.invitedLobby);
  final List<Room> invitedLobby;
}
