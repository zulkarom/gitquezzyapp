part of 'level_bloc.dart';

abstract class LevelEvent extends Equatable {
  const LevelEvent();

  @override
  List<Object> get props => [];
}

class TriggerInitialMyLevelEvent extends LevelEvent {
  const TriggerInitialMyLevelEvent();
}

class TriggerLoadingMyLevelEvent extends LevelEvent {
  const TriggerLoadingMyLevelEvent();
}

class TriggerDoneLoadingMyLevelEvent extends LevelEvent {
  const TriggerDoneLoadingMyLevelEvent();
}

// class TriggerLoadedMyLevelEvent extends LevelEvent {
//   const TriggerLoadedMyLevelEvent(this.levelItem, this.levelResultItem);
//   final List<LevelItem> levelItem;
//   final List<LevelResultItem> levelResultItem;
// }

class TriggerLoadedMyLevelEvent extends LevelEvent {
  const TriggerLoadedMyLevelEvent(this.levelItem, this.answerList);
  final List<LevelItem> levelItem;
  final List<Ans> answerList;
}
