import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/models/entities.dart';
import '../../../routes/routes.dart';

class TimerDialog extends StatefulWidget {
  const TimerDialog({
    super.key,
    required this.roomDocId,
    required this.subjectItem,
    required this.levelItem,
    required this.topicItem,
  });
  final String roomDocId;
  final SubjectItem subjectItem;
  final LevelItem levelItem;
  final TopicItem topicItem;

  @override
  _TimerDialogState createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  int _secondsRemaining = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer(widget.roomDocId, widget.subjectItem, widget.levelItem,
        widget.topicItem);
  }

  void _startTimer(String roomDocId, SubjectItem subjectItem,
      LevelItem levelItem, TopicItem topicItem) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        Navigator.of(context).pop(); // Close the dialog
        _navigateToNextPage(roomDocId, subjectItem, levelItem, topicItem);
      }
    });
  }

  void _navigateToNextPage(String roomDocId, SubjectItem subjectItem,
      LevelItem levelItem, TopicItem topicItem) {
    // Navigate to another page or screen here
    Navigator.of(context)
        .pushReplacementNamed(AppRoutes.QZ_MULTIPLAYER, arguments: {
      "room_doc_id": roomDocId,
      "subjectItem": subjectItem,
      "levelItem": levelItem,
      "topicItem": topicItem,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quiz Start'),
      content: Text('In $_secondsRemaining seconds...'),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }
}
