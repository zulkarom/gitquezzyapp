part of 'fontsize_bloc.dart';

abstract class FontsizeState extends Equatable {
  const FontsizeState(this.fontSize);
  final Size fontSize;

  @override
  List<Object> get props => [fontSize];
}

class FontsizeInitial extends FontsizeState {
  const FontsizeInitial(super.fontSize);
}

class FontsizeSet extends FontsizeState {
  const FontsizeSet(super.fontSize);
}

final Map<Size, Map<String, double>> textMap = {
  Size.small: {
    'bodyText1': 10.sp,
    'bodyText2': 12.sp,
    'headline6': 14.sp,
    'headline5': 16.sp,
    'headline4': 18.sp,
    'headline3': 20.sp,
    'headline2': 22.sp,
    'headline1': 24.sp,
  },
  Size.medium: {
    'bodyText1': 12.sp,
    'bodyText2': 14.sp,
    'headline6': 16.sp,
    'headline5': 20.sp,
    'headline4': 24.sp,
    'headline3': 24.sp,
    'headline2': 32.sp,
    'headline1': 64.sp,
  },
  Size.large: {
    'bodyText1': 14.sp,
    'bodyText2': 16.sp,
    'headline6': 20.sp,
    'headline5': 24.sp,
    'headline4': 26.sp,
    'headline3': 28.sp,
    'headline2': 34.sp,
    'headline1': 66.sp,
  },
  Size.xlarge: {
    'bodyText1': 16.sp,
    'bodyText2': 18.sp,
    'headline6': 22.sp,
    'headline5': 26.sp,
    'headline4': 28.sp,
    'headline3': 30.sp,
    'headline2': 36.sp,
    'headline1': 68.sp,
  },
};

enum Size {
  small,
  medium,
  large,
  xlarge,
}
