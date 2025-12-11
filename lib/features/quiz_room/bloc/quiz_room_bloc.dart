import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/entities.dart';

part 'quiz_room_event.dart';
part 'quiz_room_state.dart';

class QuizRoomBloc extends Bloc<QuizRoomEvent, QuizRoomState> {
  QuizRoomBloc()
      : super(const FriendInitial(
          friendItem: [],
          invitedFriendList: [],
          invitedLobby: [],
          adminToken: '',
          roomDocId: '',
          levelItem: null,
        )) {
    on<TriggerInitialMyFriendEvent>(_triggerInitialMyFriend);
    on<TriggerLoadingMyFriendEvent>(_triggerLoadingMyFriend);
    on<TriggerLoadedMyFriendEvent>(_triggerLoadedMyFriend);
    on<TriggerDoneLoadingMyFriendEvent>(_triggerDoneLoadingMyFriend);
    on<TriggerSearchMyFriendEvents>(_triggerSearchMyFriendEvents);
    on<TriggerInviteFriendEvent>(_triggerInviteFriendEvent);
    //Quiz Lobby
    on<TriggerInvitedFriendList>(_triggerInvitedFriendList);
    on<TriggerRemoveInvitedFriend>(_triggerRemoveInvitedFriend);
    on<TriggerStatusInvitedFriend>(_triggerStatusInvitedFriend);
    on<TriggerClearInvitedFriendList>(_triggerClearInvitedFriendList);
    on<TriggerPlayQuiz>(_triggerPlayQuiz);
    on<TriggerAdminToken>(_triggerAdminToken);
    on<TriggerChangeAdmin>(_triggerChangeAdmin);

    //Invitation List #testing
    on<TriggerLoadingMyInvitationEvent>(_triggerLoadingMyInvitation);
    on<TriggerLoadedMyInvitationEvent>(_triggerLoadedMyInvitation);
    on<TriggerDoneLoadingMyInvitationEvent>(_triggerDoneLoadingMyInvitation);
  }

