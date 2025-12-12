import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/parent_application/screen/app_parent_screen.dart';
import 'package:quezzy_app/features/parent_application/bloc/app_parent_bloc.dart';
import 'package:quezzy_app/features/auth/bloc/login/login_bloc.dart';
import 'package:quezzy_app/features/auth/screens/login_screen.dart';
import 'package:quezzy_app/features/auth/screens/register_screen.dart';
import 'package:quezzy_app/features/friend/bloc/friend_blocs.dart';
import 'package:quezzy_app/features/friend/screens/friend_screen.dart';
import 'package:quezzy_app/features/friend/screens/request_action_screen.dart';
import 'package:quezzy_app/features/more/bloc/more_bloc.dart';
import 'package:quezzy_app/features/more/screens/more_screen.dart';
import 'package:quezzy_app/features/package/bloc/package_bloc.dart';
import 'package:quezzy_app/features/quiz/individual/bloc/individual_quiz_bloc.dart';
import 'package:quezzy_app/features/quiz/individual/bloc/individual_result_bloc.dart';
import 'package:quezzy_app/features/quiz/individual/screen/individual_quiz_screen.dart';
import 'package:quezzy_app/features/quiz/individual/screen/individual_result_screen.dart';
import 'package:quezzy_app/features/quiz/multiplayer/bloc/multiplayer_quiz_bloc.dart';
import 'package:quezzy_app/features/quiz/multiplayer/screen/multiplayer_quiz_screen.dart';
import 'package:quezzy_app/features/quiz/multiplayer/screen/multiplayer_result_screen.dart';
import 'package:quezzy_app/features/quiz_room/bloc/quiz_room_bloc.dart';
import 'package:quezzy_app/features/quiz_room/screens/room_screen.dart';
import 'package:quezzy_app/features/splash/bloc/splash_bloc.dart';
import 'package:quezzy_app/features/splash/screens/splash_screen.dart';
import 'package:quezzy_app/features/student/screens/forget_pin_screen.dart';
import 'package:quezzy_app/features/student/screens/student_screen.dart';
import 'package:quezzy_app/features/welcome/screens/bloc/welcome_bloc.dart';
import 'package:quezzy_app/features/welcome/screens/welcome_screen.dart';
import 'package:quezzy_app/routes/routes.dart';
import '../features/application/application_page.dart';
import '../features/application/bloc/app_bloc.dart';
import '../features/auth/bloc/register/register_bloc.dart';
import '../features/messages/chat/bloc/chat_blocs.dart';
import '../features/messages/chat/screens/chat_screen.dart';
import '../features/package/screens/package_list_screen.dart';
import '../features/package/screens/package_selected_screen.dart';
import '../features/question/bloc/question_bloc.dart';
import '../features/question/screens/question_screen.dart';
import '../features/quiz/multiplayer/bloc/multiplayer_result_bloc.dart';
import '../features/student/bloc/student_bloc.dart';
import '../features/student/screens/student_avatar_screen.dart';
import '../features/student/screens/student_edit_screen.dart';
import '../features/student/screens/student_list_edit_screen.dart';
import '../features/student/screens/student_list_screen.dart';
import '../global.dart';

class AppPages {
  // static final AuthRepository authRepository = AuthRepository();
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.SPLASH,
        page: const SplashScreen(),
        bloc: BlocProvider(
          create: (_) => SplashBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const WelcomeScreen(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const LoginScreen(),
        bloc: BlocProvider(
          create: (_) => LoginBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const SignUpScreen(),
        bloc: BlocProvider(
          create: (_) => RegisterBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLICATIONPARENT,
        page: const ApplicationParentScreen(),
        bloc: BlocProvider(
          create: (_) => AppParentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.MORE,
        page: const MoreScreen(),
        bloc: BlocProvider(
          create: (_) => MoreBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const ApplicationPage(),
        bloc: BlocProvider(
          create: (_) => AppBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.STUDENT,
        page: const StudentListScreen(),
        bloc: BlocProvider(
          create: (_) => StudentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.STUDENT_AVATAR,
        page: const StudentAvatarScreen(),
        bloc: BlocProvider(
          create: (_) => StudentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.STUDENT_LIST_EDIT,
        page: const StudentListEditScreen(),
        bloc: BlocProvider(
          create: (_) => StudentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.STUDENT_ADD,
        page: const StudentScreen(),
        bloc: BlocProvider(
          create: (_) => StudentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.STUDENT_EDIT,
        page: const StudentEditScreen(),
        bloc: BlocProvider(
          create: (_) => StudentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.STUDENT_FORGOT_PIN,
        page: const ForgetPinScreen(),
        bloc: BlocProvider(
          create: (_) => StudentBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PACKAGE_LIST,
        page: const PackageListScreen(),
        bloc: BlocProvider(
          create: (_) => PackageBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PACKAGE_SELECTED,
        page: const PackageSelectedScreen(),
        bloc: BlocProvider(
          create: (_) => PackageBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.QUESTION,
        page: const QuestionScreen(),
        bloc: BlocProvider(
          create: (_) => QuestionBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.CHAT,
        page: const ChatScreen(),
        bloc: BlocProvider(
          create: (_) => ChatBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.FRIEND,
        page: const FriendScreen(),
        bloc: BlocProvider(
          create: (_) => FriendBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.FRIEND_REQUEST,
        page: const RequestActionScreen(),
        bloc: BlocProvider(
          create: (_) => FriendBlocs(),
        ),
      ),
      // PageEntity(
      //   route: AppRoutes.QZ_FRIEND_LIST,
      //   page: const FriendListScreen(),
      //   bloc: BlocProvider(
      //     create: (_) => QuizRoomBloc(),
      //   ),
      // ),
      PageEntity(
        route: AppRoutes.QZ_ROOM,
        page: const RoomScreen(),
        bloc: BlocProvider(
          create: (_) => QuizRoomBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.QZ_INDIVIDUAL,
        page: const IndividualQuizScreen(),
        bloc: BlocProvider(
          create: (_) => IndividualQuizBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.QZ_INDIVIDUAL_RESULT,
        page: const IndividualResultScreen(),
        bloc: BlocProvider(
          create: (_) => IndividualResultBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.QZ_MULTIPLAYER,
        page: const MultiplayerQuizScreen(),
        bloc: BlocProvider(
          create: (_) => MultiplayerQuizBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.QZ_MULTIPLAYER_RESULT,
        page: const MultiplayerResultScreen(),
        bloc: BlocProvider(
          create: (_) => MultiplayerResultBloc(),
        ),
      ),
    ];
  }

  //return all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  // a modal that covers entire screen as we click on navigator object
  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      //check for route name matching when navigator gets triggered.
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        // print("valid route name ${settings.name}");
        // print("first log");
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        //print(result.first.route);
        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLoggedin = Global.storageService.getIsLoggedIn();
          if (isLoggedin) {
            bool isPackage = Global.storageService.getIsPackage();

            if (isPackage) {
              return MaterialPageRoute(
                  builder: (_) => const ApplicationPage(), settings: settings);
            } else {
              return MaterialPageRoute(
                  builder: (_) => const ApplicationParentScreen(),
                  settings: settings);
            }
          }
          return MaterialPageRoute(
              builder: (_) => const LoginScreen(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    // print("invalid route name ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const LoginScreen(), settings: settings);
  }
}

//unify BlocProvider and routes and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
