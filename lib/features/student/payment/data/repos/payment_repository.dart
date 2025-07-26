import 'package:masarat/core/networking/api_error_handler.dart';
import 'package:masarat/core/networking/api_result.dart';
import 'package:masarat/features/student/payment/data/apis/payment_service.dart';
import 'package:masarat/features/student/payment/data/models/checkout_request.dart';
import 'package:masarat/features/student/payment/data/models/checkout_response.dart';

/// Repository for handling payment operations
class PaymentRepository {
  final PaymentService _paymentService;

  /// Constructor
  PaymentRepository(this._paymentService);

  /// Initiates the checkout process
  ///
  /// [sourceId] - The ID of the payment source (e.g., src_sa.mada, src_card)
  /// [currency] - The currency code, defaults to SAR
  /// [phone] - Optional phone information for STC Pay
  Future<ApiResult<CheckoutResponse>> initiateCheckout({
    required String sourceId,
    String currency = 'SAR',
    Phone? phone,
  }) async {
    try {
      final request = CheckoutRequest(
        sourceId: SourceId(
          id: sourceId,
          phone: phone,
        ),
        currency: currency,
      );

      final response = await _paymentService.initiateCheckout(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
