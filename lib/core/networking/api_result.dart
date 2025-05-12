import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masarat/core/networking/api_error_model.dart';

part 'api_result.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(ApiErrorModel apiErrorModel) = Failure<T>;
}

/// Extension methods for ApiResult
extension ApiResultExtensions<T> on ApiResult<T> {
  /// Check if this result represents a response that came from cache during a network error
  bool get isFromCache {
    if (this is Success<T>) {
      final successData = (this as Success<T>).data;
      if (successData is Response) {
        return successData.extra['fromCache'] == true;
      }
    }
    return false;
  }

  /// Get the data safely from the ApiResult
  T? get dataOrNull {
    return when(
      success: (data) => data,
      failure: (_) => null,
    );
  }
}
