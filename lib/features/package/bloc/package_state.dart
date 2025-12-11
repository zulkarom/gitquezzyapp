part of 'package_bloc.dart';

class PackageState extends Equatable {
  final List<PackageItem> packageItem;
  final List<SubscribeItem> subscribeItem;
  final String name;
  const PackageState({
    this.packageItem = const <PackageItem>[],
    this.subscribeItem = const <SubscribeItem>[],
    this.name = "",
  });

  @override
  List<Object> get props => [packageItem, subscribeItem, name];

  PackageState copyWith({
    List<PackageItem>? packageItem,
    List<SubscribeItem>? subscribeItem,
    String? name,
  }) {
    return PackageState(
      packageItem: packageItem ?? this.packageItem,
      subscribeItem: subscribeItem ?? this.subscribeItem,
      name: name ?? this.name,
    );
  }
}

class PackageInitial extends PackageState {}
