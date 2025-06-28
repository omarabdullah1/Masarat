// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_lessons_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetLessonsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<LessonModel> lessons) success,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<LessonModel> lessons)? success,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<LessonModel> lessons)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(GetLessonsLoading value) loading,
    required TResult Function(GetLessonsSuccess value) success,
    required TResult Function(GetLessonsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(GetLessonsLoading value)? loading,
    TResult? Function(GetLessonsSuccess value)? success,
    TResult? Function(GetLessonsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(GetLessonsLoading value)? loading,
    TResult Function(GetLessonsSuccess value)? success,
    TResult Function(GetLessonsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetLessonsStateCopyWith<$Res> {
  factory $GetLessonsStateCopyWith(
          GetLessonsState value, $Res Function(GetLessonsState) then) =
      _$GetLessonsStateCopyWithImpl<$Res, GetLessonsState>;
}

/// @nodoc
class _$GetLessonsStateCopyWithImpl<$Res, $Val extends GetLessonsState>
    implements $GetLessonsStateCopyWith<$Res> {
  _$GetLessonsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetLessonsState
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
    extends _$GetLessonsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'GetLessonsState.initial()';
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
    required TResult Function(List<LessonModel> lessons) success,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<LessonModel> lessons)? success,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<LessonModel> lessons)? success,
    TResult Function(String error)? error,
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
    required TResult Function(GetLessonsLoading value) loading,
    required TResult Function(GetLessonsSuccess value) success,
    required TResult Function(GetLessonsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(GetLessonsLoading value)? loading,
    TResult? Function(GetLessonsSuccess value)? success,
    TResult? Function(GetLessonsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(GetLessonsLoading value)? loading,
    TResult Function(GetLessonsSuccess value)? success,
    TResult Function(GetLessonsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GetLessonsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$GetLessonsLoadingImplCopyWith<$Res> {
  factory _$$GetLessonsLoadingImplCopyWith(_$GetLessonsLoadingImpl value,
          $Res Function(_$GetLessonsLoadingImpl) then) =
      __$$GetLessonsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetLessonsLoadingImplCopyWithImpl<$Res>
    extends _$GetLessonsStateCopyWithImpl<$Res, _$GetLessonsLoadingImpl>
    implements _$$GetLessonsLoadingImplCopyWith<$Res> {
  __$$GetLessonsLoadingImplCopyWithImpl(_$GetLessonsLoadingImpl _value,
      $Res Function(_$GetLessonsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetLessonsLoadingImpl implements GetLessonsLoading {
  const _$GetLessonsLoadingImpl();

  @override
  String toString() {
    return 'GetLessonsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetLessonsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<LessonModel> lessons) success,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<LessonModel> lessons)? success,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<LessonModel> lessons)? success,
    TResult Function(String error)? error,
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
    required TResult Function(GetLessonsLoading value) loading,
    required TResult Function(GetLessonsSuccess value) success,
    required TResult Function(GetLessonsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(GetLessonsLoading value)? loading,
    TResult? Function(GetLessonsSuccess value)? success,
    TResult? Function(GetLessonsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(GetLessonsLoading value)? loading,
    TResult Function(GetLessonsSuccess value)? success,
    TResult Function(GetLessonsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GetLessonsLoading implements GetLessonsState {
  const factory GetLessonsLoading() = _$GetLessonsLoadingImpl;
}

/// @nodoc
abstract class _$$GetLessonsSuccessImplCopyWith<$Res> {
  factory _$$GetLessonsSuccessImplCopyWith(_$GetLessonsSuccessImpl value,
          $Res Function(_$GetLessonsSuccessImpl) then) =
      __$$GetLessonsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LessonModel> lessons});
}

/// @nodoc
class __$$GetLessonsSuccessImplCopyWithImpl<$Res>
    extends _$GetLessonsStateCopyWithImpl<$Res, _$GetLessonsSuccessImpl>
    implements _$$GetLessonsSuccessImplCopyWith<$Res> {
  __$$GetLessonsSuccessImplCopyWithImpl(_$GetLessonsSuccessImpl _value,
      $Res Function(_$GetLessonsSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessons = null,
  }) {
    return _then(_$GetLessonsSuccessImpl(
      null == lessons
          ? _value._lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<LessonModel>,
    ));
  }
}

/// @nodoc

class _$GetLessonsSuccessImpl implements GetLessonsSuccess {
  const _$GetLessonsSuccessImpl(final List<LessonModel> lessons)
      : _lessons = lessons;

  final List<LessonModel> _lessons;
  @override
  List<LessonModel> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  @override
  String toString() {
    return 'GetLessonsState.success(lessons: $lessons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetLessonsSuccessImpl &&
            const DeepCollectionEquality().equals(other._lessons, _lessons));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lessons));

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetLessonsSuccessImplCopyWith<_$GetLessonsSuccessImpl> get copyWith =>
      __$$GetLessonsSuccessImplCopyWithImpl<_$GetLessonsSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<LessonModel> lessons) success,
    required TResult Function(String error) error,
  }) {
    return success(lessons);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<LessonModel> lessons)? success,
    TResult? Function(String error)? error,
  }) {
    return success?.call(lessons);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<LessonModel> lessons)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(lessons);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(GetLessonsLoading value) loading,
    required TResult Function(GetLessonsSuccess value) success,
    required TResult Function(GetLessonsError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(GetLessonsLoading value)? loading,
    TResult? Function(GetLessonsSuccess value)? success,
    TResult? Function(GetLessonsError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(GetLessonsLoading value)? loading,
    TResult Function(GetLessonsSuccess value)? success,
    TResult Function(GetLessonsError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class GetLessonsSuccess implements GetLessonsState {
  const factory GetLessonsSuccess(final List<LessonModel> lessons) =
      _$GetLessonsSuccessImpl;

  List<LessonModel> get lessons;

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetLessonsSuccessImplCopyWith<_$GetLessonsSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetLessonsErrorImplCopyWith<$Res> {
  factory _$$GetLessonsErrorImplCopyWith(_$GetLessonsErrorImpl value,
          $Res Function(_$GetLessonsErrorImpl) then) =
      __$$GetLessonsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$GetLessonsErrorImplCopyWithImpl<$Res>
    extends _$GetLessonsStateCopyWithImpl<$Res, _$GetLessonsErrorImpl>
    implements _$$GetLessonsErrorImplCopyWith<$Res> {
  __$$GetLessonsErrorImplCopyWithImpl(
      _$GetLessonsErrorImpl _value, $Res Function(_$GetLessonsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$GetLessonsErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetLessonsErrorImpl implements GetLessonsError {
  const _$GetLessonsErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'GetLessonsState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetLessonsErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetLessonsErrorImplCopyWith<_$GetLessonsErrorImpl> get copyWith =>
      __$$GetLessonsErrorImplCopyWithImpl<_$GetLessonsErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<LessonModel> lessons) success,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<LessonModel> lessons)? success,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<LessonModel> lessons)? success,
    TResult Function(String error)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(GetLessonsLoading value) loading,
    required TResult Function(GetLessonsSuccess value) success,
    required TResult Function(GetLessonsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(GetLessonsLoading value)? loading,
    TResult? Function(GetLessonsSuccess value)? success,
    TResult? Function(GetLessonsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(GetLessonsLoading value)? loading,
    TResult Function(GetLessonsSuccess value)? success,
    TResult Function(GetLessonsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class GetLessonsError implements GetLessonsState {
  const factory GetLessonsError(final String error) = _$GetLessonsErrorImpl;

  String get error;

  /// Create a copy of GetLessonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetLessonsErrorImplCopyWith<_$GetLessonsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
