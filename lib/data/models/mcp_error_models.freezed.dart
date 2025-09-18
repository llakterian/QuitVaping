// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_error_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MCPError _$MCPErrorFromJson(Map<String, dynamic> json) {
  return _MCPError.fromJson(json);
}

/// @nodoc
mixin _$MCPError {
  String get id => throw _privateConstructorUsedError;
  MCPErrorType get errorType => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get userFriendlyMessage => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String? get operation => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isRetryable => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  int get maxRetries => throw _privateConstructorUsedError;
  Map<String, dynamic>? get context => throw _privateConstructorUsedError;
  List<MCPRecoveryOption>? get recoveryOptions =>
      throw _privateConstructorUsedError;
  MCPErrorSeverity? get severity => throw _privateConstructorUsedError;

  /// Serializes this MCPError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPErrorCopyWith<MCPError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPErrorCopyWith<$Res> {
  factory $MCPErrorCopyWith(MCPError value, $Res Function(MCPError) then) =
      _$MCPErrorCopyWithImpl<$Res, MCPError>;
  @useResult
  $Res call(
      {String id,
      MCPErrorType errorType,
      String message,
      String userFriendlyMessage,
      String? serverId,
      String? operation,
      DateTime timestamp,
      bool isRetryable,
      int retryCount,
      int maxRetries,
      Map<String, dynamic>? context,
      List<MCPRecoveryOption>? recoveryOptions,
      MCPErrorSeverity? severity});
}

/// @nodoc
class _$MCPErrorCopyWithImpl<$Res, $Val extends MCPError>
    implements $MCPErrorCopyWith<$Res> {
  _$MCPErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? errorType = null,
    Object? message = null,
    Object? userFriendlyMessage = null,
    Object? serverId = freezed,
    Object? operation = freezed,
    Object? timestamp = null,
    Object? isRetryable = null,
    Object? retryCount = null,
    Object? maxRetries = null,
    Object? context = freezed,
    Object? recoveryOptions = freezed,
    Object? severity = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as MCPErrorType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      userFriendlyMessage: null == userFriendlyMessage
          ? _value.userFriendlyMessage
          : userFriendlyMessage // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRetryable: null == isRetryable
          ? _value.isRetryable
          : isRetryable // ignore: cast_nullable_to_non_nullable
              as bool,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      recoveryOptions: freezed == recoveryOptions
          ? _value.recoveryOptions
          : recoveryOptions // ignore: cast_nullable_to_non_nullable
              as List<MCPRecoveryOption>?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as MCPErrorSeverity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPErrorImplCopyWith<$Res>
    implements $MCPErrorCopyWith<$Res> {
  factory _$$MCPErrorImplCopyWith(
          _$MCPErrorImpl value, $Res Function(_$MCPErrorImpl) then) =
      __$$MCPErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      MCPErrorType errorType,
      String message,
      String userFriendlyMessage,
      String? serverId,
      String? operation,
      DateTime timestamp,
      bool isRetryable,
      int retryCount,
      int maxRetries,
      Map<String, dynamic>? context,
      List<MCPRecoveryOption>? recoveryOptions,
      MCPErrorSeverity? severity});
}

