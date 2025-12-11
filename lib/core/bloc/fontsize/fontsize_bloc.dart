import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'fontsize_event.dart';
part 'fontsize_state.dart';

class FontsizeBloc extends HydratedBloc<FontsizeEvent, FontsizeState> {
  FontsizeBloc() : super(const FontsizeInitial(Size.medium)) {
    on<SetFontSize>((event, emit) {
      return emit(FontsizeSet(event.fontsize));
    });
  }

  @override
  FontsizeState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return FontsizeSet(Size.values[json['index'] as int]);
    }
    return const FontsizeSet(Size.medium);
  }

  @override
  Map<String, dynamic>? toJson(FontsizeState state) {
    try {
      return {
        'index': state.fontSize.index,
      };
    } catch (e) {
      return {};
    }
  }
}
