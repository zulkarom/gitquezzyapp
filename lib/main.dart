import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'features/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/bloc/data/cubit/data_cubit.dart';
import 'package:quezzy_app/features/parent_profile/bloc/parent_profile_bloc.dart';
import 'package:quezzy_app/features/profile/bloc/profile_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:quezzy_app/core/bloc/language/language_bloc.dart';
import 'package:quezzy_app/routes/names.dart';

import 'core/bloc/date_time/date_time_bloc.dart';
import 'core/bloc/fontsize/fontsize_bloc.dart';
import 'core/bloc/theme/theme_bloc.dart';
import 'core/constant/app_dimensions.dart';
import 'core/services/socket_io/socket_io_service.dart';
import 'features/l10n/l10n.dart';
import 'global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  // set orientation to potrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // buffer time for potrait mode to initialise to prevent app run
  // without correct font-size and dimensions
  await Future.delayed(const Duration(seconds: 2));

  SocketIoService();

  // persistance storage initialisation (web-compatible)
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory.web,
  );
  // Bloc.observer = MyBlocObserver();
  await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, device) {
      return ScreenUtilInit(
        designSize:
            MediaQueryData.fromView(WidgetsBinding.instance.window).size,
        rebuildFactor: (_, __) => false, // prevent screen from rebuilding
        builder: (context, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(
                lazy: false,
                create: (BuildContext context) => ThemeBloc(),
              ),
              BlocProvider<FontsizeBloc>(
                lazy: false,
                create: (BuildContext context) => FontsizeBloc(),
              ),
              BlocProvider(
                lazy: false,
                create: (context) => DateTimeBloc(),
              ),
              BlocProvider<LanguageBloc>(
                lazy: false,
                create: (BuildContext context) => LanguageBloc(),
              ),
              BlocProvider(
                lazy: false,
                create: (_) => DataCubit(),
              ),
              BlocProvider<ProfileBloc>(
                lazy: false,
                create: (context) => ProfileBloc(),
              ),
              BlocProvider<ParentProfileBloc>(
                lazy: false,
                create: (context) => ParentProfileBloc(),
              ),
              // BlocProvider<IndividualResultBloc>(
              //   lazy: false,
              //   create: (context) => IndividualResultBloc(),
              // ),
              ...AppPages.allBlocProviders(context)
            ],
            child: const _App(),
          );
        },
      );
    });
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  @override
  void initState() {
    // when app initialise, set status bar brightness
    // if (context.read<ThemeBloc>().state.currentTheme.brightness ==
    //     Brightness.light) {
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // } else {
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // only initialise the app dimension when it is potrait mode to prevent
    // undesired font size and dimensions
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      AppDimension();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        // for toggling theme, to be implemented later

        if (state.currentTheme.brightness == Brightness.light) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        }
      },
      builder: (context, state) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            return BlocBuilder<FontsizeBloc, FontsizeState>(
              builder: (context, fontState) {
                return MaterialApp(
                    builder: EasyLoading.init(),
                    // BlocBuilder<DateTimeBloc, DateTimeState>(
                    //   builder: (context, state) {
                    //     return MediaQuery(
                    //         data: MediaQuery.of(context).copyWith(
                    //           alwaysUse24HourFormat: state.dateTimeFormat ==
                    //                   DateTimeFormat
                    //                       .twentyFourHourLongDate ||
                    //               state.dateTimeFormat ==
                    //                   DateTimeFormat
                    //                       .twentyFourHourShortDate,
                    //           textScaleFactor: 1,
                    //         ),
                    //         child: child!);
                    //   },
                    // ),
                    title: 'Quezzy',
                    color: Colors.black,
                    debugShowCheckedModeBanner: false,
                    theme: state.currentTheme.copyWith(
                      textTheme: state.currentTheme.textTheme.copyWith(
                        displayLarge: state.currentTheme.textTheme.displayLarge!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['headline1']),
                        displayMedium: state
                            .currentTheme.textTheme.displayMedium!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['headline2']),
                        displaySmall: state.currentTheme.textTheme.displaySmall!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['headline3']),
                        headlineMedium: state
                            .currentTheme.textTheme.headlineMedium!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['headline4']),
                        headlineSmall: state
                            .currentTheme.textTheme.headlineSmall!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['headline5']),
                        titleLarge: state.currentTheme.textTheme.titleLarge!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['headline6']),
                        bodyLarge: state.currentTheme.textTheme.bodyLarge!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['bodyText1']),
                        bodyMedium: state.currentTheme.textTheme.bodyMedium!
                            .copyWith(
                                fontSize:
                                    textMap[fontState.fontSize]!['bodyText2']),
                      ),
                    ),
                    supportedLocales: L10n.all,
                    locale: Locale(languageState.language.name),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    // initialRoute: AppPages.GenerateRouteSettings.sp,
                    onGenerateRoute: AppPages.generateRouteSettings);
              },
            );
          },
        );
      },
    );
  }
}
