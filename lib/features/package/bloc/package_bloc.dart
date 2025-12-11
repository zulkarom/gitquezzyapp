import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/entities.dart';
import '../../../core/models/subscribe.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageBloc() : super(const PackageState()) {
    on<PackageListItem>(_packageListItem);
    on<SubscribeListItem>(_subscribeListItem);
    on<EmptySubscribeListItem>(_emptySubscribeListItem);
  }

  void _packageListItem(PackageListItem event, Emitter<PackageState> emit) {
    emit(state.copyWith(packageItem: event.packageItem));
  }

  void _subscribeListItem(SubscribeListItem event, Emitter<PackageState> emit) {
    emit(state.copyWith(subscribeItem: event.subscribeItem));
  }

  void _emptySubscribeListItem(
      EmptySubscribeListItem event, Emitter<PackageState> emit) {
    emit(state.copyWith(subscribeItem: event.subscribeItem));
  }
}
