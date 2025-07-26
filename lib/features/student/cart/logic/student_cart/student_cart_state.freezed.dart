// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudentCartState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCartStateCopyWith<$Res> {
  factory $StudentCartStateCopyWith(
          StudentCartState value, $Res Function(StudentCartState) then) =
      _$StudentCartStateCopyWithImpl<$Res, StudentCartState>;
}

/// @nodoc
class _$StudentCartStateCopyWithImpl<$Res, $Val extends StudentCartState>
    implements $StudentCartStateCopyWith<$Res> {
  _$StudentCartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'StudentCartState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements StudentCartState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StudentCartState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements StudentCartState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CartResponseModel cartData});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartData = null,
  }) {
    return _then(_$SuccessImpl(
      null == cartData
          ? _value.cartData
          : cartData // ignore: cast_nullable_to_non_nullable
              as CartResponseModel,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.cartData);

  @override
  final CartResponseModel cartData;

  @override
  String toString() {
    return 'StudentCartState.success(cartData: $cartData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.cartData, cartData) ||
                other.cartData == cartData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cartData);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return success(cartData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return success?.call(cartData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(cartData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements StudentCartState {
  const factory _Success(final CartResponseModel cartData) = _$SuccessImpl;

  CartResponseModel get cartData;

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StudentCartState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements StudentCartState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckoutLoadingImplCopyWith<$Res> {
  factory _$$CheckoutLoadingImplCopyWith(_$CheckoutLoadingImpl value,
          $Res Function(_$CheckoutLoadingImpl) then) =
      __$$CheckoutLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckoutLoadingImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$CheckoutLoadingImpl>
    implements _$$CheckoutLoadingImplCopyWith<$Res> {
  __$$CheckoutLoadingImplCopyWithImpl(
      _$CheckoutLoadingImpl _value, $Res Function(_$CheckoutLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckoutLoadingImpl implements _CheckoutLoading {
  const _$CheckoutLoadingImpl();

  @override
  String toString() {
    return 'StudentCartState.checkoutLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckoutLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return checkoutLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return checkoutLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (checkoutLoading != null) {
      return checkoutLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return checkoutLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return checkoutLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (checkoutLoading != null) {
      return checkoutLoading(this);
    }
    return orElse();
  }
}

abstract class _CheckoutLoading implements StudentCartState {
  const factory _CheckoutLoading() = _$CheckoutLoadingImpl;
}

/// @nodoc
abstract class _$$CheckoutSuccessImplCopyWith<$Res> {
  factory _$$CheckoutSuccessImplCopyWith(_$CheckoutSuccessImpl value,
          $Res Function(_$CheckoutSuccessImpl) then) =
      __$$CheckoutSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CheckoutResponseModel checkoutData});
}

/// @nodoc
class __$$CheckoutSuccessImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$CheckoutSuccessImpl>
    implements _$$CheckoutSuccessImplCopyWith<$Res> {
  __$$CheckoutSuccessImplCopyWithImpl(
      _$CheckoutSuccessImpl _value, $Res Function(_$CheckoutSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkoutData = null,
  }) {
    return _then(_$CheckoutSuccessImpl(
      null == checkoutData
          ? _value.checkoutData
          : checkoutData // ignore: cast_nullable_to_non_nullable
              as CheckoutResponseModel,
    ));
  }
}

/// @nodoc

class _$CheckoutSuccessImpl implements _CheckoutSuccess {
  const _$CheckoutSuccessImpl(this.checkoutData);

  @override
  final CheckoutResponseModel checkoutData;

  @override
  String toString() {
    return 'StudentCartState.checkoutSuccess(checkoutData: $checkoutData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutSuccessImpl &&
            (identical(other.checkoutData, checkoutData) ||
                other.checkoutData == checkoutData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, checkoutData);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutSuccessImplCopyWith<_$CheckoutSuccessImpl> get copyWith =>
      __$$CheckoutSuccessImplCopyWithImpl<_$CheckoutSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return checkoutSuccess(checkoutData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return checkoutSuccess?.call(checkoutData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (checkoutSuccess != null) {
      return checkoutSuccess(checkoutData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return checkoutSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return checkoutSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (checkoutSuccess != null) {
      return checkoutSuccess(this);
    }
    return orElse();
  }
}

abstract class _CheckoutSuccess implements StudentCartState {
  const factory _CheckoutSuccess(final CheckoutResponseModel checkoutData) =
      _$CheckoutSuccessImpl;

  CheckoutResponseModel get checkoutData;

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutSuccessImplCopyWith<_$CheckoutSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckoutErrorImplCopyWith<$Res> {
  factory _$$CheckoutErrorImplCopyWith(
          _$CheckoutErrorImpl value, $Res Function(_$CheckoutErrorImpl) then) =
      __$$CheckoutErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CheckoutErrorImplCopyWithImpl<$Res>
    extends _$StudentCartStateCopyWithImpl<$Res, _$CheckoutErrorImpl>
    implements _$$CheckoutErrorImplCopyWith<$Res> {
  __$$CheckoutErrorImplCopyWithImpl(
      _$CheckoutErrorImpl _value, $Res Function(_$CheckoutErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CheckoutErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckoutErrorImpl implements _CheckoutError {
  const _$CheckoutErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StudentCartState.checkoutError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutErrorImplCopyWith<_$CheckoutErrorImpl> get copyWith =>
      __$$CheckoutErrorImplCopyWithImpl<_$CheckoutErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartResponseModel cartData) success,
    required TResult Function(String message) error,
    required TResult Function() checkoutLoading,
    required TResult Function(CheckoutResponseModel checkoutData)
        checkoutSuccess,
    required TResult Function(String message) checkoutError,
  }) {
    return checkoutError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartResponseModel cartData)? success,
    TResult? Function(String message)? error,
    TResult? Function()? checkoutLoading,
    TResult? Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult? Function(String message)? checkoutError,
  }) {
    return checkoutError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartResponseModel cartData)? success,
    TResult Function(String message)? error,
    TResult Function()? checkoutLoading,
    TResult Function(CheckoutResponseModel checkoutData)? checkoutSuccess,
    TResult Function(String message)? checkoutError,
    required TResult orElse(),
  }) {
    if (checkoutError != null) {
      return checkoutError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_CheckoutLoading value) checkoutLoading,
    required TResult Function(_CheckoutSuccess value) checkoutSuccess,
    required TResult Function(_CheckoutError value) checkoutError,
  }) {
    return checkoutError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_CheckoutLoading value)? checkoutLoading,
    TResult? Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult? Function(_CheckoutError value)? checkoutError,
  }) {
    return checkoutError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_CheckoutLoading value)? checkoutLoading,
    TResult Function(_CheckoutSuccess value)? checkoutSuccess,
    TResult Function(_CheckoutError value)? checkoutError,
    required TResult orElse(),
  }) {
    if (checkoutError != null) {
      return checkoutError(this);
    }
    return orElse();
  }
}

abstract class _CheckoutError implements StudentCartState {
  const factory _CheckoutError(final String message) = _$CheckoutErrorImpl;

  String get message;

  /// Create a copy of StudentCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutErrorImplCopyWith<_$CheckoutErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
