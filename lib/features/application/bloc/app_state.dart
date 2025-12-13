part of 'app_bloc.dart';

class AppState {
  final int index;
  final String packageName;
  const AppState({this.index = 0, this.packageName = ''});
}

class AppInitial extends AppState {}
