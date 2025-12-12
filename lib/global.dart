import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/bloc_observer.dart';
import 'core/services/storage/storage_service.dart';
import 'firebase_options.dart';

class Global {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage remoteMessage) async {
    print('Handling a background message ${remoteMessage.messageId}');
  }

  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();
    // Initialize Firebase for all platforms using FlutterFire options.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // For messaging, only run native Android-specific setup.
    if (!kIsWeb && Platform.isAndroid) {
      await FirebaseMessaging.instance.getInitialMessage();
    }

    // if (Platform.isAndroid) {
    //   FirebaseMessaging.onBackgroundMessage(
    //       _firebaseMessagingBackgroundHandler);
    // }

    // if (Platform.isAndroid) {
    //   MessagingService.init(FirebaseService());
    // }

    storageService = await StorageService().init();
  }

  static playerStatus(int status) {
    String textStatus;
    if (status == 10) {
      textStatus = 'Waiting';
    } else if (status == 20) {
      textStatus = 'Accept';
    } else if (status == 30) {
      textStatus = 'Ongoing';
    } else {
      textStatus = 'Completed';
    }
    return textStatus;
  }

  static playerAdmin(int isAdmin) {
    String textStatus;
    if (isAdmin == 1) {
      textStatus = 'Yes';
    } else {
      textStatus = 'No';
    }
    return textStatus;
  }

  static starCalculation(double totalMark) {
    double star = 0;
    totalMark = double.parse(totalMark.toStringAsFixed(6));
    // print("totalMark");
    // print(totalMark);
    if (totalMark == 0) {
      star = 0;
    } else if (totalMark > 0 && totalMark <= 0.166667) {
      star = 0.5;
    } else if (totalMark > 0.166667 && totalMark <= 0.333333) {
      star = 1;
    } else if (totalMark > 0.333333 && totalMark <= 0.5) {
      star = 1.5;
    } else if (totalMark > 0.5 && totalMark <= 0.666667) {
      star = 2;
    } else if (totalMark > 0.666667 && totalMark <= 0.833333) {
      star = 2.5;
    } else if (totalMark > 0.833333 && totalMark <= 1) {
      star = 3;
    }
    return star;
  }
  // static starCalculation(double totalMark) {
  //   double star = 0;
  //   print("totalMark");
  //   print(totalMark);
  //   if (totalMark == 0) {
  //     star = 0;
  //   } else if (totalMark > 0 && totalMark <= 0.17) {
  //     star = 0.5;
  //   } else if (totalMark > 0.17 && totalMark <= 0.33) {
  //     star = 1;
  //   } else if (totalMark > 0.33 && totalMark <= 0.5) {
  //     star = 1.5;
  //   } else if (totalMark > 0.5 && totalMark <= 0.67) {
  //     star = 2;
  //   } else if (totalMark > 0.67 && totalMark <= 0.83) {
  //     star = 2.5;
  //   } else if (totalMark > 0.83 && totalMark <= 1) {
  //     star = 3;
  //   }
  //   return star;
  // }
}
