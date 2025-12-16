import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/constants.dart';
import '../../../core/models/entities.dart';
import 'package:quezzy_app/features/l10n/app_localization.dart';

String _truncateWords(String text, int maxWords) {
  final words = text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
  if (words.length <= maxWords) return text.trim();
  return '${words.take(maxWords).join(' ')}...';
}

Widget questionWidget(
    BuildContext context, List<Question>? question, int? currentQuestionIndex) {
  final l10n = AppLocalizations.of(context);
  final questions = question ?? const <Question>[];
  final index = currentQuestionIndex ?? 0;
  if (questions.isEmpty || index < 0 || index >= questions.length) {
    return const SizedBox.shrink();
  }
  final passage = questions[index].text_bm;
  final hasPassage = passage != null && passage.trim().isNotEmpty;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        ' ${l10n?.question ?? ''} ${index + 1}/${questions.length.toString()}',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
      const SizedBox(height: 10),
      hasPassage
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _truncateWords(passage, 30),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Petikan"),
                            content: SizedBox(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      passage,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
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
                    child: const Text('Baca Selanjutnya'),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
      const SizedBox(height: 5),
      questions[index].imageUrl != null
          ? Center(
              child: Container(
                width: 325.w,
                height: 200.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "${AppConstants.SERVER_UPLOADS}${questions[index].imageUrl}"))),
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
          questions[index].soalan_bm ?? '',
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
