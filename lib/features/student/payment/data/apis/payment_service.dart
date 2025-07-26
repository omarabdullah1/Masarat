import 'package:dio/dio.dart';
import 'package:masarat/features/student/payment/data/apis/payment_api_constants.dart';
import 'package:masarat/features/student/payment/data/models/checkout_request.dart';
import 'package:masarat/features/student/payment/data/models/checkout_response.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_service.g.dart';

/// Service for handling payment-related API calls
@RestApi()
abstract class PaymentService {
  /// Factory constructor
  factory PaymentService(Dio dio, {String baseUrl}) = _PaymentService;

  /// Initiates the checkout process
  @POST(PaymentApiConstants.initiateCheckout)
  Future<CheckoutResponse> initiateCheckout(@Body() CheckoutRequest request);
}
