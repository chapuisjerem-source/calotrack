/// DTO représentant un produit Open Food Facts.
/// On reste permissif : beaucoup de champs sont optionnels côté API.
class OffProductDto {
  final String? code;
  final String? name;
  final String? brand;
  final double? kcalPer100g;
  final double? proteinPer100g;
  final double? carbsPer100g;
  final double? fatPer100g;

  const OffProductDto({
    required this.code,
    required this.name,
    required this.brand,
    required this.kcalPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
  });

  bool get hasNutriments =>
      kcalPer100g != null &&
      proteinPer100g != null &&
      carbsPer100g != null &&
      fatPer100g != null;

  factory OffProductDto.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>? ?? {};

    final name = (product['product_name_fr'] as String?)?.trim().isNotEmpty ==
            true
        ? product['product_name_fr'] as String
        : (product['product_name'] as String?) ?? '';

    final brand = (product['brands'] as String?)?.split(',').first.trim();
    final nutr =
        (product['nutriments'] as Map<String, dynamic>?) ?? const {};

    double? asDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    // kcal : on privilégie "energy-kcal_100g", sinon on convertit kJ
    double? kcal = asDouble(nutr['energy-kcal_100g']);
    if (kcal == null) {
      final kj = asDouble(nutr['energy_100g']);
      if (kj != null) kcal = kj / 4.184;
    }

    return OffProductDto(
      code: json['code'] as String?,
      name: name,
      brand: brand,
      kcalPer100g: kcal,
      proteinPer100g: asDouble(nutr['proteins_100g']),
      carbsPer100g: asDouble(nutr['carbohydrates_100g']),
      fatPer100g: asDouble(nutr['fat_100g']),
    );
  }
}
