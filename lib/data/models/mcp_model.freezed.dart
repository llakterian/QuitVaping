// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MCPServerConfig _$MCPServerConfigFromJson(Map<String, dynamic> json) {
  return _MCPServerConfig.fromJson(json);
}

/// @nodoc
mixin _$MCPServerConfig {
  String get serverId => throw _privateConstructorUsedError;
  String get command => throw _privateConstructorUsedError;
  List<String> get args => throw _privateConstructorUsedError;
  Map<String, String> get env => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;
  List<String> get autoApprove => throw _privateConstructorUsedError;

  /// Serializes this MCPServerConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPServerConfigCopyWith<MCPServerConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServerConfigCopyWith<$Res> {
  factory $MCPServerConfigCopyWith(
          MCPServerConfig value, $Res Function(MCPServerConfig) then) =
      _$MCPServerConfigCopyWithImpl<$Res, MCPServerConfig>;
  @useResult
  $Res call(
      {String serverId,
      String command,
      List<String> args,
      Map<String, String> env,
      bool disabled,
      List<String> autoApprove});
}

/// @nodoc
class _$MCPServerConfigCopyWithImpl<$Res, $Val extends MCPServerConfig>
    implements $MCPServerConfigCopyWith<$Res> {
  _$MCPServerConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? command = null,
    Object? args = null,
    Object? env = null,
    Object? disabled = null,
    Object? autoApprove = null,
  }) {
    return _then(_value.copyWith(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      args: null == args
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as List<String>,
      env: null == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoApprove: null == autoApprove
          ? _value.autoApprove
          : autoApprove // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPServerConfigImplCopyWith<$Res>
    implements $MCPServerConfigCopyWith<$Res> {
  factory _$$MCPServerConfigImplCopyWith(_$MCPServerConfigImpl value,
          $Res Function(_$MCPServerConfigImpl) then) =
      __$$MCPServerConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serverId,
      String command,
      List<String> args,
      Map<String, String> env,
      bool disabled,
      List<String> autoApprove});
}

/// @nodoc
class __$$MCPServerConfigImplCopyWithImpl<$Res>
    extends _$MCPServerConfigCopyWithImpl<$Res, _$MCPServerConfigImpl>
    implements _$$MCPServerConfigImplCopyWith<$Res> {
  __$$MCPServerConfigImplCopyWithImpl(
      _$MCPServerConfigImpl _value, $Res Function(_$MCPServerConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? command = null,
    Object? args = null,
    Object? env = null,
    Object? disabled = null,
    Object? autoApprove = null,
  }) {
    return _then(_$MCPServerConfigImpl(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      args: null == args
          ? _value._args
          : args // ignore: cast_nullable_to_non_nullable
              as List<String>,
      env: null == env
          ? _value._env
          : env // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoApprove: null == autoApprove
          ? _value._autoApprove
          : autoApprove // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServerConfigImpl implements _MCPServerConfig {
  const _$MCPServerConfigImpl(
      {required this.serverId,
      required this.command,
      required final List<String> args,
      required final Map<String, String> env,
      this.disabled = false,
      final List<String> autoApprove = const []})
      : _args = args,
        _env = env,
        _autoApprove = autoApprove;

  factory _$MCPServerConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServerConfigImplFromJson(json);

  @override
  final String serverId;
  @override
  final String command;
  final List<String> _args;
  @override
  List<String> get args {
    if (_args is EqualUnmodifiableListView) return _args;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_args);
  }

  final Map<String, String> _env;
  @override
  Map<String, String> get env {
    if (_env is EqualUnmodifiableMapView) return _env;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_env);
  }

  @override
  @JsonKey()
  final bool disabled;
  final List<String> _autoApprove;
  @override
  @JsonKey()
  List<String> get autoApprove {
    if (_autoApprove is EqualUnmodifiableListView) return _autoApprove;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_autoApprove);
  }

  @override
  String toString() {
    return 'MCPServerConfig(serverId: $serverId, command: $command, args: $args, env: $env, disabled: $disabled, autoApprove: $autoApprove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServerConfigImpl &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.command, command) || other.command == command) &&
            const DeepCollectionEquality().equals(other._args, _args) &&
            const DeepCollectionEquality().equals(other._env, _env) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            const DeepCollectionEquality()
                .equals(other._autoApprove, _autoApprove));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serverId,
      command,
      const DeepCollectionEquality().hash(_args),
      const DeepCollectionEquality().hash(_env),
      disabled,
      const DeepCollectionEquality().hash(_autoApprove));

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServerConfigImplCopyWith<_$MCPServerConfigImpl> get copyWith =>
      __$$MCPServerConfigImplCopyWithImpl<_$MCPServerConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServerConfigImplToJson(
      this,
    );
  }
}

abstract class _MCPServerConfig implements MCPServerConfig {
  const factory _MCPServerConfig(
      {required final String serverId,
      required final String command,
      required final List<String> args,
      required final Map<String, String> env,
      final bool disabled,
      final List<String> autoApprove}) = _$MCPServerConfigImpl;

  factory _MCPServerConfig.fromJson(Map<String, dynamic> json) =
      _$MCPServerConfigImpl.fromJson;

