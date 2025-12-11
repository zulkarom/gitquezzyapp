part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState(this.language);
  final Type language;

  @override
  List<Object> get props => [language];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.language);
}

class LanguageSet extends LanguageState {
  const LanguageSet(super.language);
}

final Map<Type, Map<String, String>> languageMap = {
  Type.eng: {
    'subject': 'subject',
  },
  Type.ms: {
    'subjek': 'subject',
  },
};

enum Type {
  eng,
  ms,
}
