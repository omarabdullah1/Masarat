// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_course_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateCourseState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCourseStateCopyWith<T, $Res> {
  factory $CreateCourseStateCopyWith(CreateCourseState<T> value,
          $Res Function(CreateCourseState<T>) then) =
      _$CreateCourseStateCopyWithImpl<T, $Res, CreateCourseState<T>>;
}

/// @nodoc
class _$CreateCourseStateCopyWithImpl<T, $Res,
        $Val extends CreateCourseState<T>>
    implements $CreateCourseStateCopyWith<T, $Res> {
  _$CreateCourseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl<T> implements _Initial<T> {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CreateCourseState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
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
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial<T> implements CreateCourseState<T> {
  const factory _Initial() = _$InitialImpl<T>;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl<T> implements Loading<T> {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CreateCourseState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
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
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<T> implements CreateCourseState<T> {
  const factory Loading() = _$LoadingImpl<T>;
}

/// @nodoc
abstract class _$$CreateCourseSuccessImplCopyWith<T, $Res> {
  factory _$$CreateCourseSuccessImplCopyWith(_$CreateCourseSuccessImpl<T> value,
          $Res Function(_$CreateCourseSuccessImpl<T>) then) =
      __$$CreateCourseSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$CreateCourseSuccessImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res,
        _$CreateCourseSuccessImpl<T>>
    implements _$$CreateCourseSuccessImplCopyWith<T, $Res> {
  __$$CreateCourseSuccessImplCopyWithImpl(_$CreateCourseSuccessImpl<T> _value,
      $Res Function(_$CreateCourseSuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$CreateCourseSuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$CreateCourseSuccessImpl<T> implements CreateCourseSuccess<T> {
  const _$CreateCourseSuccessImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'CreateCourseState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCourseSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCourseSuccessImplCopyWith<T, _$CreateCourseSuccessImpl<T>>
      get copyWith => __$$CreateCourseSuccessImplCopyWithImpl<T,
          _$CreateCourseSuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class CreateCourseSuccess<T> implements CreateCourseState<T> {
  const factory CreateCourseSuccess(final T data) =
      _$CreateCourseSuccessImpl<T>;

  T get data;

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCourseSuccessImplCopyWith<T, _$CreateCourseSuccessImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements Error<T> {
  const _$ErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'CreateCourseState<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<T> implements CreateCourseState<T> {
  const factory Error({required final String error}) = _$ErrorImpl<T>;

  String get error;

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingCategoriesImplCopyWith<T, $Res> {
  factory _$$LoadingCategoriesImplCopyWith(_$LoadingCategoriesImpl<T> value,
          $Res Function(_$LoadingCategoriesImpl<T>) then) =
      __$$LoadingCategoriesImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingCategoriesImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res, _$LoadingCategoriesImpl<T>>
    implements _$$LoadingCategoriesImplCopyWith<T, $Res> {
  __$$LoadingCategoriesImplCopyWithImpl(_$LoadingCategoriesImpl<T> _value,
      $Res Function(_$LoadingCategoriesImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingCategoriesImpl<T> implements LoadingCategories<T> {
  const _$LoadingCategoriesImpl();

  @override
  String toString() {
    return 'CreateCourseState<$T>.loadingCategories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingCategoriesImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return loadingCategories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return loadingCategories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
    required TResult orElse(),
  }) {
    if (loadingCategories != null) {
      return loadingCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return loadingCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return loadingCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (loadingCategories != null) {
      return loadingCategories(this);
    }
    return orElse();
  }
}

abstract class LoadingCategories<T> implements CreateCourseState<T> {
  const factory LoadingCategories() = _$LoadingCategoriesImpl<T>;
}

/// @nodoc
abstract class _$$CategoriesLoadedImplCopyWith<T, $Res> {
  factory _$$CategoriesLoadedImplCopyWith(_$CategoriesLoadedImpl<T> value,
          $Res Function(_$CategoriesLoadedImpl<T>) then) =
      __$$CategoriesLoadedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<CategoryModel> categories});
}

/// @nodoc
class __$$CategoriesLoadedImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res, _$CategoriesLoadedImpl<T>>
    implements _$$CategoriesLoadedImplCopyWith<T, $Res> {
  __$$CategoriesLoadedImplCopyWithImpl(_$CategoriesLoadedImpl<T> _value,
      $Res Function(_$CategoriesLoadedImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
  }) {
    return _then(_$CategoriesLoadedImpl<T>(
      null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
    ));
  }
}

/// @nodoc

class _$CategoriesLoadedImpl<T> implements CategoriesLoaded<T> {
  const _$CategoriesLoadedImpl(final List<CategoryModel> categories)
      : _categories = categories;

  final List<CategoryModel> _categories;
  @override
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'CreateCourseState<$T>.categoriesLoaded(categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesLoadedImpl<T> &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_categories));

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesLoadedImplCopyWith<T, _$CategoriesLoadedImpl<T>> get copyWith =>
      __$$CategoriesLoadedImplCopyWithImpl<T, _$CategoriesLoadedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return categoriesLoaded(categories);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return categoriesLoaded?.call(categories);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesLoaded != null) {
      return categoriesLoaded(categories);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return categoriesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return categoriesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesLoaded != null) {
      return categoriesLoaded(this);
    }
    return orElse();
  }
}

abstract class CategoriesLoaded<T> implements CreateCourseState<T> {
  const factory CategoriesLoaded(final List<CategoryModel> categories) =
      _$CategoriesLoadedImpl<T>;

  List<CategoryModel> get categories;

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesLoadedImplCopyWith<T, _$CategoriesLoadedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CategoriesErrorImplCopyWith<T, $Res> {
  factory _$$CategoriesErrorImplCopyWith(_$CategoriesErrorImpl<T> value,
          $Res Function(_$CategoriesErrorImpl<T>) then) =
      __$$CategoriesErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CategoriesErrorImplCopyWithImpl<T, $Res>
    extends _$CreateCourseStateCopyWithImpl<T, $Res, _$CategoriesErrorImpl<T>>
    implements _$$CategoriesErrorImplCopyWith<T, $Res> {
  __$$CategoriesErrorImplCopyWithImpl(_$CategoriesErrorImpl<T> _value,
      $Res Function(_$CategoriesErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CategoriesErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CategoriesErrorImpl<T> implements CategoriesError<T> {
  const _$CategoriesErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'CreateCourseState<$T>.categoriesError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesErrorImplCopyWith<T, _$CategoriesErrorImpl<T>> get copyWith =>
      __$$CategoriesErrorImplCopyWithImpl<T, _$CategoriesErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(String error) error,
    required TResult Function() loadingCategories,
    required TResult Function(List<CategoryModel> categories) categoriesLoaded,
    required TResult Function(String error) categoriesError,
  }) {
    return categoriesError(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? loadingCategories,
    TResult? Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult? Function(String error)? categoriesError,
  }) {
    return categoriesError?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(String error)? error,
    TResult Function()? loadingCategories,
    TResult Function(List<CategoryModel> categories)? categoriesLoaded,
    TResult Function(String error)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesError != null) {
      return categoriesError(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(CreateCourseSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(LoadingCategories<T> value) loadingCategories,
    required TResult Function(CategoriesLoaded<T> value) categoriesLoaded,
    required TResult Function(CategoriesError<T> value) categoriesError,
  }) {
    return categoriesError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(CreateCourseSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(LoadingCategories<T> value)? loadingCategories,
    TResult? Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult? Function(CategoriesError<T> value)? categoriesError,
  }) {
    return categoriesError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(CreateCourseSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(LoadingCategories<T> value)? loadingCategories,
    TResult Function(CategoriesLoaded<T> value)? categoriesLoaded,
    TResult Function(CategoriesError<T> value)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesError != null) {
      return categoriesError(this);
    }
    return orElse();
  }
}

abstract class CategoriesError<T> implements CreateCourseState<T> {
  const factory CategoriesError({required final String error}) =
      _$CategoriesErrorImpl<T>;

  String get error;

  /// Create a copy of CreateCourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesErrorImplCopyWith<T, _$CategoriesErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
