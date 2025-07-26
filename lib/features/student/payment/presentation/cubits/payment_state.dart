part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loading() = _Loading;
  const factory PaymentState.checkoutInitiated(
      CheckoutResponseModel checkoutData) = _CheckoutInitiated;
  const factory PaymentState.error(String message) = _Error;
}
