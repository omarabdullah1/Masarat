import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/features/student/cart/data/models/cart_response_model.dart';

part 'student_cart_state.freezed.dart';

@freezed
class StudentCartState with _$StudentCartState {
  const factory StudentCartState.initial() = _Initial;
  const factory StudentCartState.loading() = _Loading;
  const factory StudentCartState.success(CartResponseModel cartData) = _Success;
  const factory StudentCartState.error(String message) = _Error;
}