/// @nodoc
class __$$MCPErrorImplCopyWithImpl<$Res>
    extends _$MCPErrorCopyWithImpl<$Res, _$MCPErrorImpl>
    implements _$$MCPErrorImplCopyWith<$Res> {
  __$$MCPErrorImplCopyWithImpl(
      _$MCPErrorImpl _value, $Res Function(_$MCPErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? errorType = null,
    Object? message = null,
    Object? userFriendlyMessage = null,
    Object? serverId = freezed,
    Object? operation = freezed,
    Object? timestamp = null,
    Object? isRetryable = null,
    Object? retryCount = null,
    Object? maxRetries = null,
    Object? context = freezed,
    Object? recoveryOptions = freezed,
    Object? severity = freezed,
  }) {
    return _then(_$MCPErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as MCPErrorType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      userFriendlyMessage: null == userFriendlyMessage
          ? _value.userFriendlyMessage
          : userFriendlyMessage // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRetryable: null == isRetryable
          ? _value.isRetryable
          : isRetryable // ignore: cast_nullable_to_non_nullable
              as bool,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      context: freezed == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      recoveryOptions: freezed == recoveryOptions
          ? _value._recoveryOptions
          : recoveryOptions // ignore: cast_nullable_to_non_nullable
              as List<MCPRecoveryOption>?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as MCPErrorSeverity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPErrorImpl implements _MCPError {
  const _$MCPErrorImpl(
      {required this.id,
      required this.errorType,
      required this.message,
      required this.userFriendlyMessage,
      this.serverId,
      this.operation,
      required this.timestamp,
      this.isRetryable = false,
      this.retryCount = 0,
      this.maxRetries = 3,
      final Map<String, dynamic>? context,
      final List<MCPRecoveryOption>? recoveryOptions,
      this.severity})
      : _context = context,
        _recoveryOptions = recoveryOptions;

  factory _$MCPErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPErrorImplFromJson(json);

  @override
  final String id;
  @override
  final MCPErrorType errorType;
  @override
  final String message;
  @override
  final String userFriendlyMessage;
  @override
  final String? serverId;
  @override
  final String? operation;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isRetryable;
  @override
  @JsonKey()
  final int retryCount;
  @override
  @JsonKey()
  final int maxRetries;
  final Map<String, dynamic>? _context;
  @override
  Map<String, dynamic>? get context {
    final value = _context;
    if (value == null) return null;
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<MCPRecoveryOption>? _recoveryOptions;
  @override
  List<MCPRecoveryOption>? get recoveryOptions {
    final value = _recoveryOptions;
    if (value == null) return null;
    if (_recoveryOptions is EqualUnmodifiableListView) return _recoveryOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MCPErrorSeverity? severity;

  @override
  String toString() {
    return 'MCPError(id: $id, errorType: $errorType, message: $message, userFriendlyMessage: $userFriendlyMessage, serverId: $serverId, operation: $operation, timestamp: $timestamp, isRetryable: $isRetryable, retryCount: $retryCount, maxRetries: $maxRetries, context: $context, recoveryOptions: $recoveryOptions, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.userFriendlyMessage, userFriendlyMessage) ||
                other.userFriendlyMessage == userFriendlyMessage) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isRetryable, isRetryable) ||
                other.isRetryable == isRetryable) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality()
                .equals(other._recoveryOptions, _recoveryOptions) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      errorType,
      message,
      userFriendlyMessage,
      serverId,
      operation,
      timestamp,
      isRetryable,
      retryCount,
      maxRetries,
      const DeepCollectionEquality().hash(_context),
      const DeepCollectionEquality().hash(_recoveryOptions),
      severity);

  /// Create a copy of MCPError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPErrorImplCopyWith<_$MCPErrorImpl> get copyWith =>
      __$$MCPErrorImplCopyWithImpl<_$MCPErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPErrorImplToJson(
      this,
    );
  }
}

abstract class _MCPError implements MCPError {
  const factory _MCPError(
      {required final String id,
      required final MCPErrorType errorType,
      required final String message,
      required final String userFriendlyMessage,
      final String? serverId,
      final String? operation,
      required final DateTime timestamp,
      final bool isRetryable,
      final int retryCount,
      final int maxRetries,
      final Map<String, dynamic>? context,
      final List<MCPRecoveryOption>? recoveryOptions,
      final MCPErrorSeverity? severity}) = _$MCPErrorImpl;

  factory _MCPError.fromJson(Map<String, dynamic> json) =
      _$MCPErrorImpl.fromJson;

  @override
  String get id;
  @override
  MCPErrorType get errorType;
  @override
  String get message;
  @override
  String get userFriendlyMessage;
  @override
  String? get serverId;
  @override
  String? get operation;
  @override
  DateTime get timestamp;
  @override
  bool get isRetryable;
  @override
  int get retryCount;
  @override
  int get maxRetries;
  @override
  Map<String, dynamic>? get context;
  @override
  List<MCPRecoveryOption>? get recoveryOptions;
  @override
  MCPErrorSeverity? get severity;

  /// Create a copy of MCPError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPErrorImplCopyWith<_$MCPErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPRecoveryOption _$MCPRecoveryOptionFromJson(Map<String, dynamic> json) {
  return _MCPRecoveryOption.fromJson(json);
}

/// @nodoc
mixin _$MCPRecoveryOption {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MCPRecoveryActionType get actionType => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parameters => throw _privateConstructorUsedError;
  bool get isAutomatic => throw _privateConstructorUsedError;
  double get priority => throw _privateConstructorUsedError;

  /// Serializes this MCPRecoveryOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPRecoveryOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPRecoveryOptionCopyWith<MCPRecoveryOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPRecoveryOptionCopyWith<$Res> {
  factory $MCPRecoveryOptionCopyWith(
          MCPRecoveryOption value, $Res Function(MCPRecoveryOption) then) =
      _$MCPRecoveryOptionCopyWithImpl<$Res, MCPRecoveryOption>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      MCPRecoveryActionType actionType,
      Map<String, dynamic>? parameters,
      bool isAutomatic,
      double priority});
}

