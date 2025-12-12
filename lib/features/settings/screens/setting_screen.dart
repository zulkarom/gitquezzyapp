import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';
import 'package:quezzy_app/core/bloc/language/language_bloc.dart';

import '../../../core/bloc/fontsize/fontsize_bloc.dart';
import '../../../core/bloc/theme/theme_bloc.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../widget/change_theme_switch.dart';
import '../widget/option_card.dart';

///Screen for setting
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context)?.settings ?? 'Settings',
            // leading: [
            //   Center(
            //     child: CustomIconButton(
            //       onTap: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: Icon(
            //         Icons.arrow_back_ios_rounded,
            //         size: AppDimension().kTwentyScreenPixel,
            //         color:
            //             Theme.of(context).appBarTheme.actionsIconTheme!.color,
            //       ),
            //     ),
            //   ),
            // ],
          ),
          ConstrainedBox(
            constraints: AppDimension().kTabletMaxWidth,
            child: SingleChildScrollView(
              padding: AppDimension().kPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)?.displaySetting ?? 'Display setting',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: AppDimension().kTwelveScreenHeight,
                  ),
                  OptionCard(
                    svgIconPath: 'assets/images/settings/svg/theme.svg',
                    optionName: AppLocalizations.of(context)?.theme ?? 'Theme',
                    action: BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        return ChangeThemeSwitch(
                            value: state.currentTheme.brightness ==
                                Brightness.dark,
                            onChanged: (_) {
                              BlocProvider.of<ThemeBloc>(context).add(
                                ToggleTheme(),
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppDimension().kSixteenScreenHeight,
                  ),
                  OptionCard(
                    svgIconPath: 'assets/images/settings/svg/language.svg',
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.language ?? 'Language',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    action: Expanded(
                      child: BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, state) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<Type>(
                              isExpanded: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                              value: state.language,
                              onChanged: (Type? language) {
                                context
                                    .read<LanguageBloc>()
                                    .add(SetLanguage(language!));
                              },
                              items: [
                                DropdownMenuItem<Type>(
                                  value: Type.eng,
                                  onTap: () {},
                                  child: const Text(
                                    'English',
                                  ),
                                ),
                                DropdownMenuItem<Type>(
                                  value: Type.ms,
                                  onTap: () {},
                                  child: const Text(
                                    'Bahasa Melayu',
                                  ),
                                ),
                              ],
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: AppDimension().kTwentyScreenPixel,
                              borderRadius: AppDimension().kCardBorderRadius,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppDimension().kSixteenScreenHeight,
                  ),
                  // OptionCard(
                  //   svgIconPath: 'assets/images/settings/svg/date_time.svg',
                  //   title: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Date time format',
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headline6!
                  //             .copyWith(
                  //               color: Theme.of(context).colorScheme.secondary,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //       ),
                  //       BlocBuilder<DateTimeBloc, DateTimeState>(
                  //         builder: (context, state) {
                  //           return Text(
                  //             state.dateTimeFormat.example,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText1!
                  //                 .copyWith(
                  //                   color:
                  //                       Theme.of(context).colorScheme.secondary,
                  //                 ),
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  //   action: Expanded(
                  //     child: BlocBuilder<DateTimeBloc, DateTimeState>(
                  //       builder: (context, state) {
                  //         return DropdownButtonHideUnderline(
                  //           child: DropdownButton<DateTimeFormat>(
                  //             isExpanded: true,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   color: Theme.of(context).primaryColor,
                  //                 ),
                  //             value: state.dateTimeFormat,
                  //             hint: const Text('Point name'),
                  //             onChanged: (DateTimeFormat? dateTimeFormat) {
                  //               context
                  //                   .read<DateTimeBloc>()
                  //                   .add(SetDateTime(dateTimeFormat!));
                  //             },
                  //             items: List.generate(
                  //               DateTimeFormat.values.length,
                  //               (index) => DropdownMenuItem<DateTimeFormat>(
                  //                 value: DateTimeFormat.values[index],
                  //                 onTap: () {},
                  //                 child: Text(
                  //                     DateTimeFormat.values[index].displayName),
                  //               ),
                  //             ),
                  //             icon:
                  //                 const Icon(Icons.keyboard_arrow_down_rounded),
                  //             iconSize: AppDimension().kTwentyScreenPixel,
                  //             borderRadius: AppDimension().kCardBorderRadius,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: AppDimension().kSixteenScreenHeight,
                  // ),
                  BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, languageState) {
                      return BlocBuilder<FontsizeBloc, FontsizeState>(
                        builder: (context, state) {
                          String fsName = state.fontSize.name;
                          return Column(
                            children: [
                              OptionCard(
                                svgIconPath:
                                    'assets/images/settings/svg/text.svg',
                                optionName:
                                    AppLocalizations.of(context)?.fontSize ?? 'Font size',
                                action: Text(
                                  languageState.language.name == 'ms'
                                      ? fsName == 'small'
                                          ? 'kecil'
                                          : fsName == 'medium'
                                              ? 'medium'
                                              : fsName == 'large'
                                                  ? 'besar'
                                                  : 'xbesar'
                                      : fsName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: AppDimension().kSixteenScreenHeight,
                              ),
                              Slider(
                                value: Size.values
                                    .indexOf(state.fontSize)
                                    .toDouble(),
                                divisions: Size.values.length - 1,
                                max: Size.values.length - 1,
                                // label: state.fontSize.name,
                                onChanged: (value) {
                                  BlocProvider.of<FontsizeBloc>(context).add(
                                      SetFontSize(Size.values[value.toInt()]));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