  @override
  String get serverId;
  @override
  String get command;
  @override
  List<String> get args;
  @override
  Map<String, String> get env;
  @override
  bool get disabled;
  @override
  List<String> get autoApprove;

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPServerConfigImplCopyWith<_$MCPServerConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPRequest _$MCPRequestFromJson(Map<String, dynamic> json) {
  return _MCPRequest.fromJson(json);
}

/// @nodoc
mixin _$MCPRequest {
  String get id => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  Map<String, dynamic> get params => throw _privateConstructorUsedError;
  String get serverId => throw _privateConstructorUsedError;
  int get timeoutSeconds => throw _privateConstructorUsedError;

  /// Serializes this MCPRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPRequestCopyWith<MCPRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPRequestCopyWith<$Res> {
  factory $MCPRequestCopyWith(
          MCPRequest value, $Res Function(MCPRequest) then) =
      _$MCPRequestCopyWithImpl<$Res, MCPRequest>;
  @useResult
  $Res call(
      {String id,
      String method,
      Map<String, dynamic> params,
      String serverId,
      int timeoutSeconds});
}

/// @nodoc
class _$MCPRequestCopyWithImpl<$Res, $Val extends MCPRequest>
    implements $MCPRequestCopyWith<$Res> {
  _$MCPRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? params = null,
    Object? serverId = null,
    Object? timeoutSeconds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      timeoutSeconds: null == timeoutSeconds
          ? _value.timeoutSeconds
          : timeoutSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPRequestImplCopyWith<$Res>
    implements $MCPRequestCopyWith<$Res> {
  factory _$$MCPRequestImplCopyWith(
          _$MCPRequestImpl value, $Res Function(_$MCPRequestImpl) then) =
      __$$MCPRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String method,
      Map<String, dynamic> params,
      String serverId,
      int timeoutSeconds});
}

