part of 'quiz_room_bloc.dart';

class QuizRoomState extends Equatable {
  final List<StudentItem> friendItem;
  final List<Player> invitedFriendList;
  final List<Room> invitedLobby;
  final String adminToken;
  final String roomDocId;
  final LevelItem? levelItem;

  const QuizRoomState({
    required this.friendItem,
    required this.invitedFriendList,
    required this.invitedLobby,
    required this.adminToken,
    required this.roomDocId,
    required this.levelItem,
  });

  @override
  List<Object?> get props => [friendItem, invitedFriendList, invitedLobby];

  QuizRoomState copyWith({
    List<StudentItem>? friendItem,
    List<Player>? invitedFriendList,
    List<Room>? invitedLobby,
    String? adminToken,
    String? roomDocId,
    LevelItem? levelItem,
  }) {
    return QuizRoomState(
      friendItem: friendItem ?? this.friendItem,
      invitedFriendList: invitedFriendList ?? this.invitedFriendList,
      invitedLobby: invitedLobby ?? this.invitedLobby,
      adminToken: adminToken ?? this.adminToken,
      roomDocId: roomDocId ?? this.roomDocId,
      levelItem: levelItem ?? this.levelItem,
    );
  }
}

class FriendInitial extends QuizRoomState {
  const FriendInitial({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class InitialMyFriendStates extends QuizRoomState {
  const InitialMyFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class LoadingMyFriendStates extends QuizRoomState {
  const LoadingMyFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneLoadingMyFriendStates extends QuizRoomState {
  const DoneLoadingMyFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class LoadedMyFriendStates extends QuizRoomState {
  const LoadedMyFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneTriggerBtnNameStates extends QuizRoomState {
  const DoneTriggerBtnNameStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneInvitedFriendStates extends QuizRoomState {
  const DoneInvitedFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneRemovedInvitedFriendStates extends QuizRoomState {
  final String removePlayerToken;
  const DoneRemovedInvitedFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
    required this.removePlayerToken,
  });
}

class DoneStatusInvitedFriendStates extends QuizRoomState {
  const DoneStatusInvitedFriendStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneTriggerPlayButtonStates extends QuizRoomState {
  const DoneTriggerPlayButtonStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneTriggerChangeAdminStates extends QuizRoomState {
  const DoneTriggerChangeAdminStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneTriggerAdminTokenStates extends QuizRoomState {
  const DoneTriggerAdminTokenStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class LoadingMyInvitationStates extends QuizRoomState {
  const LoadingMyInvitationStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class DoneLoadingMyInvitationStates extends QuizRoomState {
  const DoneLoadingMyInvitationStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}

class LoadedMyInvitationStates extends QuizRoomState {
  const LoadedMyInvitationStates({
    required super.friendItem,
    required super.invitedFriendList,
    required super.invitedLobby,
    required super.adminToken,
    required super.roomDocId,
    required super.levelItem,
  });
}
