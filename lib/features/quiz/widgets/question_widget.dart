import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/constants.dart';
import '../../../core/models/entities.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';

Widget questionWidget(
    BuildContext context, List<Question>? question, int? currentQuestionIndex) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        ' ${AppLocalizations.of(context)!.question} ${currentQuestionIndex! + 1}/${question!.length.toString()}',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
      const SizedBox(height: 10),
      question[currentQuestionIndex].text_bm != null
          ? Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Petikan"),
                        content: SizedBox(
                          // width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  question[currentQuestionIndex].text_bm!,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                // Add more widgets if needed
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Lihat Petikan",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      const SizedBox(height: 5),
      question[currentQuestionIndex].imageUrl != null
          ? Center(
              child: Container(
                width: 325.w,
                height: 200.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "${AppConstants.SERVER_UPLOADS}${question[currentQuestionIndex].imageUrl}"))),
              ),
            )
          : const SizedBox.shrink(),
      const SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          question[currentQuestionIndex].soalan_bm ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    ],
  );
}
