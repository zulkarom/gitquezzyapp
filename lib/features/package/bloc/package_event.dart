part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class PackageListItem extends PackageEvent {
  const PackageListItem(this.packageItem);
  final List<PackageItem> packageItem;
}

class SubscribeListItem extends PackageEvent {
  const SubscribeListItem(this.subscribeItem);
  final List<SubscribeItem> subscribeItem;
}

class EmptySubscribeListItem extends PackageEvent {
  const EmptySubscribeListItem(this.subscribeItem);
  final List<SubscribeItem> subscribeItem;
}