/// @nodoc
class _$MCPRecoveryOptionCopyWithImpl<$Res, $Val extends MCPRecoveryOption>
    implements $MCPRecoveryOptionCopyWith<$Res> {
  _$MCPRecoveryOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPRecoveryOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? actionType = null,
    Object? parameters = freezed,
    Object? isAutomatic = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as MCPRecoveryActionType,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isAutomatic: null == isAutomatic
          ? _value.isAutomatic
          : isAutomatic // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPRecoveryOptionImplCopyWith<$Res>
    implements $MCPRecoveryOptionCopyWith<$Res> {
  factory _$$MCPRecoveryOptionImplCopyWith(_$MCPRecoveryOptionImpl value,
          $Res Function(_$MCPRecoveryOptionImpl) then) =
      __$$MCPRecoveryOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      MCPRecoveryActionType actionType,
      Map<String, dynamic>? parameters,
      bool isAutomatic,
      double priority});
}

/// @nodoc
class __$$MCPRecoveryOptionImplCopyWithImpl<$Res>
    extends _$MCPRecoveryOptionCopyWithImpl<$Res, _$MCPRecoveryOptionImpl>
    implements _$$MCPRecoveryOptionImplCopyWith<$Res> {
  __$$MCPRecoveryOptionImplCopyWithImpl(_$MCPRecoveryOptionImpl _value,
      $Res Function(_$MCPRecoveryOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPRecoveryOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? actionType = null,
    Object? parameters = freezed,
    Object? isAutomatic = null,
    Object? priority = null,
  }) {
    return _then(_$MCPRecoveryOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as MCPRecoveryActionType,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isAutomatic: null == isAutomatic
          ? _value.isAutomatic
          : isAutomatic // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPRecoveryOptionImpl implements _MCPRecoveryOption {
  const _$MCPRecoveryOptionImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.actionType,
      final Map<String, dynamic>? parameters,
      this.isAutomatic = false,
      this.priority = 1.0})
      : _parameters = parameters;

  factory _$MCPRecoveryOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPRecoveryOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final MCPRecoveryActionType actionType;
  final Map<String, dynamic>? _parameters;
  @override
  Map<String, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isAutomatic;
  @override
  @JsonKey()
  final double priority;

  @override
  String toString() {
    return 'MCPRecoveryOption(id: $id, title: $title, description: $description, actionType: $actionType, parameters: $parameters, isAutomatic: $isAutomatic, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPRecoveryOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.isAutomatic, isAutomatic) ||
                other.isAutomatic == isAutomatic) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      actionType,
      const DeepCollectionEquality().hash(_parameters),
      isAutomatic,
      priority);

  /// Create a copy of MCPRecoveryOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPRecoveryOptionImplCopyWith<_$MCPRecoveryOptionImpl> get copyWith =>
      __$$MCPRecoveryOptionImplCopyWithImpl<_$MCPRecoveryOptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPRecoveryOptionImplToJson(
      this,
    );
  }
}

abstract class _MCPRecoveryOption implements MCPRecoveryOption {
  const factory _MCPRecoveryOption(
      {required final String id,
      required final String title,
      required final String description,
      required final MCPRecoveryActionType actionType,
      final Map<String, dynamic>? parameters,
      final bool isAutomatic,
      final double priority}) = _$MCPRecoveryOptionImpl;

  factory _MCPRecoveryOption.fromJson(Map<String, dynamic> json) =
      _$MCPRecoveryOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  MCPRecoveryActionType get actionType;
  @override
  Map<String, dynamic>? get parameters;
  @override
  bool get isAutomatic;
  @override
  double get priority;

  /// Create a copy of MCPRecoveryOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPRecoveryOptionImplCopyWith<_$MCPRecoveryOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPServiceDegradation _$MCPServiceDegradationFromJson(
    Map<String, dynamic> json) {
  return _MCPServiceDegradation.fromJson(json);
}

