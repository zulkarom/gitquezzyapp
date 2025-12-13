part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class TriggerAppEvent extends AppEvent {
  final int index;
  const TriggerAppEvent(this.index) : super();
}

class PackageChanged extends AppEvent {
  final String packageName;
  const PackageChanged(this.packageName) : super();
}