/// @nodoc
class __$$MCPRequestImplCopyWithImpl<$Res>
    extends _$MCPRequestCopyWithImpl<$Res, _$MCPRequestImpl>
    implements _$$MCPRequestImplCopyWith<$Res> {
  __$$MCPRequestImplCopyWithImpl(
      _$MCPRequestImpl _value, $Res Function(_$MCPRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? params = null,
    Object? serverId = null,
    Object? timeoutSeconds = null,
  }) {
    return _then(_$MCPRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value._params
          : params // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      timeoutSeconds: null == timeoutSeconds
          ? _value.timeoutSeconds
          : timeoutSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPRequestImpl implements _MCPRequest {
  const _$MCPRequestImpl(
      {required this.id,
      required this.method,
      required final Map<String, dynamic> params,
      required this.serverId,
      this.timeoutSeconds = 30})
      : _params = params;

  factory _$MCPRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String method;
  final Map<String, dynamic> _params;
  @override
  Map<String, dynamic> get params {
    if (_params is EqualUnmodifiableMapView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_params);
  }

  @override
  final String serverId;
  @override
  @JsonKey()
  final int timeoutSeconds;

  @override
  String toString() {
    return 'MCPRequest(id: $id, method: $method, params: $params, serverId: $serverId, timeoutSeconds: $timeoutSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other._params, _params) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.timeoutSeconds, timeoutSeconds) ||
                other.timeoutSeconds == timeoutSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, method,
      const DeepCollectionEquality().hash(_params), serverId, timeoutSeconds);

  /// Create a copy of MCPRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPRequestImplCopyWith<_$MCPRequestImpl> get copyWith =>
      __$$MCPRequestImplCopyWithImpl<_$MCPRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPRequestImplToJson(
      this,
    );
  }
}

abstract class _MCPRequest implements MCPRequest {
  const factory _MCPRequest(
      {required final String id,
      required final String method,
      required final Map<String, dynamic> params,
      required final String serverId,
      final int timeoutSeconds}) = _$MCPRequestImpl;

  factory _MCPRequest.fromJson(Map<String, dynamic> json) =
      _$MCPRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get method;
  @override
  Map<String, dynamic> get params;
  @override
  String get serverId;
  @override
  int get timeoutSeconds;

  /// Create a copy of MCPRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPRequestImplCopyWith<_$MCPRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPResponse _$MCPResponseFromJson(Map<String, dynamic> json) {
  return _MCPResponse.fromJson(json);
}

/// @nodoc
mixin _$MCPResponse {
  String get id => throw _privateConstructorUsedError;
  String get serverId => throw _privateConstructorUsedError;
  MCPResponseType get responseType => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<RecommendedAction> get nextActions => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this MCPResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPResponseCopyWith<MCPResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPResponseCopyWith<$Res> {
  factory $MCPResponseCopyWith(
          MCPResponse value, $Res Function(MCPResponse) then) =
      _$MCPResponseCopyWithImpl<$Res, MCPResponse>;
  @useResult
  $Res call(
      {String id,
      String serverId,
      MCPResponseType responseType,
      Map<String, dynamic> data,
      double confidence,
      List<RecommendedAction> nextActions,
      DateTime timestamp,
      String? error});
}

/// @nodoc
class _$MCPResponseCopyWithImpl<$Res, $Val extends MCPResponse>
    implements $MCPResponseCopyWith<$Res> {
  _$MCPResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serverId = null,
    Object? responseType = null,
    Object? data = null,
    Object? confidence = null,
    Object? nextActions = null,
    Object? timestamp = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      responseType: null == responseType
          ? _value.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as MCPResponseType,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      nextActions: null == nextActions
          ? _value.nextActions
          : nextActions // ignore: cast_nullable_to_non_nullable
              as List<RecommendedAction>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPResponseImplCopyWith<$Res>
    implements $MCPResponseCopyWith<$Res> {
  factory _$$MCPResponseImplCopyWith(
          _$MCPResponseImpl value, $Res Function(_$MCPResponseImpl) then) =
      __$$MCPResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String serverId,
      MCPResponseType responseType,
      Map<String, dynamic> data,
      double confidence,
      List<RecommendedAction> nextActions,
      DateTime timestamp,
      String? error});
}

/// @nodoc
class __$$MCPResponseImplCopyWithImpl<$Res>
    extends _$MCPResponseCopyWithImpl<$Res, _$MCPResponseImpl>
    implements _$$MCPResponseImplCopyWith<$Res> {
  __$$MCPResponseImplCopyWithImpl(
      _$MCPResponseImpl _value, $Res Function(_$MCPResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serverId = null,
    Object? responseType = null,
    Object? data = null,
    Object? confidence = null,
    Object? nextActions = null,
    Object? timestamp = null,
    Object? error = freezed,
  }) {
    return _then(_$MCPResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      responseType: null == responseType
          ? _value.responseType
          : responseType // ignore: cast_nullable_to_non_nullable
              as MCPResponseType,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      nextActions: null == nextActions
          ? _value._nextActions
          : nextActions // ignore: cast_nullable_to_non_nullable
              as List<RecommendedAction>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPResponseImpl implements _MCPResponse {
  const _$MCPResponseImpl(
      {required this.id,
      required this.serverId,
      required this.responseType,
      required final Map<String, dynamic> data,
      this.confidence = 1.0,
      final List<RecommendedAction> nextActions = const [],
      required this.timestamp,
      this.error})
      : _data = data,
        _nextActions = nextActions;

  factory _$MCPResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String serverId;
  @override
  final MCPResponseType responseType;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  final double confidence;
  final List<RecommendedAction> _nextActions;
  @override
  @JsonKey()
  List<RecommendedAction> get nextActions {
    if (_nextActions is EqualUnmodifiableListView) return _nextActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nextActions);
  }

  @override
  final DateTime timestamp;
  @override
  final String? error;

  @override
  String toString() {
    return 'MCPResponse(id: $id, serverId: $serverId, responseType: $responseType, data: $data, confidence: $confidence, nextActions: $nextActions, timestamp: $timestamp, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.responseType, responseType) ||
                other.responseType == responseType) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._nextActions, _nextActions) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      serverId,
      responseType,
      const DeepCollectionEquality().hash(_data),
      confidence,
      const DeepCollectionEquality().hash(_nextActions),
      timestamp,
      error);

  /// Create a copy of MCPResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPResponseImplCopyWith<_$MCPResponseImpl> get copyWith =>
      __$$MCPResponseImplCopyWithImpl<_$MCPResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPResponseImplToJson(
      this,
    );
  }
}

abstract class _MCPResponse implements MCPResponse {
  const factory _MCPResponse(
      {required final String id,
      required final String serverId,
      required final MCPResponseType responseType,
      required final Map<String, dynamic> data,
      final double confidence,
      final List<RecommendedAction> nextActions,
      required final DateTime timestamp,
      final String? error}) = _$MCPResponseImpl;

  factory _MCPResponse.fromJson(Map<String, dynamic> json) =
      _$MCPResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get serverId;
  @override
  MCPResponseType get responseType;
  @override
  Map<String, dynamic> get data;
  @override
  double get confidence;
  @override
  List<RecommendedAction> get nextActions;
  @override
  DateTime get timestamp;
  @override
  String? get error;

  /// Create a copy of MCPResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPResponseImplCopyWith<_$MCPResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecommendedAction _$RecommendedActionFromJson(Map<String, dynamic> json) {
  return _RecommendedAction.fromJson(json);
}

/// @nodoc
mixin _$RecommendedAction {
  String get actionType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  double get priority => throw _privateConstructorUsedError;

  /// Serializes this RecommendedAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendedAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendedActionCopyWith<RecommendedAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedActionCopyWith<$Res> {
  factory $RecommendedActionCopyWith(
          RecommendedAction value, $Res Function(RecommendedAction) then) =
      _$RecommendedActionCopyWithImpl<$Res, RecommendedAction>;
  @useResult
  $Res call(
      {String actionType,
      String description,
      Map<String, dynamic> parameters,
      double priority});
}

/// @nodoc
class _$RecommendedActionCopyWithImpl<$Res, $Val extends RecommendedAction>
    implements $RecommendedActionCopyWith<$Res> {
  _$RecommendedActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendedAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? description = null,
    Object? parameters = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendedActionImplCopyWith<$Res>
    implements $RecommendedActionCopyWith<$Res> {
  factory _$$RecommendedActionImplCopyWith(_$RecommendedActionImpl value,
          $Res Function(_$RecommendedActionImpl) then) =
      __$$RecommendedActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String actionType,
      String description,
      Map<String, dynamic> parameters,
      double priority});
}