/// @nodoc
mixin _$MCPServiceDegradation {
  String get serviceId => throw _privateConstructorUsedError;
  MCPDegradationLevel get level => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get affectedFeatures => throw _privateConstructorUsedError;
  List<String> get availableFeatures => throw _privateConstructorUsedError;
  DateTime? get estimatedResolution => throw _privateConstructorUsedError;
  String? get workaround => throw _privateConstructorUsedError;

  /// Serializes this MCPServiceDegradation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPServiceDegradation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPServiceDegradationCopyWith<MCPServiceDegradation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServiceDegradationCopyWith<$Res> {
  factory $MCPServiceDegradationCopyWith(MCPServiceDegradation value,
          $Res Function(MCPServiceDegradation) then) =
      _$MCPServiceDegradationCopyWithImpl<$Res, MCPServiceDegradation>;
  @useResult
  $Res call(
      {String serviceId,
      MCPDegradationLevel level,
      String description,
      List<String> affectedFeatures,
      List<String> availableFeatures,
      DateTime? estimatedResolution,
      String? workaround});
}

/// @nodoc
class _$MCPServiceDegradationCopyWithImpl<$Res,
        $Val extends MCPServiceDegradation>
    implements $MCPServiceDegradationCopyWith<$Res> {
  _$MCPServiceDegradationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPServiceDegradation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? level = null,
    Object? description = null,
    Object? affectedFeatures = null,
    Object? availableFeatures = null,
    Object? estimatedResolution = freezed,
    Object? workaround = freezed,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as MCPDegradationLevel,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      affectedFeatures: null == affectedFeatures
          ? _value.affectedFeatures
          : affectedFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFeatures: null == availableFeatures
          ? _value.availableFeatures
          : availableFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      estimatedResolution: freezed == estimatedResolution
          ? _value.estimatedResolution
          : estimatedResolution // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      workaround: freezed == workaround
          ? _value.workaround
          : workaround // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPServiceDegradationImplCopyWith<$Res>
    implements $MCPServiceDegradationCopyWith<$Res> {
  factory _$$MCPServiceDegradationImplCopyWith(
          _$MCPServiceDegradationImpl value,
          $Res Function(_$MCPServiceDegradationImpl) then) =
      __$$MCPServiceDegradationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serviceId,
      MCPDegradationLevel level,
      String description,
      List<String> affectedFeatures,
      List<String> availableFeatures,
      DateTime? estimatedResolution,
      String? workaround});
}

/// @nodoc
class __$$MCPServiceDegradationImplCopyWithImpl<$Res>
    extends _$MCPServiceDegradationCopyWithImpl<$Res,
        _$MCPServiceDegradationImpl>
    implements _$$MCPServiceDegradationImplCopyWith<$Res> {
  __$$MCPServiceDegradationImplCopyWithImpl(_$MCPServiceDegradationImpl _value,
      $Res Function(_$MCPServiceDegradationImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPServiceDegradation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? level = null,
    Object? description = null,
    Object? affectedFeatures = null,
    Object? availableFeatures = null,
    Object? estimatedResolution = freezed,
    Object? workaround = freezed,
  }) {
    return _then(_$MCPServiceDegradationImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as MCPDegradationLevel,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      affectedFeatures: null == affectedFeatures
          ? _value._affectedFeatures
          : affectedFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFeatures: null == availableFeatures
          ? _value._availableFeatures
          : availableFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      estimatedResolution: freezed == estimatedResolution
          ? _value.estimatedResolution
          : estimatedResolution // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      workaround: freezed == workaround
          ? _value.workaround
          : workaround // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServiceDegradationImpl implements _MCPServiceDegradation {
  const _$MCPServiceDegradationImpl(
      {required this.serviceId,
      required this.level,
      required this.description,
      required final List<String> affectedFeatures,
      required final List<String> availableFeatures,
      this.estimatedResolution,
      this.workaround})
      : _affectedFeatures = affectedFeatures,
        _availableFeatures = availableFeatures;

  factory _$MCPServiceDegradationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServiceDegradationImplFromJson(json);

  @override
  final String serviceId;
  @override
  final MCPDegradationLevel level;
  @override
  final String description;
  final List<String> _affectedFeatures;
  @override
  List<String> get affectedFeatures {
    if (_affectedFeatures is EqualUnmodifiableListView)
      return _affectedFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_affectedFeatures);
  }

  final List<String> _availableFeatures;
  @override
  List<String> get availableFeatures {
    if (_availableFeatures is EqualUnmodifiableListView)
      return _availableFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableFeatures);
  }

  @override
  final DateTime? estimatedResolution;
  @override
  final String? workaround;

  @override
  String toString() {
    return 'MCPServiceDegradation(serviceId: $serviceId, level: $level, description: $description, affectedFeatures: $affectedFeatures, availableFeatures: $availableFeatures, estimatedResolution: $estimatedResolution, workaround: $workaround)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServiceDegradationImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._affectedFeatures, _affectedFeatures) &&
            const DeepCollectionEquality()
                .equals(other._availableFeatures, _availableFeatures) &&
            (identical(other.estimatedResolution, estimatedResolution) ||
                other.estimatedResolution == estimatedResolution) &&
            (identical(other.workaround, workaround) ||
                other.workaround == workaround));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      level,
      description,
      const DeepCollectionEquality().hash(_affectedFeatures),
      const DeepCollectionEquality().hash(_availableFeatures),
      estimatedResolution,
      workaround);

  /// Create a copy of MCPServiceDegradation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServiceDegradationImplCopyWith<_$MCPServiceDegradationImpl>
      get copyWith => __$$MCPServiceDegradationImplCopyWithImpl<
          _$MCPServiceDegradationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServiceDegradationImplToJson(
      this,
    );
  }
}

