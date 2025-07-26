import 'dart:developer';

import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/student/cart/data/apis/student_cart_service.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';
import 'package:masarat/features/student/cart/data/models/checkout_request_model.dart';
import 'package:masarat/features/student/cart/data/models/checkout_response_model.dart';

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

  Future<ApiResult<CheckoutResponseModel>> initiateCheckout(
      CheckoutRequestModel request) async {
    try {
      // Create a manual map to avoid serialization issues
      final Map<String, dynamic> requestBody = {
        'sourceId': {
          'id': request.sourceId.id,
        },
        'currency': request.currency,
      };

      log('Initiating checkout with request: $requestBody');

      final response = await _apiService.initiateCheckout(requestBody);

      try {
        // Convert the root response to our model
        final checkoutResponseModel = CheckoutResponseModel(
          success: response.success,
          redirectUrl: response.redirectUrl,
          orderId: response.orderId,
        );

        log('Checkout response: success=${checkoutResponseModel.success}, redirectUrl=${checkoutResponseModel.redirectUrl}');
        return ApiResult.success(checkoutResponseModel);
      } catch (parseError) {
        // If we get here, the response structure might be wrong
        log('Error processing checkout response: $parseError');
        throw Exception('Invalid response format from checkout API');
      }
    } catch (e, stackTrace) {
      log('Error initiating checkout: $e');
      log('Stack trace: $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
