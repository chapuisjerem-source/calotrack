class ApiEndpoints {
  static const String openFoodFactsBase = 'https://world.openfoodfacts.org';

  static String product(String barcode) =>
      '$openFoodFactsBase/api/v2/product/$barcode.json';

  static const String userAgent = 'CaloTrack/1.0.0 (Flutter; contact: dev@calotrack.app)';
}
