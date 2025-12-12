import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/api/package_api.dart';
import 'package:quezzy_app/core/api/subject_api.dart';
import 'package:quezzy_app/core/firebase_services/answer_firestore.dart';
import 'package:quezzy_app/core/models/entities.dart';
import 'package:quezzy_app/core/models/subscribe.dart';
import 'package:quezzy_app/features/home/bloc/home_event.dart';
import 'package:quezzy_app/features/performance/bloc/performance_bloc.dart';

import '../../../global.dart';

class PerformanceController {
  late BuildContext context;
  PerformanceController({required this.context});

  void init() {
    asynLoadPerformanceData();
  }

  asynLoadPerformanceData() async {
    context
        .read<PerformanceBloc>()
        .add(const TriggerLoadingMyPerformanceEvent());
    SubscribeRequestEntity subscribeRequestEntity = SubscribeRequestEntity();
    //post package_id
    subscribeRequestEntity.student_id =
        Global.storageService.getStudentProfile().id!;
    //subscribeRequestEntity.is_payment = 0;
    subscribeRequestEntity.package_id =
        int.parse(Global.storageService.getPackageId());
    var result = await PackageAPI.subscribeOne(subscribeRequestEntity);
    if (result.code == 200) {
      print(result.data!.first);
      // List<Ans> ansList = [];
      // await AnswerFirestore.getLevelStarScoreBySubject(
      //   packageId: int.parse(Global.storageService.getPackageId()),
      // ).then(
      //   (value) {
      //     for (var answer in value) {
      //       ansList.add(answer);
      //     }
      //   },
      // );

      if (context.mounted) {
        context
            .read<PerformanceBloc>()
            .add(TriggerLoadedMyPerformanceEvent(result.data!.first));

        Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<PerformanceBloc>()
              .add(const TriggerDoneLoadingMyPerformanceEvent());
        });
      }
    }
  }
}
