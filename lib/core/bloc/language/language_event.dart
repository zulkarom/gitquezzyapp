part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class SetLanguage extends LanguageEvent {
  final Type language;

  const SetLanguage(this.language);
}
