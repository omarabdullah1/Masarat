import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';
import 'package:masarat/features/student/cart/data/models/checkout_response_model.dart';

part 'student_cart_state.freezed.dart';

@freezed
class StudentCartState with _$StudentCartState {
  const factory StudentCartState.initial() = _Initial;
  const factory StudentCartState.loading() = _Loading;
  const factory StudentCartState.success(CartResponseModel cartData) = _Success;
  const factory StudentCartState.error(String message) = _Error;
  const factory StudentCartState.checkoutLoading() = _CheckoutLoading;
  const factory StudentCartState.checkoutSuccess(
      CheckoutResponseModel checkoutData) = _CheckoutSuccess;
  const factory StudentCartState.checkoutError(String message) = _CheckoutError;
}
