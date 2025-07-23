import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/student/cart/data/models/checkout_request_model.dart';
import 'package:masarat/features/student/cart/data/models/checkout_response_model.dart';
import 'package:masarat/features/student/cart/data/repos/student_cart_repo.dart';

part 'payment_cubit.freezed.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final StudentCartRepo _cartRepo;

  PaymentCubit(this._cartRepo) : super(const PaymentState.initial());

  Future<CheckoutResponseModel?> initiateCheckout() async {
    log('Initiating checkout from PaymentCubit');
    emit(const PaymentState.loading());

    // Create a standard checkout request for all payment options
    const request = CheckoutRequestModel(
      sourceId: SourceIdModel(id: 'src_all'),
      currency: 'SAR',
    );

    final result = await _cartRepo.initiateCheckout(request);

    return result.when(
      success: (checkoutData) {
        log('Checkout success in PaymentCubit: $checkoutData');
        emit(PaymentState.checkoutInitiated(checkoutData));
        return checkoutData;
      },
      failure: (error) {
        final errorMessage = error.getAllErrorMessages();
        log('Checkout error in PaymentCubit: $errorMessage');
        emit(PaymentState.error(errorMessage));
        return null;
      },
    );
  }
}
