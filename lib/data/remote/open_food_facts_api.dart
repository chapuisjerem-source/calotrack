import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/errors/failures.dart';
import 'dto/off_product_dto.dart';

class OpenFoodFactsApi {
  final Dio _dio;

  OpenFoodFactsApi(this._dio);

  /// Lève un [Failure] en cas d'erreur.
  Future<OffProductDto> fetchProduct(String barcode) async {
    try {
      final res = await _dio.get(
        ApiEndpoints.product(barcode),
        options: Options(
          headers: {'User-Agent': ApiEndpoints.userAgent},
          responseType: ResponseType.json,
          receiveTimeout: const Duration(seconds: 8),
        ),
      );
      final data = res.data as Map<String, dynamic>;
      final status = data['status'];
      if (status == 0 || status == '0') {
        throw ProductNotFoundFailure(barcode);
      }
      final dto = OffProductDto.fromJson(data);
      if (!dto.hasNutriments) {
        throw const IncompleteDataFailure();
      }
      return dto;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw const NetworkFailure();
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 404) {
            throw ProductNotFoundFailure(barcode);
          }
          throw const ServerFailure();
        default:
          throw const UnknownFailure();
      }
    } on Failure {
      rethrow;
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 8),
  ));
  return dio;
});

final openFoodFactsApiProvider = Provider<OpenFoodFactsApi>((ref) {
  return OpenFoodFactsApi(ref.watch(dioProvider));
});