  void _triggerInitialMyFriend(
      TriggerInitialMyFriendEvent event, Emitter<QuizRoomState> emit) {
    emit(InitialMyFriendStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerLoadedMyFriend(
      TriggerLoadedMyFriendEvent event, Emitter<QuizRoomState> emit) {
    emit(LoadedMyFriendStates(
      friendItem: event.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerLoadingMyFriend(
      TriggerLoadingMyFriendEvent event, Emitter<QuizRoomState> emit) {
    emit(LoadingMyFriendStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerDoneLoadingMyFriend(
      TriggerDoneLoadingMyFriendEvent event, Emitter<QuizRoomState> emit) {
    emit(DoneLoadingMyFriendStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerSearchMyFriendEvents(
      TriggerSearchMyFriendEvents event, Emitter<QuizRoomState> emit) {
    emit(state.copyWith(friendItem: event.friendItem));
  }

  void _triggerInviteFriendEvent(
      TriggerInviteFriendEvent event, Emitter<QuizRoomState> emit) {
    var friendItem = List<StudentItem>.from(state.friendItem);

    final List<StudentItem> resultList = [...friendItem];
    resultList.removeWhere((select) => select.id == event.friendItem.id);
    // print(resultList.length);

    emit(state.copyWith(friendItem: resultList));
  }

  //Quiz Lobby
  void _triggerInvitedFriendList(
      TriggerInvitedFriendList event, Emitter<QuizRoomState> emit) {
    //get the total player
    var invitedFriendListNew = state.invitedFriendList.toList();
    //below is the single player
    invitedFriendListNew
        .add(event.invitedFriend); //append in the end of the list
    // invitedFriendListNew.insert(0, event.invitedFriend); //begining of the list
    print(invitedFriendListNew.length);

    // emit(state.copyWith(invitedFriendList: invitedFriendListNew));
    emit(DoneInvitedFriendStates(
      friendItem: state.friendItem,
      invitedFriendList: invitedFriendListNew,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerRemoveInvitedFriend(
      TriggerRemoveInvitedFriend event, Emitter<QuizRoomState> emit) {
    // Copy the existing list to avoid modifying the original list
    var invitedFriendList = List<Player>.from(state.invitedFriendList);

    // Remove the player from the list based on some criteria, for example, studentToken
    invitedFriendList.removeWhere(
        (player) => player.studentToken == event.invitedFriend.studentToken);

    emit(DoneRemovedInvitedFriendStates(
      friendItem: state.friendItem,
      invitedFriendList: invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
      removePlayerToken: event.invitedFriend.studentToken!,
    ));
  }

  // void _triggerStatusInvitedFriend(
  //   TriggerStatusInvitedFriend event,
  //   Emitter<QuizRoomState> emit,
  // ) {
  //   // Copy the existing list to avoid modifying the original list
  //   var invitedFriendList = List<Player>.from(state.invitedFriendList);
  //   for (int i = 0; i < invitedFriendList.length; i++) {
  //     if (invitedFriendList[i].studentToken ==
  //         event.invitedFriend.studentToken) {
  //       // Update the properties of the matching player
  //       invitedFriendList[i] =
  //           invitedFriendList[i].copyWith(status: event.invitedFriend.status);

  //       print(invitedFriendList[i].name);
  //       print(invitedFriendList[i].status);
  //     }
  //   }

  //   emit(
  //     DoneStatusInvitedFriendStates(
  //       friendItem: state.friendItem,
  //       invitedFriendList: invitedFriendList,
  //       invitedLobby: state.invitedLobby,
  //     ),
  //   );
  // }

  void _updateInvitedFriendStatus(
    List<Player> invitedFriendList,
    String studentToken,
    int newStatus,
    int isAdmin,
  ) {
    for (int i = 0; i < invitedFriendList.length; i++) {
      if (invitedFriendList[i].studentToken == studentToken) {
        invitedFriendList[i] = invitedFriendList[i].copyWith(
          status: newStatus,
          isAdmin: isAdmin,
        );

        // Optional: Print the updated details
        print("Optional: Print the updated details");
        print(invitedFriendList[i].name);
        print(invitedFriendList[i].status);
        print(invitedFriendList[i].isAdmin);
      }
    }
  }

  void _triggerStatusInvitedFriend(
    TriggerStatusInvitedFriend event,
    Emitter<QuizRoomState> emit,
  ) {
    // Copy the existing list to avoid modifying the original list
    var invitedFriendList = List<Player>.from(state.invitedFriendList);

    // Update the status using the private method
    _updateInvitedFriendStatus(
      invitedFriendList,
      event.invitedFriend.studentToken!,
      event.invitedFriend.status!,
      event.invitedFriend.isAdmin!,
    );

    emit(
      DoneStatusInvitedFriendStates(
        friendItem: state.friendItem,
        invitedFriendList: invitedFriendList,
        invitedLobby: state.invitedLobby,
        adminToken: state.adminToken,
        roomDocId: state.roomDocId,
        levelItem: state.levelItem,
      ),
    );
  }

  void _triggerPlayQuiz(
    TriggerPlayQuiz event,
    Emitter<QuizRoomState> emit,
  ) {
    // Copy the existing list to avoid modifying the original list
    var invitedFriendList = List<Player>.from(state.invitedFriendList);

    // Update the status using the private method
    _updateInvitedFriendStatus(
      invitedFriendList,
      event.invitedFriend.studentToken!,
      event.invitedFriend.status!,
      event.invitedFriend.isAdmin!,
    );
    emit(
      DoneTriggerPlayButtonStates(
        friendItem: state.friendItem,
        invitedFriendList: invitedFriendList,
        invitedLobby: state.invitedLobby,
        adminToken: state.adminToken,
        roomDocId: state.roomDocId,
        levelItem: state.levelItem,
      ),
    );
  }

  void _triggerAdminToken(
      TriggerAdminToken event, Emitter<QuizRoomState> emit) {
    emit(DoneTriggerAdminTokenStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: event.adminToken,
      roomDocId: event.roomDocId,
      levelItem: event.levelItem,
    ));
  }

  void _triggerChangeAdmin(
    TriggerChangeAdmin event,
    Emitter<QuizRoomState> emit,
  ) {
    // Copy the existing list to avoid modifying the original list
    var invitedFriendList = List<Player>.from(state.invitedFriendList);

    // Update the status using the private method
    _updateInvitedFriendStatus(
      invitedFriendList,
      event.invitedFriend.studentToken!,
      event.invitedFriend.status!,
      event.invitedFriend.isAdmin!,
    );

    emit(
      DoneTriggerChangeAdminStates(
        friendItem: state.friendItem,
        invitedFriendList: invitedFriendList,
        invitedLobby: state.invitedLobby,
        adminToken: event.invitedFriend.studentToken!,
        roomDocId: state.roomDocId,
        levelItem: state.levelItem,
      ),
    );
  }

  void _triggerClearInvitedFriendList(
      TriggerClearInvitedFriendList event, Emitter<QuizRoomState> emit) {
    emit(state.copyWith(invitedFriendList: []));
  }
  //Quiz Lobby

  //Invitation List
  void _triggerLoadedMyInvitation(
      TriggerLoadedMyInvitationEvent event, Emitter<QuizRoomState> emit) {
    print("event.invitedLobby.length");
    print(event.invitedLobby.length);
    emit(LoadedMyInvitationStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: event.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerLoadingMyInvitation(
      TriggerLoadingMyInvitationEvent event, Emitter<QuizRoomState> emit) {
    emit(LoadingMyInvitationStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }

  void _triggerDoneLoadingMyInvitation(
      TriggerDoneLoadingMyInvitationEvent event, Emitter<QuizRoomState> emit) {
    emit(DoneLoadingMyInvitationStates(
      friendItem: state.friendItem,
      invitedFriendList: state.invitedFriendList,
      invitedLobby: state.invitedLobby,
      adminToken: state.adminToken,
      roomDocId: state.roomDocId,
      levelItem: state.levelItem,
    ));
  }
}
