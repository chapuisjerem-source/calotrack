import 'package:intl/intl.dart';

class AppDateUtils {
  /// Retourne la date sans l'heure (minuit)
  static DateTime dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Aujourd'hui sans l'heure
  static DateTime today() => dayOnly(DateTime.now());

  /// Format "lundi 21 avril"
  static String formatDay(DateTime d) {
    return DateFormat('EEEE d MMMM', 'fr_FR').format(d);
  }

  /// "Aujourd'hui", "Hier", "Demain" ou date formatée
  static String relativeDay(DateTime d) {
    final t = today();
    final target = dayOnly(d);
    final diff = target.difference(t).inDays;
    if (diff == 0) return "Aujourd'hui";
    if (diff == -1) return 'Hier';
    if (diff == 1) return 'Demain';
    return formatDay(d);
  }

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