abstract class _MCPServiceDegradation implements MCPServiceDegradation {
  const factory _MCPServiceDegradation(
      {required final String serviceId,
      required final MCPDegradationLevel level,
      required final String description,
      required final List<String> affectedFeatures,
      required final List<String> availableFeatures,
      final DateTime? estimatedResolution,
      final String? workaround}) = _$MCPServiceDegradationImpl;

  factory _MCPServiceDegradation.fromJson(Map<String, dynamic> json) =
      _$MCPServiceDegradationImpl.fromJson;

  @override
  String get serviceId;
  @override
  MCPDegradationLevel get level;
  @override
  String get description;
  @override
  List<String> get affectedFeatures;
  @override
  List<String> get availableFeatures;
  @override
  DateTime? get estimatedResolution;
  @override
  String? get workaround;

  /// Create a copy of MCPServiceDegradation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPServiceDegradationImplCopyWith<_$MCPServiceDegradationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MCPRetryConfig _$MCPRetryConfigFromJson(Map<String, dynamic> json) {
  return _MCPRetryConfig.fromJson(json);
}

/// @nodoc
mixin _$MCPRetryConfig {
  MCPErrorType get errorType => throw _privateConstructorUsedError;
  int get maxRetries => throw _privateConstructorUsedError;
  Duration get baseDelay => throw _privateConstructorUsedError;
  double get backoffMultiplier => throw _privateConstructorUsedError;
  Duration get maxDelay => throw _privateConstructorUsedError;
  double get jitter => throw _privateConstructorUsedError;
  bool get exponentialBackoff => throw _privateConstructorUsedError;

  /// Serializes this MCPRetryConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPRetryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPRetryConfigCopyWith<MCPRetryConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPRetryConfigCopyWith<$Res> {
  factory $MCPRetryConfigCopyWith(
          MCPRetryConfig value, $Res Function(MCPRetryConfig) then) =
      _$MCPRetryConfigCopyWithImpl<$Res, MCPRetryConfig>;
  @useResult
  $Res call(
      {MCPErrorType errorType,
      int maxRetries,
      Duration baseDelay,
      double backoffMultiplier,
      Duration maxDelay,
      double jitter,
      bool exponentialBackoff});
}

