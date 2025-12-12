// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get subject => 'Subjek';

  @override
  String get seeAll => 'Lihat Semua';

  @override
  String get language => 'Bahasa';

  @override
  String get settings => 'Tetapan';

  @override
  String get displaySetting => 'Tetapan Paparan';

  @override
  String get theme => 'Tema';

  @override
  String get fontSize => 'Saiz Huruf';

  @override
  String get math => 'Matematik';

  @override
  String get science => 'Sains';

  @override
  String get listTopic => 'Senarai Topik';

  @override
  String get noResult => 'Tiada hasil ditemui';

  @override
  String get question => 'Soalan';

  @override
  String listSubject(String username, Object subjectName) {
    return '$subjectName';
  }
}
