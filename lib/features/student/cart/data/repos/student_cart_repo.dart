import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/student/cart/data/apis/student_cart_service.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';

class StudentCartRepo {
  final StudentCartService _apiService;

  StudentCartRepo(this._apiService);

  Future<ApiResult<CartResponseModel>> getCart() async {
    try {
      final response = await _apiService.getCart();
      return ApiResult.success(response.data);
    } catch (e, stackTrace) {
      log('Error getting cart: $e');
      log('Stack trace: $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<bool>> removeFromCart(String courseId) async {
    try {
      await _apiService.removeFromCart(courseId);
      return const ApiResult.success(true);
    } catch (e, stackTrace) {
      log('Error removing item from cart: $e');
      log('Stack trace: $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<CartResponseModel>> addToCart(String courseId) async {
    try {
      final response = await _apiService.addToCart({'courseId': courseId});
      return ApiResult.success(response.data);
    } catch (e, stackTrace) {
      log('Error adding item to cart: $e');
      log('Stack trace: $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
