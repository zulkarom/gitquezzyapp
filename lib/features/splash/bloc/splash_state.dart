part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashInitSucceed extends SplashState {}

class NetworkUpdated extends SplashState {}

class SplashInitFailed extends SplashState {
  final Failure failure;

  const SplashInitFailed(this.failure);
}
