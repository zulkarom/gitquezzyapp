part of 'level_bloc.dart';

abstract class LevelState extends Equatable {
  final List<LevelItem>? levelItem;
  final List<LevelResultItem>? levelResultItem;
  final List<dynamic>? tempLevel;
  const LevelState({
    this.levelItem,
    this.levelResultItem,
    this.tempLevel,
  });

  @override
  List<Object?> get props => [levelItem, levelResultItem, tempLevel];
}

class InitialMyLevelStates extends LevelState {
  const InitialMyLevelStates(
      {required super.levelItem,
      required super.levelResultItem,
      required super.tempLevel});
}

class LoadingMyLevelStates extends LevelState {
  const LoadingMyLevelStates(
      {required super.levelItem,
      required super.levelResultItem,
      required super.tempLevel});
}

class DoneLoadingMyLevelStates extends LevelState {
  const DoneLoadingMyLevelStates(
      {required super.levelItem,
      required super.levelResultItem,
      required super.tempLevel});
}

class LoadedMyLevelStates extends LevelState {
  const LoadedMyLevelStates(
      {required super.levelItem,
      required super.levelResultItem,
      required super.tempLevel});
}
