import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';
import 'package:quezzy_app/core/constant/app_dimensions.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import 'package:quezzy_app/features/home/bloc/home_bloc.dart';
import 'package:quezzy_app/features/profile/bloc/profile_bloc.dart';
import 'package:quezzy_app/features/topic/screens/topic_screen.dart';
import 'package:quezzy_app/features/more/controllers/more_controller.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../../core/constant/constants.dart';
import '../../../global.dart';
import '../../application/bloc/app_bloc.dart';
import '../../quiz_room/screens/invitation_list_screen.dart';
import '../bloc/home_state.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>.value(
      value: _homeBloc,
      child: const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatefulWidget {
  const _HomeScaffold();

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<_HomeScaffold> {
  // final IO.Socket _socket = IO.io('http://192.168.0.44:8000/',
  //     IO.OptionBuilder().setTransports(['websocket']).build());
  late final TextEditingController searchController;
  late HomeController _homeController;

  // _connectSocket() {
  //   _socket.onConnect((data) => print('Connection established'));
  //   _socket.onConnectError((data) => print('Connect Error: $data'));
  //   _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  // }

  // @override
  // void initState() {
  //   searchController = TextEditingController();
  //   // _connectSocket();
  //   // context.read<HomeBloc>().add(InitSocket());
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    searchController = TextEditingController();
    _homeController = HomeController(context: context);
    _homeController.init();
    MoreController(context: context).init();
    context.read<ProfileBloc>().add(TriggerInitialStudentItemEvent(
        Global.storageService.getStudentProfile()));

    super.didChangeDependencies();
  }

  List imgList = [
    'Bahasa Melayu',
    'English',
    'Matematik',
    'Sains',
  ];

  List<Icon> catIcons = const [
    Icon(Icons.category, color: Colors.white, size: 30),
    Icon(Icons.video_library, color: Colors.white, size: 30),
    Icon(Icons.assignment, color: Colors.white, size: 30),
    Icon(Icons.store, color: Colors.white, size: 30),
    Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
    Icon(Icons.emoji_events, color: Colors.white, size: 30),
  ];

  void removeStudentData() {
    context.read<AppBloc>().add(const TriggerAppEvent(0));
    Global.storageService.remove(AppConstants.STORAGE_STUDENT_PROFILE_KEY);
    // Global.storageService.remove(AppConstants.STORAGE_STUDENT_ID);
    Global.storageService.remove(AppConstants.STORAGE_TOPIC_KEY);
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocListener<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        // if (state is DoneLoadingMySubjectsStates) {
        //   context.read<ProfileBloc>().add(TriggerInitialStudentItemEvent(
        //       Global.storageService.getStudentProfile()));
        // }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is DoneLoadingMySubjectsStates) {
            return Scaffold(
              body: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: AppDimension().defaultPadding,
                      left: AppDimension().defaultPadding,
                      right: AppDimension().defaultPadding,
                      bottom: AppDimension().defaultPadding,
                    ),
                    decoration: BoxDecoration(
                        color: kLightPrimary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              AppDimension().kTwentyScreenPixel),
                          bottomRight: Radius.circular(
                              AppDimension().kTwentyScreenPixel),
                        )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // removeStudentData;
                                Scaffold.of(context).openDrawer();
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //     AppRoutes.MORE,
                                //     // arguments: {
                                //     //   "id": int.parse(
                                //     //       Global.storageService.getStudentId())
                                //     // },
                                //     (route) => false);

                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //     AppRoutes.APPLICATIONPARENT,
                                //     // arguments: {
                                //     //   "id": int.parse(
                                //     //       Global.storageService.getStudentId())
                                //     // },
                                //     (route) => false);
                              },
                              child: const Icon(
                                Icons.list_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const InvitationListScreen();
                                    },
                                  ),
                                );
                                // showDialog(
                                //   barrierDismissible: false,
                                //   context: context,
                                //   builder: (_) {
                                //     return Dialog(
                                //       backgroundColor: kLightAccent,
                                //       child: SizedBox(
                                //         width: MediaQuery.of(context)
                                //                 .size
                                //                 .width /
                                //             5, // Adjust the fraction as needed
                                //         height: MediaQuery.of(context)
                                //                 .size
                                //                 .height /
                                //             5, // Adjust the fraction as needed
                                //         child: InvitationMessage(
                                //           message: 'Haikal Invite',
                                //           subMessage:
                                //               'To play the quiz together',
                                //           acceptHandler: () {
                                //             Navigator.pop(context);
                                //           },
                                //           closeHandler: () {
                                //             Navigator.pop(context);
                                //           },
                                //           // rightHandler: () {
                                //           //   _quizRoomController.removePlayer(
                                //           //       friend.studentToken!);
                                //           //   Navigator.pop(context);
                                //           // },
                                //           acceptText: 'JOIN',
                                //           // rightText: 'YES',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );
                              },
                              child: const Icon(
                                Icons.notifications,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: AppDimension().kThirtyTwoScreenHeight),
                        Padding(
                          padding: const EdgeInsets.only(left: 3, bottom: 15),
                          child: Text(
                            'Hi, ${context.read<ProfileBloc>().state.studentItem?.name}',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              wordSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3, bottom: 0),
                          child: BlocBuilder<AppBloc, AppState>(
                            builder: (context, appState) {
                              final pkg = (appState.packageName.isNotEmpty
                                      ? appState.packageName
                                      : Global.storageService
                                          .getPackageName())
                                  .trim();
                              return Text(
                                pkg.isNotEmpty ? pkg : 'Nama Pakej',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  wordSpacing: 2,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: AppDimension().kThirtyTwoScreenHeight),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 5, bottom: 20),
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 55,
                        //   alignment: Alignment.center,
                        //   // decoration: BoxDecoration(
                        //   //   color: kLightField,
                        //   //   borderRadius: BorderRadius.circular(10),
                        //   // ),
                        //   child: CustomInputField(
                        //     controller: searchController,
                        //     textInputAction: TextInputAction.done,
                        //     inputType: TextInputType.emailAddress,
                        //     hint: 'Carian....',
                        //     fieldIcon: Icons.search,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Column(children: [
                      // GridView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 3,
                      //     childAspectRatio: 1.1,
                      //   ),
                      //   itemCount: catNames.length,
                      //   itemBuilder: (context, index) {
                      //     return Column(
                      //       children: [
                      //         Container(
                      //           height: 60,
                      //           width: 60,
                      //           decoration: BoxDecoration(
                      //               color: catColors[index], shape: BoxShape.circle),
                      //           child: Center(
                      //             child: catIcons[index],
                      //           ),
                      //         ),
                      //         SizedBox(height: AppDimension().kEightScreenHeight),
                      //         Text(
                      //           catNames[index],
                      //           style: TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w500,
                      //               color: Colors.black.withOpacity(0.6)),
                      //         )
                      //       ],
                      //     );
                      //   },
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.subject ?? 'Subject',
                            style: (Theme.of(context).textTheme.headlineSmall ??
                                    Theme.of(context).textTheme.titleMedium ??
                                    const TextStyle())
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)?.seeAll ?? 'See all',
                            style: (Theme.of(context).textTheme.headlineSmall ??
                                    Theme.of(context).textTheme.titleMedium ??
                                    const TextStyle())
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: AppDimension().kEightScreenHeight),
                      ListView.separated(
                        itemCount: state.subjectItem?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final subject = state.subjectItem![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TopicScreen(subject);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kLightField,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF4DB6E2),
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/images/categories/png/${imgList[index % imgList.length]}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        BlocBuilder<LanguageBloc, LanguageState>(
                                          builder: (context, stateLg) {
                                            return Text(
                                              stateLg.language.name == 'eng'
                                                  ? (subject.name_eng ?? '')
                                                  : (subject.name_bm ?? ''),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: (Theme.of(context)
                                                          .textTheme
                                                          .titleMedium ??
                                                      const TextStyle())
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${subject.totalTopic ?? 0} Topik',
                                          style: (Theme.of(context)
                                                      .textTheme
                                                      .bodySmall ??
                                                  const TextStyle())
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.55),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(
                                              "${(subject.progress ?? 0).round()}%",
                                              style: (Theme.of(context)
                                                          .textTheme
                                                          .bodySmall ??
                                                      const TextStyle())
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            ...List.generate(
                                              3,
                                              (starIndex) {
                                                double starRating = Global
                                                    .starCalculation(((subject.progress ??
                                                            0) /
                                                        100));
                                                if (starIndex <
                                                    starRating.floor()) {
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  );
                                                } else if (starIndex ==
                                                        starRating.floor() &&
                                                    starRating % 1 != 0) {
                                                  return const Icon(
                                                    Icons.star_half,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  );
                                                } else {
                                                  return const Icon(
                                                    Icons.star_border,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: AppDimension().kTwelveScreenHeight),
                    ]),
                  )
                ],
              ),
              // bottomNavigationBar: BottomNavigationBar(
              //   showUnselectedLabels: true,
              //   iconSize: 32,
              //   selectedItemColor: const Color(0xFF674AEF),
              //   selectedFontSize: 18,
              //   unselectedItemColor: Colors.grey,
              //   currentIndex: currentIndex, // Set the current selected index
              //   onTap: (int index) {
              //     setState(() {
              //       currentIndex = index; // Update the current selected index
              //     });

              //     // Handle click events for each item
              //     switch (index) {
              //       case 0: // Home
              //         // Handle the Home item click
              //         break;
              //       case 1: // Prestasi
              //         // Handle the Prestasi item click
              //         break;
              //       case 2: // Profile
              //         // Handle the Profile item click
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return const ProfileScreen();
              //             },
              //           ),
              //         );
              //         break;
              //       case 3: // Setting
              //         // Handle the Setting item click
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return const SettingScreen();
              //             },
              //           ),
              //         );
              //         break;
              //     }
              //   },
              //   items: const [
              //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              //     BottomNavigationBarItem(icon: Icon(Icons.stars), label: 'Prestasi'),
              //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
              //   ],
              // ),
            );
          } else if (state is LoadedMySubjectsStates) {
            return const SizedBox.shrink();
          } else if (state is LoadingMySubjectsStates) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
