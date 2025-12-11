import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/entities.dart';
import 'friend_events.dart';
import 'friend_states.dart';

class FriendBlocs extends Bloc<FriendEvents, FriendStates> {
  FriendBlocs() : super(const FriendStates()) {
    on<InitialSearchFriendEvents>(_initialSearchFriendEvents);
    on<TriggerSearchEvents>(_triggerFriendEvents);
    on<SendFriendRequestEvent>(_sendFriendRequestEvent);
    on<ActionFriendRequestEvent>(_actionFriendRequestEvent);

    //requested friend event
    on<TriggerInitialRequestedFriendEvent>(_triggerInitialRequestedFriend);
    on<TriggerLoadingRequestedFriendEvent>(_triggerLoadingRequestedFriend);
    on<TriggerLoadedRequestedFriendEvent>(_triggerLoadedRequestedFriend);
    on<TriggerDoneLoadingRequestedFriendEvent>(
        _triggerDoneLoadingRequestedFriend);
    //...
  }

  _initialSearchFriendEvents(
      InitialSearchFriendEvents event, Emitter<FriendStates> emit) {
    emit(state.copyWith(friendItem: event.friendItem));
  }

  _triggerFriendEvents(TriggerSearchEvents event, Emitter<FriendStates> emit) {
    emit(state.copyWith(friendItem: event.friendItem));
  }

  void _sendFriendRequestEvent(
      SendFriendRequestEvent event, Emitter<FriendStates> emit) {
    final List<StudentItem> selectedFriends =
        List<StudentItem>.from(state.friendItem);

    // final List<StudentItem> resultList = [];

    final List<StudentItem> resultList = [...selectedFriends];

    for (var select in resultList) {
      if (select.token == event.sendFriendItem.friendToken) {
        // Update the existing item in the resultList with new data
        select.id = event.sendFriendItem.id;
        select.name = event.sendFriendItem.name;
        select.schoolName = event.sendFriendItem.schoolName;
        select.token = event.sendFriendItem.friendToken;
        select.avatar = event.sendFriendItem.avatar;
        select.status = event.sendFriendItem.status;
      }
    }

    // final List<StudentItem> resultList = [];
    // for (var select in selectedFriends) {
    //   if (select.token == event.sendFriendItem.friendToken) {
    //     resultList.add(StudentItem(
    //       id: select.id,
    //       name: select.name,
    //       schoolName: select.schoolName,
    //       token: select.token,
    //       avatar: select.avatar,
    //       status: select.status,
    //     ));
    //   }
    // }

    emit(DoneSendFriendRequestStates(
      friendItem: resultList,
      sendFriendItem: event.sendFriendItem,
      requestFriendItem: state.requestFriendItem,
      actionFriendItem: state.actionFriendItem,
    ));
  }

  void _actionFriendRequestEvent(
      ActionFriendRequestEvent event, Emitter<FriendStates> emit) {
    final List<FriendItem> selectedFriends =
        List<FriendItem>.from(state.requestFriendItem);

    // final List<StudentItem> resultList = [];

    final List<FriendItem> resultList = [...selectedFriends];
    resultList.removeWhere((select) => select.id == event.actionFriendItem.id);

    // for (var select in resultList) {
    //   if (select.id == event.actionFriendItem.id) {
    //     // Update the existing item in the resultList with new data
    //   }
    // }

    emit(DoneActionFriendRequestStates(
      friendItem: state.friendItem,
      sendFriendItem: state.sendFriendItem,
      requestFriendItem: resultList,
      actionFriendItem: event.actionFriendItem,
      message: event.message,
    ));
  }

  //requested event
  void _triggerInitialRequestedFriend(
      TriggerInitialRequestedFriendEvent event, Emitter<FriendStates> emit) {
    emit(InitialRequestedFriendStates(
      friendItem: state.friendItem,
      sendFriendItem: state.sendFriendItem,
      requestFriendItem: state.requestFriendItem,
      actionFriendItem: state.actionFriendItem,
    ));
  }

  void _triggerLoadedRequestedFriend(
      TriggerLoadedRequestedFriendEvent event, Emitter<FriendStates> emit) {
    emit(LoadedRequestedFriendStates(
      friendItem: state.friendItem,
      sendFriendItem: state.sendFriendItem,
      requestFriendItem: event.requestedFriendItem,
      actionFriendItem: state.actionFriendItem,
    ));
  }

  void _triggerLoadingRequestedFriend(
      TriggerLoadingRequestedFriendEvent event, Emitter<FriendStates> emit) {
    emit(LoadingRequestedFriendStates(
      friendItem: state.friendItem,
      sendFriendItem: state.sendFriendItem,
      requestFriendItem: state.requestFriendItem,
      actionFriendItem: state.actionFriendItem,
    ));
  }

  void _triggerDoneLoadingRequestedFriend(
      TriggerDoneLoadingRequestedFriendEvent event,
      Emitter<FriendStates> emit) {
    emit(DoneLoadingRequestedFriendStates(
      friendItem: state.friendItem,
      sendFriendItem: state.sendFriendItem,
      requestFriendItem: state.requestFriendItem,
      actionFriendItem: state.actionFriendItem,
    ));
  }
  //requested event
}
