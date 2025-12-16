
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/api/package_api.dart';
import 'package:quezzy_app/core/models/subscribe.dart';
import 'package:quezzy_app/features/performance/bloc/performance_bloc.dart';

import '../../../global.dart';

class PerformanceController {
  late BuildContext context;
  final int? studentId;
  PerformanceController({required this.context, this.studentId});

  void init() {
    asynLoadPerformanceData();
  }

  asynLoadPerformanceData() async {
    context
        .read<PerformanceBloc>()
        .add(const TriggerLoadingMyPerformanceEvent());
    SubscribeRequestEntity subscribeRequestEntity = SubscribeRequestEntity();
    //post package_id
    final int? resolvedStudentId =
        studentId ?? Global.storageService.getStudentProfile().id;
    if (resolvedStudentId == null) {
      if (context.mounted) {
        context
            .read<PerformanceBloc>()
            .add(const TriggerDoneLoadingMyPerformanceEvent());
      }
      return;
    }

    subscribeRequestEntity.student_id = resolvedStudentId;
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
