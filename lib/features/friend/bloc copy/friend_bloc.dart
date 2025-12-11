import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/entities.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc()
      : super(const FriendInitial(
          friendItem: [],
          friendItemOne: null,
          requestFriendItem: [],
        )) {
    on<TriggerInitialMyFriendEvent>(_triggerInitialMyFriend);
    on<TriggerLoadingMyFriendEvent>(_triggerLoadingMyFriend);
    on<TriggerLoadedMyFriendEvent>(_triggerLoadedMyFriend);
    on<TriggerDoneLoadingMyFriendEvent>(_triggerDoneLoadingMyFriend);
    //requested friend event
    on<TriggerInitialRequestedFriendEvent>(_triggerInitialRequestedFriend);
    on<TriggerLoadingRequestedFriendEvent>(_triggerLoadingRequestedFriend);
    on<TriggerLoadedRequestedFriendEvent>(_triggerLoadedRequestedFriend);
    on<TriggerDoneLoadingRequestedFriendEvent>(
        _triggerDoneLoadingRequestedFriend);
    //...

    on<TriggerButtonNameEvent>(_triggerButtonNameEvent);
  }

  void _triggerInitialMyFriend(
      TriggerInitialMyFriendEvent event, Emitter<FriendState> emit) {
    emit(InitialMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }

  void _triggerLoadedMyFriend(
      TriggerLoadedMyFriendEvent event, Emitter<FriendState> emit) {
    emit(LoadedMyFriendStates(
      friendItem: event.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }

  void _triggerLoadingMyFriend(
      TriggerLoadingMyFriendEvent event, Emitter<FriendState> emit) {
    emit(LoadingMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }

  void _triggerDoneLoadingMyFriend(
      TriggerDoneLoadingMyFriendEvent event, Emitter<FriendState> emit) {
    emit(DoneLoadingMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }

  //requested event
  void _triggerInitialRequestedFriend(
      TriggerInitialRequestedFriendEvent event, Emitter<FriendState> emit) {
    emit(InitialMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }

  void _triggerLoadedRequestedFriend(
      TriggerLoadedRequestedFriendEvent event, Emitter<FriendState> emit) {
    emit(LoadedMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: event.requestedFriendItem,
    ));
  }

  void _triggerLoadingRequestedFriend(
      TriggerLoadingRequestedFriendEvent event, Emitter<FriendState> emit) {
    emit(LoadingMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }

  void _triggerDoneLoadingRequestedFriend(
      TriggerDoneLoadingRequestedFriendEvent event, Emitter<FriendState> emit) {
    emit(DoneLoadingMyFriendStates(
      friendItem: state.friendItem,
      friendItemOne: state.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }
  //requested event

  void _triggerButtonNameEvent(
      TriggerButtonNameEvent event, Emitter<FriendState> emit) {
    // print(event.btnName);
    // Map<String, String> btnName = {
    //   'token': event.friendToken,
    //   'btnName': event.btnName
    // };
    emit(DoneTriggerBtnNameStates(
      friendItem: state.friendItem,
      friendItemOne: event.friendItemOne,
      requestFriendItem: state.requestFriendItem,
    ));
  }
}
