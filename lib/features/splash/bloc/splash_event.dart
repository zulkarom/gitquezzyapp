part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class InitScreen extends SplashEvent {
  const InitScreen();
}

// class UpdateNetworkUrl extends SplashEvent {
//   final String domain;
//   const UpdateNetworkUrl(this.domain);
// }
