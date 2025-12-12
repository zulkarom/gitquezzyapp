import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quezzy_app/core/models/entities.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(const AvatarState()) {
    on<AvatarListEvent>(_avatarListItem);
    on<AvatarUrlEvent>(_avatarUrlEvent);
  }

  void _avatarListItem(AvatarListEvent event, Emitter<AvatarState> emit) {
    print("event.avatarItem.length");
    print(event.avatarItem.length);
    emit(state.copyWith(avatarItem: event.avatarItem));
  }

  void _avatarUrlEvent(AvatarUrlEvent event, Emitter<AvatarState> emit) {
    print("_avatarUrlEvent");
    emit(AvatarUrlState(
      avatarUrl: event.avatarUrl,
    ));
  }
}
