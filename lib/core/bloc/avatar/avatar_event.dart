part of 'avatar_bloc.dart';

class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object> get props => [];
}

class AvatarListEvent extends AvatarEvent {
  const AvatarListEvent(this.avatarItem);
  final List<AvatarItem> avatarItem;
}

class AvatarUrlEvent extends AvatarEvent {
  final String avatarUrl;
  const AvatarUrlEvent(this.avatarUrl);
}