/// @nodoc
class __$$RecommendedActionImplCopyWithImpl<$Res>
    extends _$RecommendedActionCopyWithImpl<$Res, _$RecommendedActionImpl>
    implements _$$RecommendedActionImplCopyWith<$Res> {
  __$$RecommendedActionImplCopyWithImpl(_$RecommendedActionImpl _value,
      $Res Function(_$RecommendedActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendedAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? description = null,
    Object? parameters = null,
    Object? priority = null,
  }) {
    return _then(_$RecommendedActionImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendedActionImpl implements _RecommendedAction {
  const _$RecommendedActionImpl(
      {required this.actionType,
      required this.description,
      required final Map<String, dynamic> parameters,
      this.priority = 1.0})
      : _parameters = parameters;

  factory _$RecommendedActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendedActionImplFromJson(json);

  @override
  final String actionType;
  @override
  final String description;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  @JsonKey()
  final double priority;

  @override
  String toString() {
    return 'RecommendedAction(actionType: $actionType, description: $description, parameters: $parameters, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendedActionImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, actionType, description,
      const DeepCollectionEquality().hash(_parameters), priority);

  /// Create a copy of RecommendedAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendedActionImplCopyWith<_$RecommendedActionImpl> get copyWith =>
      __$$RecommendedActionImplCopyWithImpl<_$RecommendedActionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendedActionImplToJson(
      this,
    );
  }
}

abstract class _RecommendedAction implements RecommendedAction {
  const factory _RecommendedAction(
      {required final String actionType,
      required final String description,
      required final Map<String, dynamic> parameters,
      final double priority}) = _$RecommendedActionImpl;

  factory _RecommendedAction.fromJson(Map<String, dynamic> json) =
      _$RecommendedActionImpl.fromJson;

  @override
  String get actionType;
  @override
  String get description;
  @override
  Map<String, dynamic> get parameters;
  @override
  double get priority;

  /// Create a copy of RecommendedAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendedActionImplCopyWith<_$RecommendedActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPServerStatus _$MCPServerStatusFromJson(Map<String, dynamic> json) {
  return _MCPServerStatus.fromJson(json);
}

/// @nodoc
mixin _$MCPServerStatus {
  String get serverId => throw _privateConstructorUsedError;
  MCPConnectionStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get lastConnected => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  int get maxRetries => throw _privateConstructorUsedError;

  /// Serializes this MCPServerStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPServerStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPServerStatusCopyWith<MCPServerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServerStatusCopyWith<$Res> {
  factory $MCPServerStatusCopyWith(
          MCPServerStatus value, $Res Function(MCPServerStatus) then) =
      _$MCPServerStatusCopyWithImpl<$Res, MCPServerStatus>;
  @useResult
  $Res call(
      {String serverId,
      MCPConnectionStatus status,
      String? error,
      DateTime? lastConnected,
      int retryCount,
      int maxRetries});
}

/// @nodoc
class _$MCPServerStatusCopyWithImpl<$Res, $Val extends MCPServerStatus>
    implements $MCPServerStatusCopyWith<$Res> {
  _$MCPServerStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPServerStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? status = null,
    Object? error = freezed,
    Object? lastConnected = freezed,
    Object? retryCount = null,
    Object? maxRetries = null,
  }) {
    return _then(_value.copyWith(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MCPConnectionStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPServerStatusImplCopyWith<$Res>
    implements $MCPServerStatusCopyWith<$Res> {
  factory _$$MCPServerStatusImplCopyWith(_$MCPServerStatusImpl value,
          $Res Function(_$MCPServerStatusImpl) then) =
      __$$MCPServerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serverId,
      MCPConnectionStatus status,
      String? error,
      DateTime? lastConnected,
      int retryCount,
      int maxRetries});
}

/// @nodoc
class __$$MCPServerStatusImplCopyWithImpl<$Res>
    extends _$MCPServerStatusCopyWithImpl<$Res, _$MCPServerStatusImpl>
    implements _$$MCPServerStatusImplCopyWith<$Res> {
  __$$MCPServerStatusImplCopyWithImpl(
      _$MCPServerStatusImpl _value, $Res Function(_$MCPServerStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPServerStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? status = null,
    Object? error = freezed,
    Object? lastConnected = freezed,
    Object? retryCount = null,
    Object? maxRetries = null,
  }) {
    return _then(_$MCPServerStatusImpl(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MCPConnectionStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServerStatusImpl implements _MCPServerStatus {
  const _$MCPServerStatusImpl(
      {required this.serverId,
      required this.status,
      this.error,
      this.lastConnected,
      this.retryCount = 0,
      this.maxRetries = 0});

  factory _$MCPServerStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServerStatusImplFromJson(json);

  @override
  final String serverId;
  @override
  final MCPConnectionStatus status;
  @override
  final String? error;
  @override
  final DateTime? lastConnected;
  @override
  @JsonKey()
  final int retryCount;
  @override
  @JsonKey()
  final int maxRetries;

  @override
  String toString() {
    return 'MCPServerStatus(serverId: $serverId, status: $status, error: $error, lastConnected: $lastConnected, retryCount: $retryCount, maxRetries: $maxRetries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServerStatusImpl &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serverId, status, error,
      lastConnected, retryCount, maxRetries);

  /// Create a copy of MCPServerStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServerStatusImplCopyWith<_$MCPServerStatusImpl> get copyWith =>
      __$$MCPServerStatusImplCopyWithImpl<_$MCPServerStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServerStatusImplToJson(
      this,
    );
  }
}

abstract class _MCPServerStatus implements MCPServerStatus {
  const factory _MCPServerStatus(
      {required final String serverId,
      required final MCPConnectionStatus status,
      final String? error,
      final DateTime? lastConnected,
      final int retryCount,
      final int maxRetries}) = _$MCPServerStatusImpl;

  factory _MCPServerStatus.fromJson(Map<String, dynamic> json) =
      _$MCPServerStatusImpl.fromJson;

  @override
  String get serverId;
  @override
  MCPConnectionStatus get status;
  @override
  String? get error;
  @override
  DateTime? get lastConnected;
  @override
  int get retryCount;
  @override
  int get maxRetries;

  /// Create a copy of MCPServerStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPServerStatusImplCopyWith<_$MCPServerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIWorkflowContext _$AIWorkflowContextFromJson(Map<String, dynamic> json) {
  return _AIWorkflowContext.fromJson(json);
}

/// @nodoc
mixin _$AIWorkflowContext {
  String get userId => throw _privateConstructorUsedError;
  MoodState get currentMood => throw _privateConstructorUsedError;
  List<UserActivity> get recentActivity => throw _privateConstructorUsedError;
  ExternalFactors get externalFactors => throw _privateConstructorUsedError;
  List<InterventionType> get availableInterventions =>
      throw _privateConstructorUsedError;
  UserLearningProfile get learningData => throw _privateConstructorUsedError;

  /// Serializes this AIWorkflowContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIWorkflowContextCopyWith<AIWorkflowContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIWorkflowContextCopyWith<$Res> {
  factory $AIWorkflowContextCopyWith(
          AIWorkflowContext value, $Res Function(AIWorkflowContext) then) =
      _$AIWorkflowContextCopyWithImpl<$Res, AIWorkflowContext>;
  @useResult
  $Res call(
      {String userId,
      MoodState currentMood,
      List<UserActivity> recentActivity,
      ExternalFactors externalFactors,
      List<InterventionType> availableInterventions,
      UserLearningProfile learningData});

  $ExternalFactorsCopyWith<$Res> get externalFactors;
  $UserLearningProfileCopyWith<$Res> get learningData;
}

/// @nodoc
class _$AIWorkflowContextCopyWithImpl<$Res, $Val extends AIWorkflowContext>
    implements $AIWorkflowContextCopyWith<$Res> {
  _$AIWorkflowContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentMood = null,
    Object? recentActivity = null,
    Object? externalFactors = null,
    Object? availableInterventions = null,
    Object? learningData = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentMood: null == currentMood
          ? _value.currentMood
          : currentMood // ignore: cast_nullable_to_non_nullable
              as MoodState,
      recentActivity: null == recentActivity
          ? _value.recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<UserActivity>,
      externalFactors: null == externalFactors
          ? _value.externalFactors
          : externalFactors // ignore: cast_nullable_to_non_nullable
              as ExternalFactors,
      availableInterventions: null == availableInterventions
          ? _value.availableInterventions
          : availableInterventions // ignore: cast_nullable_to_non_nullable
              as List<InterventionType>,
      learningData: null == learningData
          ? _value.learningData
          : learningData // ignore: cast_nullable_to_non_nullable
              as UserLearningProfile,
    ) as $Val);
  }

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalFactorsCopyWith<$Res> get externalFactors {
    return $ExternalFactorsCopyWith<$Res>(_value.externalFactors, (value) {
      return _then(_value.copyWith(externalFactors: value) as $Val);
    });
  }

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserLearningProfileCopyWith<$Res> get learningData {
    return $UserLearningProfileCopyWith<$Res>(_value.learningData, (value) {
      return _then(_value.copyWith(learningData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AIWorkflowContextImplCopyWith<$Res>
    implements $AIWorkflowContextCopyWith<$Res> {
  factory _$$AIWorkflowContextImplCopyWith(_$AIWorkflowContextImpl value,
          $Res Function(_$AIWorkflowContextImpl) then) =
      __$$AIWorkflowContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      MoodState currentMood,
      List<UserActivity> recentActivity,
      ExternalFactors externalFactors,
      List<InterventionType> availableInterventions,
      UserLearningProfile learningData});

  @override
  $ExternalFactorsCopyWith<$Res> get externalFactors;
  @override
  $UserLearningProfileCopyWith<$Res> get learningData;
}

/// @nodoc
class __$$AIWorkflowContextImplCopyWithImpl<$Res>
    extends _$AIWorkflowContextCopyWithImpl<$Res, _$AIWorkflowContextImpl>
    implements _$$AIWorkflowContextImplCopyWith<$Res> {
  __$$AIWorkflowContextImplCopyWithImpl(_$AIWorkflowContextImpl _value,
      $Res Function(_$AIWorkflowContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentMood = null,
    Object? recentActivity = null,
    Object? externalFactors = null,
    Object? availableInterventions = null,
    Object? learningData = null,
  }) {
    return _then(_$AIWorkflowContextImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      currentMood: null == currentMood
          ? _value.currentMood
          : currentMood // ignore: cast_nullable_to_non_nullable
              as MoodState,
      recentActivity: null == recentActivity
          ? _value._recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<UserActivity>,
      externalFactors: null == externalFactors
          ? _value.externalFactors
          : externalFactors // ignore: cast_nullable_to_non_nullable
              as ExternalFactors,
      availableInterventions: null == availableInterventions
          ? _value._availableInterventions
          : availableInterventions // ignore: cast_nullable_to_non_nullable
              as List<InterventionType>,
      learningData: null == learningData
          ? _value.learningData
          : learningData // ignore: cast_nullable_to_non_nullable
              as UserLearningProfile,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIWorkflowContextImpl implements _AIWorkflowContext {
  const _$AIWorkflowContextImpl(
      {required this.userId,
      required this.currentMood,
      required final List<UserActivity> recentActivity,
      required this.externalFactors,
      required final List<InterventionType> availableInterventions,
      required this.learningData})
      : _recentActivity = recentActivity,
        _availableInterventions = availableInterventions;

  factory _$AIWorkflowContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIWorkflowContextImplFromJson(json);

  @override
  final String userId;
  @override
  final MoodState currentMood;
  final List<UserActivity> _recentActivity;
  @override
  List<UserActivity> get recentActivity {
    if (_recentActivity is EqualUnmodifiableListView) return _recentActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivity);
  }

  @override
  final ExternalFactors externalFactors;
  final List<InterventionType> _availableInterventions;
  @override
  List<InterventionType> get availableInterventions {
    if (_availableInterventions is EqualUnmodifiableListView)
      return _availableInterventions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableInterventions);
  }

  @override
  final UserLearningProfile learningData;

  @override
  String toString() {
    return 'AIWorkflowContext(userId: $userId, currentMood: $currentMood, recentActivity: $recentActivity, externalFactors: $externalFactors, availableInterventions: $availableInterventions, learningData: $learningData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIWorkflowContextImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentMood, currentMood) ||
                other.currentMood == currentMood) &&
            const DeepCollectionEquality()
                .equals(other._recentActivity, _recentActivity) &&
            (identical(other.externalFactors, externalFactors) ||
                other.externalFactors == externalFactors) &&
            const DeepCollectionEquality().equals(
                other._availableInterventions, _availableInterventions) &&
            (identical(other.learningData, learningData) ||
                other.learningData == learningData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      currentMood,
      const DeepCollectionEquality().hash(_recentActivity),
      externalFactors,
      const DeepCollectionEquality().hash(_availableInterventions),
      learningData);

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIWorkflowContextImplCopyWith<_$AIWorkflowContextImpl> get copyWith =>
      __$$AIWorkflowContextImplCopyWithImpl<_$AIWorkflowContextImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIWorkflowContextImplToJson(
      this,
    );
  }
}

abstract class _AIWorkflowContext implements AIWorkflowContext {
  const factory _AIWorkflowContext(
          {required final String userId,
          required final MoodState currentMood,
          required final List<UserActivity> recentActivity,
          required final ExternalFactors externalFactors,
          required final List<InterventionType> availableInterventions,
          required final UserLearningProfile learningData}) =
      _$AIWorkflowContextImpl;

  factory _AIWorkflowContext.fromJson(Map<String, dynamic> json) =
      _$AIWorkflowContextImpl.fromJson;

  @override
  String get userId;
  @override
  MoodState get currentMood;
  @override
  List<UserActivity> get recentActivity;
  @override
  ExternalFactors get externalFactors;
  @override
  List<InterventionType> get availableInterventions;
  @override
  UserLearningProfile get learningData;

  /// Create a copy of AIWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIWorkflowContextImplCopyWith<_$AIWorkflowContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) {
  return _UserActivity.fromJson(json);
}

/// @nodoc
mixin _$UserActivity {
  String get activityType => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this UserActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserActivityCopyWith<UserActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActivityCopyWith<$Res> {
  factory $UserActivityCopyWith(
          UserActivity value, $Res Function(UserActivity) then) =
      _$UserActivityCopyWithImpl<$Res, UserActivity>;
  @useResult
  $Res call(
      {String activityType, DateTime timestamp, Map<String, dynamic> data});
}

/// @nodoc
class _$UserActivityCopyWithImpl<$Res, $Val extends UserActivity>
    implements $UserActivityCopyWith<$Res> {
  _$UserActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? timestamp = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserActivityImplCopyWith<$Res>
    implements $UserActivityCopyWith<$Res> {
  factory _$$UserActivityImplCopyWith(
          _$UserActivityImpl value, $Res Function(_$UserActivityImpl) then) =
      __$$UserActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activityType, DateTime timestamp, Map<String, dynamic> data});
}

/// @nodoc
class __$$UserActivityImplCopyWithImpl<$Res>
    extends _$UserActivityCopyWithImpl<$Res, _$UserActivityImpl>
    implements _$$UserActivityImplCopyWith<$Res> {
  __$$UserActivityImplCopyWithImpl(
      _$UserActivityImpl _value, $Res Function(_$UserActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? timestamp = null,
    Object? data = null,
  }) {
    return _then(_$UserActivityImpl(
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserActivityImpl implements _UserActivity {
  const _$UserActivityImpl(
      {required this.activityType,
      required this.timestamp,
      required final Map<String, dynamic> data})
      : _data = data;

  factory _$UserActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserActivityImplFromJson(json);

  @override
  final String activityType;
  @override
  final DateTime timestamp;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'UserActivity(activityType: $activityType, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserActivityImpl &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, activityType, timestamp,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserActivityImplCopyWith<_$UserActivityImpl> get copyWith =>
      __$$UserActivityImplCopyWithImpl<_$UserActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserActivityImplToJson(
      this,
    );
  }
}

abstract class _UserActivity implements UserActivity {
  const factory _UserActivity(
      {required final String activityType,
      required final DateTime timestamp,
      required final Map<String, dynamic> data}) = _$UserActivityImpl;

  factory _UserActivity.fromJson(Map<String, dynamic> json) =
      _$UserActivityImpl.fromJson;

  @override
  String get activityType;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get data;

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserActivityImplCopyWith<_$UserActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalFactors _$ExternalFactorsFromJson(Map<String, dynamic> json) {
  return _ExternalFactors.fromJson(json);
}

/// @nodoc
mixin _$ExternalFactors {
  String? get weather => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get timeOfDay => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalFactors =>
      throw _privateConstructorUsedError;

  /// Serializes this ExternalFactors to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalFactors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalFactorsCopyWith<ExternalFactors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalFactorsCopyWith<$Res> {
  factory $ExternalFactorsCopyWith(
          ExternalFactors value, $Res Function(ExternalFactors) then) =
      _$ExternalFactorsCopyWithImpl<$Res, ExternalFactors>;
  @useResult
  $Res call(
      {String? weather,
      String? location,
      String? timeOfDay,
      Map<String, dynamic> additionalFactors});
}

/// @nodoc
class _$ExternalFactorsCopyWithImpl<$Res, $Val extends ExternalFactors>
    implements $ExternalFactorsCopyWith<$Res> {
  _$ExternalFactorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalFactors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = freezed,
    Object? location = freezed,
    Object? timeOfDay = freezed,
    Object? additionalFactors = null,
  }) {
    return _then(_value.copyWith(
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      timeOfDay: freezed == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalFactors: null == additionalFactors
          ? _value.additionalFactors
          : additionalFactors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalFactorsImplCopyWith<$Res>
    implements $ExternalFactorsCopyWith<$Res> {
  factory _$$ExternalFactorsImplCopyWith(_$ExternalFactorsImpl value,
          $Res Function(_$ExternalFactorsImpl) then) =
      __$$ExternalFactorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? weather,
      String? location,
      String? timeOfDay,
      Map<String, dynamic> additionalFactors});
}

/// @nodoc
class __$$ExternalFactorsImplCopyWithImpl<$Res>
    extends _$ExternalFactorsCopyWithImpl<$Res, _$ExternalFactorsImpl>
    implements _$$ExternalFactorsImplCopyWith<$Res> {
  __$$ExternalFactorsImplCopyWithImpl(
      _$ExternalFactorsImpl _value, $Res Function(_$ExternalFactorsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalFactors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = freezed,
    Object? location = freezed,
    Object? timeOfDay = freezed,
    Object? additionalFactors = null,
  }) {
    return _then(_$ExternalFactorsImpl(
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      timeOfDay: freezed == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalFactors: null == additionalFactors
          ? _value._additionalFactors
          : additionalFactors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalFactorsImpl implements _ExternalFactors {
  const _$ExternalFactorsImpl(
      {this.weather,
      this.location,
      this.timeOfDay,
      final Map<String, dynamic> additionalFactors = const {}})
      : _additionalFactors = additionalFactors;

  factory _$ExternalFactorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalFactorsImplFromJson(json);

  @override
  final String? weather;
  @override
  final String? location;
  @override
  final String? timeOfDay;
  final Map<String, dynamic> _additionalFactors;
  @override
  @JsonKey()
  Map<String, dynamic> get additionalFactors {
    if (_additionalFactors is EqualUnmodifiableMapView)
      return _additionalFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalFactors);
  }

  @override
  String toString() {
    return 'ExternalFactors(weather: $weather, location: $location, timeOfDay: $timeOfDay, additionalFactors: $additionalFactors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalFactorsImpl &&
            (identical(other.weather, weather) || other.weather == weather) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            const DeepCollectionEquality()
                .equals(other._additionalFactors, _additionalFactors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weather, location, timeOfDay,
      const DeepCollectionEquality().hash(_additionalFactors));

  /// Create a copy of ExternalFactors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalFactorsImplCopyWith<_$ExternalFactorsImpl> get copyWith =>
      __$$ExternalFactorsImplCopyWithImpl<_$ExternalFactorsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalFactorsImplToJson(
      this,
    );
  }
}

abstract class _ExternalFactors implements ExternalFactors {
  const factory _ExternalFactors(
      {final String? weather,
      final String? location,
      final String? timeOfDay,
      final Map<String, dynamic> additionalFactors}) = _$ExternalFactorsImpl;

  factory _ExternalFactors.fromJson(Map<String, dynamic> json) =
      _$ExternalFactorsImpl.fromJson;

  @override
  String? get weather;
  @override
  String? get location;
  @override
  String? get timeOfDay;
  @override
  Map<String, dynamic> get additionalFactors;

  /// Create a copy of ExternalFactors
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalFactorsImplCopyWith<_$ExternalFactorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserLearningProfile _$UserLearningProfileFromJson(Map<String, dynamic> json) {
  return _UserLearningProfile.fromJson(json);
}

/// @nodoc
mixin _$UserLearningProfile {
  Map<String, double> get interventionEffectiveness =>
      throw _privateConstructorUsedError;
  Map<String, int> get preferredInterventions =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get personalizedData =>
      throw _privateConstructorUsedError;

  /// Serializes this UserLearningProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserLearningProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLearningProfileCopyWith<UserLearningProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLearningProfileCopyWith<$Res> {
  factory $UserLearningProfileCopyWith(
          UserLearningProfile value, $Res Function(UserLearningProfile) then) =
      _$UserLearningProfileCopyWithImpl<$Res, UserLearningProfile>;
  @useResult
  $Res call(
      {Map<String, double> interventionEffectiveness,
      Map<String, int> preferredInterventions,
      Map<String, dynamic> personalizedData});
}

/// @nodoc
class _$UserLearningProfileCopyWithImpl<$Res, $Val extends UserLearningProfile>
    implements $UserLearningProfileCopyWith<$Res> {
  _$UserLearningProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLearningProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interventionEffectiveness = null,
    Object? preferredInterventions = null,
    Object? personalizedData = null,
  }) {
    return _then(_value.copyWith(
      interventionEffectiveness: null == interventionEffectiveness
          ? _value.interventionEffectiveness
          : interventionEffectiveness // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      preferredInterventions: null == preferredInterventions
          ? _value.preferredInterventions
          : preferredInterventions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      personalizedData: null == personalizedData
          ? _value.personalizedData
          : personalizedData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserLearningProfileImplCopyWith<$Res>
    implements $UserLearningProfileCopyWith<$Res> {
  factory _$$UserLearningProfileImplCopyWith(_$UserLearningProfileImpl value,
          $Res Function(_$UserLearningProfileImpl) then) =
      __$$UserLearningProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, double> interventionEffectiveness,
      Map<String, int> preferredInterventions,
      Map<String, dynamic> personalizedData});
}

/// @nodoc
class __$$UserLearningProfileImplCopyWithImpl<$Res>
    extends _$UserLearningProfileCopyWithImpl<$Res, _$UserLearningProfileImpl>
    implements _$$UserLearningProfileImplCopyWith<$Res> {
  __$$UserLearningProfileImplCopyWithImpl(_$UserLearningProfileImpl _value,
      $Res Function(_$UserLearningProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserLearningProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interventionEffectiveness = null,
    Object? preferredInterventions = null,
    Object? personalizedData = null,
  }) {
    return _then(_$UserLearningProfileImpl(
      interventionEffectiveness: null == interventionEffectiveness
          ? _value._interventionEffectiveness
          : interventionEffectiveness // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      preferredInterventions: null == preferredInterventions
          ? _value._preferredInterventions
          : preferredInterventions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      personalizedData: null == personalizedData
          ? _value._personalizedData
          : personalizedData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLearningProfileImpl implements _UserLearningProfile {
  const _$UserLearningProfileImpl(
      {final Map<String, double> interventionEffectiveness = const {},
      final Map<String, int> preferredInterventions = const {},
      final Map<String, dynamic> personalizedData = const {}})
      : _interventionEffectiveness = interventionEffectiveness,
        _preferredInterventions = preferredInterventions,
        _personalizedData = personalizedData;

  factory _$UserLearningProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLearningProfileImplFromJson(json);

  final Map<String, double> _interventionEffectiveness;
  @override
  @JsonKey()
  Map<String, double> get interventionEffectiveness {
    if (_interventionEffectiveness is EqualUnmodifiableMapView)
      return _interventionEffectiveness;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_interventionEffectiveness);
  }

  final Map<String, int> _preferredInterventions;
  @override
  @JsonKey()
  Map<String, int> get preferredInterventions {
    if (_preferredInterventions is EqualUnmodifiableMapView)
      return _preferredInterventions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferredInterventions);
  }

  final Map<String, dynamic> _personalizedData;
  @override
  @JsonKey()
  Map<String, dynamic> get personalizedData {
    if (_personalizedData is EqualUnmodifiableMapView) return _personalizedData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_personalizedData);
  }

  @override
  String toString() {
    return 'UserLearningProfile(interventionEffectiveness: $interventionEffectiveness, preferredInterventions: $preferredInterventions, personalizedData: $personalizedData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLearningProfileImpl &&
            const DeepCollectionEquality().equals(
                other._interventionEffectiveness, _interventionEffectiveness) &&
            const DeepCollectionEquality().equals(
                other._preferredInterventions, _preferredInterventions) &&
            const DeepCollectionEquality()
                .equals(other._personalizedData, _personalizedData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_interventionEffectiveness),
      const DeepCollectionEquality().hash(_preferredInterventions),
      const DeepCollectionEquality().hash(_personalizedData));

  /// Create a copy of UserLearningProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLearningProfileImplCopyWith<_$UserLearningProfileImpl> get copyWith =>
      __$$UserLearningProfileImplCopyWithImpl<_$UserLearningProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLearningProfileImplToJson(
      this,
    );
  }
}

abstract class _UserLearningProfile implements UserLearningProfile {
  const factory _UserLearningProfile(
      {final Map<String, double> interventionEffectiveness,
      final Map<String, int> preferredInterventions,
      final Map<String, dynamic> personalizedData}) = _$UserLearningProfileImpl;

  factory _UserLearningProfile.fromJson(Map<String, dynamic> json) =
      _$UserLearningProfileImpl.fromJson;

  @override
  Map<String, double> get interventionEffectiveness;
  @override
  Map<String, int> get preferredInterventions;
  @override
  Map<String, dynamic> get personalizedData;

  /// Create a copy of UserLearningProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLearningProfileImplCopyWith<_$UserLearningProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
