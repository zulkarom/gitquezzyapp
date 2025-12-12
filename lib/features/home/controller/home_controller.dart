import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/api/subject_api.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';
import 'package:flutter_ta_plus/features/home/bloc/home_event.dart';

import '../../../global.dart';
import '../bloc/home_bloc.dart';

class HomeController {
  late BuildContext context;
  HomeController({required this.context});

  void init() {
    asynLoadSubjectData();
  }

  asynLoadSubjectData() async {
    context.read<HomeBloc>().add(const TriggerLoadingMySubjectsEvent());
    SubjectRequestEntity subjectRequestEntity = SubjectRequestEntity();
    //post package_id
    subjectRequestEntity.student_id =
        Global.storageService.getStudentProfile().id;
    subjectRequestEntity.package_id =
        int.parse(Global.storageService.getPackageId());

    var result = await SubjectAPI.subjectList(subjectRequestEntity);
    if (result.code == 200) {
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

      // print('subject items');
      // print(result.code);
      //save data to shared storage
      if (context.mounted) {
        // context
        //     .read<HomeBloc>()
        //     .add(TriggerLoadedMySubjectsEvent(result.data!, ansList));
        context
            .read<HomeBloc>()
            .add(TriggerLoadedMySubjectsEvent(result.data!));

        Future.delayed(const Duration(milliseconds: 10), () {
          context
              .read<HomeBloc>()
              .add(const TriggerDoneLoadingMySubjectsEvent());
        });
      }
    }
  }

  // asynLoadSubjectData() async {
  //   context.read<HomeBloc>().add(const TriggerLoadingMySubjectsEvent());
  //   SubjectRequestEntity subjectRequestEntity = SubjectRequestEntity();
  //   //post package_id
  //   subjectRequestEntity.id = int.parse(Global.storageService.getPackageId());
  //   var result = await SubjectAPI.subjectList(subjectRequestEntity);
  //   if (result.code == 200) {
  //     List<Ans> ansList = [];
  //     await AnswerFirestore.getLevelStarScoreBySubject(
  //       packageId: int.parse(Global.storageService.getPackageId()),
  //     ).then(
  //       (value) {
  //         for (var answer in value) {
  //           ansList.add(answer);
  //         }
  //       },
  //     );

  //     // print('subject items');
  //     // print(result.code);
  //     //save data to shared storage
  //     if (context.mounted) {
  //       context
  //           .read<HomeBloc>()
  //           .add(TriggerLoadedMySubjectsEvent(result.data!, ansList));

  //       Future.delayed(const Duration(milliseconds: 10), () {
  //         context
  //             .read<HomeBloc>()
  //             .add(const TriggerDoneLoadingMySubjectsEvent());
  //       });
  //     }
  //   }
  // }
}
