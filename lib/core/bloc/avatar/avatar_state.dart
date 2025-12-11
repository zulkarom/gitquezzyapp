part of 'avatar_bloc.dart';

class AvatarState extends Equatable {
  final List<AvatarItem> avatarItem;
  final String avatarUrl;

  const AvatarState({
    this.avatarItem = const <AvatarItem>[],
    this.avatarUrl = "",
  });

  @override
  List<Object> get props => [avatarItem, avatarUrl];

  AvatarState copyWith({
    List<AvatarItem>? avatarItem,
    String? avatarUrl,
  }) {
    return AvatarState(
      avatarItem: avatarItem ?? this.avatarItem,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class AvatarUrlState extends AvatarState {
  const AvatarUrlState({required super.avatarUrl});
}