/// @nodoc
class _$MCPRetryConfigCopyWithImpl<$Res, $Val extends MCPRetryConfig>
    implements $MCPRetryConfigCopyWith<$Res> {
  _$MCPRetryConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPRetryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorType = null,
    Object? maxRetries = null,
    Object? baseDelay = null,
    Object? backoffMultiplier = null,
    Object? maxDelay = null,
    Object? jitter = null,
    Object? exponentialBackoff = null,
  }) {
    return _then(_value.copyWith(
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as MCPErrorType,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      baseDelay: null == baseDelay
          ? _value.baseDelay
          : baseDelay // ignore: cast_nullable_to_non_nullable
              as Duration,
      backoffMultiplier: null == backoffMultiplier
          ? _value.backoffMultiplier
          : backoffMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      maxDelay: null == maxDelay
          ? _value.maxDelay
          : maxDelay // ignore: cast_nullable_to_non_nullable
              as Duration,
      jitter: null == jitter
          ? _value.jitter
          : jitter // ignore: cast_nullable_to_non_nullable
              as double,
      exponentialBackoff: null == exponentialBackoff
          ? _value.exponentialBackoff
          : exponentialBackoff // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPRetryConfigImplCopyWith<$Res>
    implements $MCPRetryConfigCopyWith<$Res> {
  factory _$$MCPRetryConfigImplCopyWith(_$MCPRetryConfigImpl value,
          $Res Function(_$MCPRetryConfigImpl) then) =
      __$$MCPRetryConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MCPErrorType errorType,
      int maxRetries,
      Duration baseDelay,
      double backoffMultiplier,
      Duration maxDelay,
      double jitter,
      bool exponentialBackoff});
}

/// @nodoc
class __$$MCPRetryConfigImplCopyWithImpl<$Res>
    extends _$MCPRetryConfigCopyWithImpl<$Res, _$MCPRetryConfigImpl>
    implements _$$MCPRetryConfigImplCopyWith<$Res> {
  __$$MCPRetryConfigImplCopyWithImpl(
      _$MCPRetryConfigImpl _value, $Res Function(_$MCPRetryConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPRetryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorType = null,
    Object? maxRetries = null,
    Object? baseDelay = null,
    Object? backoffMultiplier = null,
    Object? maxDelay = null,
    Object? jitter = null,
    Object? exponentialBackoff = null,
  }) {
    return _then(_$MCPRetryConfigImpl(
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as MCPErrorType,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      baseDelay: null == baseDelay
          ? _value.baseDelay
          : baseDelay // ignore: cast_nullable_to_non_nullable
              as Duration,
      backoffMultiplier: null == backoffMultiplier
          ? _value.backoffMultiplier
          : backoffMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      maxDelay: null == maxDelay
          ? _value.maxDelay
          : maxDelay // ignore: cast_nullable_to_non_nullable
              as Duration,
      jitter: null == jitter
          ? _value.jitter
          : jitter // ignore: cast_nullable_to_non_nullable
              as double,
      exponentialBackoff: null == exponentialBackoff
          ? _value.exponentialBackoff
          : exponentialBackoff // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPRetryConfigImpl implements _MCPRetryConfig {
  const _$MCPRetryConfigImpl(
      {required this.errorType,
      this.maxRetries = 3,
      this.baseDelay = const Duration(seconds: 1),
      this.backoffMultiplier = 2.0,
      this.maxDelay = const Duration(seconds: 30),
      this.jitter = 0.1,
      this.exponentialBackoff = true});

  factory _$MCPRetryConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPRetryConfigImplFromJson(json);

  @override
  final MCPErrorType errorType;
  @override
  @JsonKey()
  final int maxRetries;
  @override
  @JsonKey()
  final Duration baseDelay;
  @override
  @JsonKey()
  final double backoffMultiplier;
  @override
  @JsonKey()
  final Duration maxDelay;
  @override
  @JsonKey()
  final double jitter;
  @override
  @JsonKey()
  final bool exponentialBackoff;

  @override
  String toString() {
    return 'MCPRetryConfig(errorType: $errorType, maxRetries: $maxRetries, baseDelay: $baseDelay, backoffMultiplier: $backoffMultiplier, maxDelay: $maxDelay, jitter: $jitter, exponentialBackoff: $exponentialBackoff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPRetryConfigImpl &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries) &&
            (identical(other.baseDelay, baseDelay) ||
                other.baseDelay == baseDelay) &&
            (identical(other.backoffMultiplier, backoffMultiplier) ||
                other.backoffMultiplier == backoffMultiplier) &&
            (identical(other.maxDelay, maxDelay) ||
                other.maxDelay == maxDelay) &&
            (identical(other.jitter, jitter) || other.jitter == jitter) &&
            (identical(other.exponentialBackoff, exponentialBackoff) ||
                other.exponentialBackoff == exponentialBackoff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorType, maxRetries, baseDelay,
      backoffMultiplier, maxDelay, jitter, exponentialBackoff);

  /// Create a copy of MCPRetryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPRetryConfigImplCopyWith<_$MCPRetryConfigImpl> get copyWith =>
      __$$MCPRetryConfigImplCopyWithImpl<_$MCPRetryConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPRetryConfigImplToJson(
      this,
    );
  }
}

abstract class _MCPRetryConfig implements MCPRetryConfig {
  const factory _MCPRetryConfig(
      {required final MCPErrorType errorType,
      final int maxRetries,
      final Duration baseDelay,
      final double backoffMultiplier,
      final Duration maxDelay,
      final double jitter,
      final bool exponentialBackoff}) = _$MCPRetryConfigImpl;

  factory _MCPRetryConfig.fromJson(Map<String, dynamic> json) =
      _$MCPRetryConfigImpl.fromJson;

  @override
  MCPErrorType get errorType;
  @override
  int get maxRetries;
  @override
  Duration get baseDelay;
  @override
  double get backoffMultiplier;
  @override
  Duration get maxDelay;
  @override
  double get jitter;
  @override
  bool get exponentialBackoff;

  /// Create a copy of MCPRetryConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPRetryConfigImplCopyWith<_$MCPRetryConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPUserNotification _$MCPUserNotificationFromJson(Map<String, dynamic> json) {
  return _MCPUserNotification.fromJson(json);
}

/// @nodoc
mixin _$MCPUserNotification {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MCPNotificationType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isDismissible => throw _privateConstructorUsedError;
  Duration get displayDuration => throw _privateConstructorUsedError;
  List<MCPNotificationAction>? get actions =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MCPUserNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPUserNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPUserNotificationCopyWith<MCPUserNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPUserNotificationCopyWith<$Res> {
  factory $MCPUserNotificationCopyWith(
          MCPUserNotification value, $Res Function(MCPUserNotification) then) =
      _$MCPUserNotificationCopyWithImpl<$Res, MCPUserNotification>;
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      MCPNotificationType type,
      DateTime timestamp,
      bool isDismissible,
      Duration displayDuration,
      List<MCPNotificationAction>? actions,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MCPUserNotificationCopyWithImpl<$Res, $Val extends MCPUserNotification>
    implements $MCPUserNotificationCopyWith<$Res> {
  _$MCPUserNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPUserNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? timestamp = null,
    Object? isDismissible = null,
    Object? displayDuration = null,
    Object? actions = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MCPNotificationType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDismissible: null == isDismissible
          ? _value.isDismissible
          : isDismissible // ignore: cast_nullable_to_non_nullable
              as bool,
      displayDuration: null == displayDuration
          ? _value.displayDuration
          : displayDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<MCPNotificationAction>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPUserNotificationImplCopyWith<$Res>
    implements $MCPUserNotificationCopyWith<$Res> {
  factory _$$MCPUserNotificationImplCopyWith(_$MCPUserNotificationImpl value,
          $Res Function(_$MCPUserNotificationImpl) then) =
      __$$MCPUserNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      MCPNotificationType type,
      DateTime timestamp,
      bool isDismissible,
      Duration displayDuration,
      List<MCPNotificationAction>? actions,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MCPUserNotificationImplCopyWithImpl<$Res>
    extends _$MCPUserNotificationCopyWithImpl<$Res, _$MCPUserNotificationImpl>
    implements _$$MCPUserNotificationImplCopyWith<$Res> {
  __$$MCPUserNotificationImplCopyWithImpl(_$MCPUserNotificationImpl _value,
      $Res Function(_$MCPUserNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPUserNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? timestamp = null,
    Object? isDismissible = null,
    Object? displayDuration = null,
    Object? actions = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MCPUserNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MCPNotificationType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDismissible: null == isDismissible
          ? _value.isDismissible
          : isDismissible // ignore: cast_nullable_to_non_nullable
              as bool,
      displayDuration: null == displayDuration
          ? _value.displayDuration
          : displayDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<MCPNotificationAction>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPUserNotificationImpl implements _MCPUserNotification {
  const _$MCPUserNotificationImpl(
      {required this.id,
      required this.title,
      required this.message,
      required this.type,
      required this.timestamp,
      this.isDismissible = false,
      this.displayDuration = const Duration(seconds: 5),
      final List<MCPNotificationAction>? actions,
      final Map<String, dynamic>? metadata})
      : _actions = actions,
        _metadata = metadata;

  factory _$MCPUserNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPUserNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String message;
  @override
  final MCPNotificationType type;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isDismissible;
  @override
  @JsonKey()
  final Duration displayDuration;
  final List<MCPNotificationAction>? _actions;
  @override
  List<MCPNotificationAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MCPUserNotification(id: $id, title: $title, message: $message, type: $type, timestamp: $timestamp, isDismissible: $isDismissible, displayDuration: $displayDuration, actions: $actions, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPUserNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isDismissible, isDismissible) ||
                other.isDismissible == isDismissible) &&
            (identical(other.displayDuration, displayDuration) ||
                other.displayDuration == displayDuration) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      message,
      type,
      timestamp,
      isDismissible,
      displayDuration,
      const DeepCollectionEquality().hash(_actions),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MCPUserNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPUserNotificationImplCopyWith<_$MCPUserNotificationImpl> get copyWith =>
      __$$MCPUserNotificationImplCopyWithImpl<_$MCPUserNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPUserNotificationImplToJson(
      this,
    );
  }
}

abstract class _MCPUserNotification implements MCPUserNotification {
  const factory _MCPUserNotification(
      {required final String id,
      required final String title,
      required final String message,
      required final MCPNotificationType type,
      required final DateTime timestamp,
      final bool isDismissible,
      final Duration displayDuration,
      final List<MCPNotificationAction>? actions,
      final Map<String, dynamic>? metadata}) = _$MCPUserNotificationImpl;

  factory _MCPUserNotification.fromJson(Map<String, dynamic> json) =
      _$MCPUserNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get message;
  @override
  MCPNotificationType get type;
  @override
  DateTime get timestamp;
  @override
  bool get isDismissible;
  @override
  Duration get displayDuration;
  @override
  List<MCPNotificationAction>? get actions;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MCPUserNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPUserNotificationImplCopyWith<_$MCPUserNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPNotificationAction _$MCPNotificationActionFromJson(
    Map<String, dynamic> json) {
  return _MCPNotificationAction.fromJson(json);
}

/// @nodoc
mixin _$MCPNotificationAction {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  MCPRecoveryActionType get actionType => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parameters => throw _privateConstructorUsedError;

  /// Serializes this MCPNotificationAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPNotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPNotificationActionCopyWith<MCPNotificationAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPNotificationActionCopyWith<$Res> {
  factory $MCPNotificationActionCopyWith(MCPNotificationAction value,
          $Res Function(MCPNotificationAction) then) =
      _$MCPNotificationActionCopyWithImpl<$Res, MCPNotificationAction>;
  @useResult
  $Res call(
      {String id,
      String label,
      MCPRecoveryActionType actionType,
      Map<String, dynamic>? parameters});
}

/// @nodoc
class _$MCPNotificationActionCopyWithImpl<$Res,
        $Val extends MCPNotificationAction>
    implements $MCPNotificationActionCopyWith<$Res> {
  _$MCPNotificationActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPNotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? actionType = null,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as MCPRecoveryActionType,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPNotificationActionImplCopyWith<$Res>
    implements $MCPNotificationActionCopyWith<$Res> {
  factory _$$MCPNotificationActionImplCopyWith(
          _$MCPNotificationActionImpl value,
          $Res Function(_$MCPNotificationActionImpl) then) =
      __$$MCPNotificationActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      MCPRecoveryActionType actionType,
      Map<String, dynamic>? parameters});
}

/// @nodoc
class __$$MCPNotificationActionImplCopyWithImpl<$Res>
    extends _$MCPNotificationActionCopyWithImpl<$Res,
        _$MCPNotificationActionImpl>
    implements _$$MCPNotificationActionImplCopyWith<$Res> {
  __$$MCPNotificationActionImplCopyWithImpl(_$MCPNotificationActionImpl _value,
      $Res Function(_$MCPNotificationActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPNotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? actionType = null,
    Object? parameters = freezed,
  }) {
    return _then(_$MCPNotificationActionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as MCPRecoveryActionType,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPNotificationActionImpl implements _MCPNotificationAction {
  const _$MCPNotificationActionImpl(
      {required this.id,
      required this.label,
      required this.actionType,
      final Map<String, dynamic>? parameters})
      : _parameters = parameters;

  factory _$MCPNotificationActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPNotificationActionImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final MCPRecoveryActionType actionType;
  final Map<String, dynamic>? _parameters;
  @override
  Map<String, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MCPNotificationAction(id: $id, label: $label, actionType: $actionType, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPNotificationActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, actionType,
      const DeepCollectionEquality().hash(_parameters));

  /// Create a copy of MCPNotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPNotificationActionImplCopyWith<_$MCPNotificationActionImpl>
      get copyWith => __$$MCPNotificationActionImplCopyWithImpl<
          _$MCPNotificationActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPNotificationActionImplToJson(
      this,
    );
  }
}

abstract class _MCPNotificationAction implements MCPNotificationAction {
  const factory _MCPNotificationAction(
      {required final String id,
      required final String label,
      required final MCPRecoveryActionType actionType,
      final Map<String, dynamic>? parameters}) = _$MCPNotificationActionImpl;

  factory _MCPNotificationAction.fromJson(Map<String, dynamic> json) =
      _$MCPNotificationActionImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  MCPRecoveryActionType get actionType;
  @override
  Map<String, dynamic>? get parameters;

  /// Create a copy of MCPNotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPNotificationActionImplCopyWith<_$MCPNotificationActionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
