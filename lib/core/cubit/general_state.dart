import 'package:freezed_annotation/freezed_annotation.dart';
part 'general_state.freezed.dart';

@freezed
class GeneralState with _$GeneralState {
  const factory GeneralState.initial() = _Initial;
  const factory GeneralState.changeLanguage(String language) = _ChangeLanguage;
}
