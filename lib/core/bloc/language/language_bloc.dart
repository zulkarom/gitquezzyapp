import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitial(Type.ms)) {
    on<SetLanguage>((event, emit) {
      return emit(LanguageSet(event.language));
    });
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return LanguageSet(Type.values[json['index'] as int]);
    }
    return const LanguageSet(Type.ms);
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    try {
      return {
        'index': state.language.index,
      };
    } catch (e) {
      return {};
    }
  }
}
