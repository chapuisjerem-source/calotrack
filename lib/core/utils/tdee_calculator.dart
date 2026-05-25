enum Sex { male, female }

enum ActivityLevel {
  sedentary(1.2, 'Sédentaire', 'Peu ou pas d\'activité'),
  light(1.375, 'Léger', '1-3 séances / semaine'),
  moderate(1.55, 'Modéré', '3-5 séances / semaine'),
  active(1.725, 'Actif', '6-7 séances / semaine'),
  veryActive(1.9, 'Très actif', 'Sport intense + travail physique');

  final double multiplier;
  final String label;
  final String description;
  const ActivityLevel(this.multiplier, this.label, this.description);
}

enum Goal {
  lose(-500, 'Perdre du poids', '≈ 0,5 kg / semaine'),
  maintain(0, 'Maintenir', 'Stabilisation du poids'),
  gain(300, 'Prendre du poids', '≈ 0,3 kg / semaine');

  final int calorieAdjustment;
  final String label;
  final String description;
  const Goal(this.calorieAdjustment, this.label, this.description);
}

class Macros {
  final int protein; // grammes
  final int carbs;
  final int fat;
  const Macros({
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}

class TdeeCalculator {
  /// Mifflin-St Jeor
  static double calculateBMR({
    required Sex sex,
    required int age,
    required double weightKg,
    required double heightCm,
  }) {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    return sex == Sex.male ? base + 5 : base - 161;
  }

  static int calculateTDEE({
    required Sex sex,
    required int age,
    required double weightKg,
    required double heightCm,
    required ActivityLevel activity,
  }) {
    final bmr = calculateBMR(
      sex: sex,
      age: age,
      weightKg: weightKg,
      heightCm: heightCm,
    );
    return (bmr * activity.multiplier).round();
  }

  static int calculateDailyGoal({
    required int tdee,
    required Goal goal,
  }) {
    final target = tdee + goal.calorieAdjustment;
    // Seuil minimal de sécurité
    return target < 1200 ? 1200 : target;
  }

  /// Répartition macros :
  ///  - Protéines : 2 g / kg
  ///  - Lipides   : 1 g / kg
  ///  - Glucides  : reste des calories
  static Macros calculateMacros({
    required int dailyCalories,
    required double weightKg,
  }) {
    final protein = (2 * weightKg).round();
    final fat = (1 * weightKg).round();
    final kcalFromPF = protein * 4 + fat * 9;
    final kcalForCarbs = dailyCalories - kcalFromPF;
    final carbs = (kcalForCarbs / 4).round().clamp(0, 100000);
    return Macros(protein: protein, carbs: carbs.toInt(), fat: fat);
  }
}
