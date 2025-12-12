// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get subject => 'Subject';

  @override
  String get seeAll => 'See All';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get displaySetting => 'Display Settings';

  @override
  String get theme => 'Theme';

  @override
  String get fontSize => 'Font Size';

  @override
  String get math => 'Mathematic';

  @override
  String get science => 'Science';

  @override
  String get listTopic => 'List of Topics';

  @override
  String get noResult => 'No results found';

  @override
  String get question => 'Question';

  @override
  String listSubject(String username, Object subjectName) {
    return '$subjectName';
  }
}
