// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_feedback_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MCPServiceStatus _$MCPServiceStatusFromJson(Map<String, dynamic> json) {
  return _MCPServiceStatus.fromJson(json);
}

/// @nodoc
mixin _$MCPServiceStatus {
  String get serviceId => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  MCPServiceHealthStatus get status => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  List<MCPServiceFeature> get features => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  int get maxRetries => throw _privateConstructorUsedError;
  MCPServiceDegradation? get degradation => throw _privateConstructorUsedError;

  /// Serializes this MCPServiceStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPServiceStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPServiceStatusCopyWith<MCPServiceStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServiceStatusCopyWith<$Res> {
  factory $MCPServiceStatusCopyWith(
          MCPServiceStatus value, $Res Function(MCPServiceStatus) then) =
      _$MCPServiceStatusCopyWithImpl<$Res, MCPServiceStatus>;
  @useResult
  $Res call(
      {String serviceId,
      String serviceName,
      MCPServiceHealthStatus status,
      DateTime lastUpdated,
      List<MCPServiceFeature> features,
      String? error,
      int retryCount,
      int maxRetries,
      MCPServiceDegradation? degradation});

  $MCPServiceDegradationCopyWith<$Res>? get degradation;
}

/// @nodoc
class _$MCPServiceStatusCopyWithImpl<$Res, $Val extends MCPServiceStatus>
    implements $MCPServiceStatusCopyWith<$Res> {
  _$MCPServiceStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPServiceStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? serviceName = null,
    Object? status = null,
    Object? lastUpdated = null,
    Object? features = null,
    Object? error = freezed,
    Object? retryCount = null,
    Object? maxRetries = null,
    Object? degradation = freezed,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MCPServiceHealthStatus,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<MCPServiceFeature>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      degradation: freezed == degradation
          ? _value.degradation
          : degradation // ignore: cast_nullable_to_non_nullable
              as MCPServiceDegradation?,
    ) as $Val);
  }

  /// Create a copy of MCPServiceStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MCPServiceDegradationCopyWith<$Res>? get degradation {
    if (_value.degradation == null) {
      return null;
    }

    return $MCPServiceDegradationCopyWith<$Res>(_value.degradation!, (value) {
      return _then(_value.copyWith(degradation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MCPServiceStatusImplCopyWith<$Res>
    implements $MCPServiceStatusCopyWith<$Res> {
  factory _$$MCPServiceStatusImplCopyWith(_$MCPServiceStatusImpl value,
          $Res Function(_$MCPServiceStatusImpl) then) =
      __$$MCPServiceStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serviceId,
      String serviceName,
      MCPServiceHealthStatus status,
      DateTime lastUpdated,
      List<MCPServiceFeature> features,
      String? error,
      int retryCount,
      int maxRetries,
      MCPServiceDegradation? degradation});

  @override
  $MCPServiceDegradationCopyWith<$Res>? get degradation;
}

/// @nodoc
class __$$MCPServiceStatusImplCopyWithImpl<$Res>
    extends _$MCPServiceStatusCopyWithImpl<$Res, _$MCPServiceStatusImpl>
    implements _$$MCPServiceStatusImplCopyWith<$Res> {
  __$$MCPServiceStatusImplCopyWithImpl(_$MCPServiceStatusImpl _value,
      $Res Function(_$MCPServiceStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPServiceStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? serviceName = null,
    Object? status = null,
    Object? lastUpdated = null,
    Object? features = null,
    Object? error = freezed,
    Object? retryCount = null,
    Object? maxRetries = null,
    Object? degradation = freezed,
  }) {
    return _then(_$MCPServiceStatusImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MCPServiceHealthStatus,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<MCPServiceFeature>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      degradation: freezed == degradation
          ? _value.degradation
          : degradation // ignore: cast_nullable_to_non_nullable
              as MCPServiceDegradation?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServiceStatusImpl implements _MCPServiceStatus {
  const _$MCPServiceStatusImpl(
      {required this.serviceId,
      required this.serviceName,
      required this.status,
      required this.lastUpdated,
      required final List<MCPServiceFeature> features,
      this.error,
      this.retryCount = 0,
      this.maxRetries = 0,
      this.degradation})
      : _features = features;

  factory _$MCPServiceStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServiceStatusImplFromJson(json);

  @override
  final String serviceId;
  @override
  final String serviceName;
  @override
  final MCPServiceHealthStatus status;
  @override
  final DateTime lastUpdated;
  final List<MCPServiceFeature> _features;
  @override
  List<MCPServiceFeature> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  final String? error;
  @override
  @JsonKey()
  final int retryCount;
  @override
  @JsonKey()
  final int maxRetries;
  @override
  final MCPServiceDegradation? degradation;

  @override
  String toString() {
    return 'MCPServiceStatus(serviceId: $serviceId, serviceName: $serviceName, status: $status, lastUpdated: $lastUpdated, features: $features, error: $error, retryCount: $retryCount, maxRetries: $maxRetries, degradation: $degradation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServiceStatusImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries) &&
            (identical(other.degradation, degradation) ||
                other.degradation == degradation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      serviceName,
      status,
      lastUpdated,
      const DeepCollectionEquality().hash(_features),
      error,
      retryCount,
      maxRetries,
      degradation);

  /// Create a copy of MCPServiceStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServiceStatusImplCopyWith<_$MCPServiceStatusImpl> get copyWith =>
      __$$MCPServiceStatusImplCopyWithImpl<_$MCPServiceStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServiceStatusImplToJson(
      this,
    );
  }
}

abstract class _MCPServiceStatus implements MCPServiceStatus {
  const factory _MCPServiceStatus(
      {required final String serviceId,
      required final String serviceName,
      required final MCPServiceHealthStatus status,
      required final DateTime lastUpdated,
      required final List<MCPServiceFeature> features,
      final String? error,
      final int retryCount,
      final int maxRetries,
      final MCPServiceDegradation? degradation}) = _$MCPServiceStatusImpl;

  factory _MCPServiceStatus.fromJson(Map<String, dynamic> json) =
      _$MCPServiceStatusImpl.fromJson;

  @override
  String get serviceId;
  @override
  String get serviceName;
  @override
  MCPServiceHealthStatus get status;
  @override
  DateTime get lastUpdated;
  @override
  List<MCPServiceFeature> get features;
  @override
  String? get error;
  @override
  int get retryCount;
  @override
  int get maxRetries;
  @override
  MCPServiceDegradation? get degradation;

  /// Create a copy of MCPServiceStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPServiceStatusImplCopyWith<_$MCPServiceStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPServiceFeature _$MCPServiceFeatureFromJson(Map<String, dynamic> json) {
  return _MCPServiceFeature.fromJson(json);
}

/// @nodoc
mixin _$MCPServiceFeature {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isEssential => throw _privateConstructorUsedError;
  MCPFeatureStatus get status => throw _privateConstructorUsedError;
  String? get statusMessage => throw _privateConstructorUsedError;

  /// Serializes this MCPServiceFeature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPServiceFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPServiceFeatureCopyWith<MCPServiceFeature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServiceFeatureCopyWith<$Res> {
  factory $MCPServiceFeatureCopyWith(
          MCPServiceFeature value, $Res Function(MCPServiceFeature) then) =
      _$MCPServiceFeatureCopyWithImpl<$Res, MCPServiceFeature>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      bool isEssential,
      MCPFeatureStatus status,
      String? statusMessage});
}

/// @nodoc
class _$MCPServiceFeatureCopyWithImpl<$Res, $Val extends MCPServiceFeature>
    implements $MCPServiceFeatureCopyWith<$Res> {
  _$MCPServiceFeatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPServiceFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isEssential = null,
    Object? status = null,
    Object? statusMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isEssential: null == isEssential
          ? _value.isEssential
          : isEssential // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MCPFeatureStatus,
      statusMessage: freezed == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPServiceFeatureImplCopyWith<$Res>
    implements $MCPServiceFeatureCopyWith<$Res> {
  factory _$$MCPServiceFeatureImplCopyWith(_$MCPServiceFeatureImpl value,
          $Res Function(_$MCPServiceFeatureImpl) then) =
      __$$MCPServiceFeatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      bool isEssential,
      MCPFeatureStatus status,
      String? statusMessage});
}

/// @nodoc
class __$$MCPServiceFeatureImplCopyWithImpl<$Res>
    extends _$MCPServiceFeatureCopyWithImpl<$Res, _$MCPServiceFeatureImpl>
    implements _$$MCPServiceFeatureImplCopyWith<$Res> {
  __$$MCPServiceFeatureImplCopyWithImpl(_$MCPServiceFeatureImpl _value,
      $Res Function(_$MCPServiceFeatureImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPServiceFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isEssential = null,
    Object? status = null,
    Object? statusMessage = freezed,
  }) {
    return _then(_$MCPServiceFeatureImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isEssential: null == isEssential
          ? _value.isEssential
          : isEssential // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MCPFeatureStatus,
      statusMessage: freezed == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServiceFeatureImpl implements _MCPServiceFeature {
  const _$MCPServiceFeatureImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.isEssential,
      required this.status,
      this.statusMessage});

  factory _$MCPServiceFeatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServiceFeatureImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final bool isEssential;
  @override
  final MCPFeatureStatus status;
  @override
  final String? statusMessage;

  @override
  String toString() {
    return 'MCPServiceFeature(id: $id, name: $name, description: $description, isEssential: $isEssential, status: $status, statusMessage: $statusMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServiceFeatureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isEssential, isEssential) ||
                other.isEssential == isEssential) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, isEssential, status, statusMessage);

  /// Create a copy of MCPServiceFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServiceFeatureImplCopyWith<_$MCPServiceFeatureImpl> get copyWith =>
      __$$MCPServiceFeatureImplCopyWithImpl<_$MCPServiceFeatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServiceFeatureImplToJson(
      this,
    );
  }
}

abstract class _MCPServiceFeature implements MCPServiceFeature {
  const factory _MCPServiceFeature(
      {required final String id,
      required final String name,
      required final String description,
      required final bool isEssential,
      required final MCPFeatureStatus status,
      final String? statusMessage}) = _$MCPServiceFeatureImpl;

  factory _MCPServiceFeature.fromJson(Map<String, dynamic> json) =
      _$MCPServiceFeatureImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  bool get isEssential;
  @override
  MCPFeatureStatus get status;
  @override
  String? get statusMessage;

  /// Create a copy of MCPServiceFeature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPServiceFeatureImplCopyWith<_$MCPServiceFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPUserFeedback _$MCPUserFeedbackFromJson(Map<String, dynamic> json) {
  return _MCPUserFeedback.fromJson(json);
}

/// @nodoc
mixin _$MCPUserFeedback {
  String get id => throw _privateConstructorUsedError;
  MCPUserFeedbackType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  MCPFeedbackPriority get priority => throw _privateConstructorUsedError;
  bool get isActionable => throw _privateConstructorUsedError;
  MCPFeedbackDetails? get details => throw _privateConstructorUsedError;

  /// Serializes this MCPUserFeedback to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPUserFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPUserFeedbackCopyWith<MCPUserFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPUserFeedbackCopyWith<$Res> {
  factory $MCPUserFeedbackCopyWith(
          MCPUserFeedback value, $Res Function(MCPUserFeedback) then) =
      _$MCPUserFeedbackCopyWithImpl<$Res, MCPUserFeedback>;
  @useResult
  $Res call(
      {String id,
      MCPUserFeedbackType type,
      String title,
      String message,
      String serviceName,
      DateTime timestamp,
      MCPFeedbackPriority priority,
      bool isActionable,
      MCPFeedbackDetails? details});

  $MCPFeedbackDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class _$MCPUserFeedbackCopyWithImpl<$Res, $Val extends MCPUserFeedback>
    implements $MCPUserFeedbackCopyWith<$Res> {
  _$MCPUserFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPUserFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? serviceName = null,
    Object? timestamp = null,
    Object? priority = null,
    Object? isActionable = null,
    Object? details = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MCPUserFeedbackType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as MCPFeedbackPriority,
      isActionable: null == isActionable
          ? _value.isActionable
          : isActionable // ignore: cast_nullable_to_non_nullable
              as bool,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as MCPFeedbackDetails?,
    ) as $Val);
  }

  /// Create a copy of MCPUserFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MCPFeedbackDetailsCopyWith<$Res>? get details {
    if (_value.details == null) {
      return null;
    }

    return $MCPFeedbackDetailsCopyWith<$Res>(_value.details!, (value) {
      return _then(_value.copyWith(details: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MCPUserFeedbackImplCopyWith<$Res>
    implements $MCPUserFeedbackCopyWith<$Res> {
  factory _$$MCPUserFeedbackImplCopyWith(_$MCPUserFeedbackImpl value,
          $Res Function(_$MCPUserFeedbackImpl) then) =
      __$$MCPUserFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      MCPUserFeedbackType type,
      String title,
      String message,
      String serviceName,
      DateTime timestamp,
      MCPFeedbackPriority priority,
      bool isActionable,
      MCPFeedbackDetails? details});

  @override
  $MCPFeedbackDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class __$$MCPUserFeedbackImplCopyWithImpl<$Res>
    extends _$MCPUserFeedbackCopyWithImpl<$Res, _$MCPUserFeedbackImpl>
    implements _$$MCPUserFeedbackImplCopyWith<$Res> {
  __$$MCPUserFeedbackImplCopyWithImpl(
      _$MCPUserFeedbackImpl _value, $Res Function(_$MCPUserFeedbackImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPUserFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? serviceName = null,
    Object? timestamp = null,
    Object? priority = null,
    Object? isActionable = null,
    Object? details = freezed,
  }) {
    return _then(_$MCPUserFeedbackImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MCPUserFeedbackType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as MCPFeedbackPriority,
      isActionable: null == isActionable
          ? _value.isActionable
          : isActionable // ignore: cast_nullable_to_non_nullable
              as bool,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as MCPFeedbackDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPUserFeedbackImpl implements _MCPUserFeedback {
  const _$MCPUserFeedbackImpl(
      {required this.id,
      required this.type,
      required this.title,
      required this.message,
      required this.serviceName,
      required this.timestamp,
      required this.priority,
      required this.isActionable,
      this.details});

  factory _$MCPUserFeedbackImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPUserFeedbackImplFromJson(json);

  @override
  final String id;
  @override
  final MCPUserFeedbackType type;
  @override
  final String title;
  @override
  final String message;
  @override
  final String serviceName;
  @override
  final DateTime timestamp;
  @override
  final MCPFeedbackPriority priority;
  @override
  final bool isActionable;
  @override
  final MCPFeedbackDetails? details;

  @override
  String toString() {
    return 'MCPUserFeedback(id: $id, type: $type, title: $title, message: $message, serviceName: $serviceName, timestamp: $timestamp, priority: $priority, isActionable: $isActionable, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPUserFeedbackImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isActionable, isActionable) ||
                other.isActionable == isActionable) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, title, message,
      serviceName, timestamp, priority, isActionable, details);

  /// Create a copy of MCPUserFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPUserFeedbackImplCopyWith<_$MCPUserFeedbackImpl> get copyWith =>
      __$$MCPUserFeedbackImplCopyWithImpl<_$MCPUserFeedbackImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPUserFeedbackImplToJson(
      this,
    );
  }
}

abstract class _MCPUserFeedback implements MCPUserFeedback {
  const factory _MCPUserFeedback(
      {required final String id,
      required final MCPUserFeedbackType type,
      required final String title,
      required final String message,
      required final String serviceName,
      required final DateTime timestamp,
      required final MCPFeedbackPriority priority,
      required final bool isActionable,
      final MCPFeedbackDetails? details}) = _$MCPUserFeedbackImpl;

  factory _MCPUserFeedback.fromJson(Map<String, dynamic> json) =
      _$MCPUserFeedbackImpl.fromJson;

  @override
  String get id;
  @override
  MCPUserFeedbackType get type;
  @override
  String get title;
  @override
  String get message;
  @override
  String get serviceName;
  @override
  DateTime get timestamp;
  @override
  MCPFeedbackPriority get priority;
  @override
  bool get isActionable;
  @override
  MCPFeedbackDetails? get details;

  /// Create a copy of MCPUserFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPUserFeedbackImplCopyWith<_$MCPUserFeedbackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPFeedbackDetails _$MCPFeedbackDetailsFromJson(Map<String, dynamic> json) {
  return _MCPFeedbackDetails.fromJson(json);
}

/// @nodoc
mixin _$MCPFeedbackDetails {
  List<String>? get affectedFeatures => throw _privateConstructorUsedError;
  List<String>? get availableFeatures => throw _privateConstructorUsedError;
  String? get workaround => throw _privateConstructorUsedError;
  DateTime? get estimatedResolution => throw _privateConstructorUsedError;
  String? get technicalDetails => throw _privateConstructorUsedError;
  String? get retryInfo => throw _privateConstructorUsedError;

  /// Serializes this MCPFeedbackDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPFeedbackDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPFeedbackDetailsCopyWith<MCPFeedbackDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPFeedbackDetailsCopyWith<$Res> {
  factory $MCPFeedbackDetailsCopyWith(
          MCPFeedbackDetails value, $Res Function(MCPFeedbackDetails) then) =
      _$MCPFeedbackDetailsCopyWithImpl<$Res, MCPFeedbackDetails>;
  @useResult
  $Res call(
      {List<String>? affectedFeatures,
      List<String>? availableFeatures,
      String? workaround,
      DateTime? estimatedResolution,
      String? technicalDetails,
      String? retryInfo});
}

/// @nodoc
class _$MCPFeedbackDetailsCopyWithImpl<$Res, $Val extends MCPFeedbackDetails>
    implements $MCPFeedbackDetailsCopyWith<$Res> {
  _$MCPFeedbackDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPFeedbackDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affectedFeatures = freezed,
    Object? availableFeatures = freezed,
    Object? workaround = freezed,
    Object? estimatedResolution = freezed,
    Object? technicalDetails = freezed,
    Object? retryInfo = freezed,
  }) {
    return _then(_value.copyWith(
      affectedFeatures: freezed == affectedFeatures
          ? _value.affectedFeatures
          : affectedFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      availableFeatures: freezed == availableFeatures
          ? _value.availableFeatures
          : availableFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      workaround: freezed == workaround
          ? _value.workaround
          : workaround // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedResolution: freezed == estimatedResolution
          ? _value.estimatedResolution
          : estimatedResolution // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      technicalDetails: freezed == technicalDetails
          ? _value.technicalDetails
          : technicalDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      retryInfo: freezed == retryInfo
          ? _value.retryInfo
          : retryInfo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPFeedbackDetailsImplCopyWith<$Res>
    implements $MCPFeedbackDetailsCopyWith<$Res> {
  factory _$$MCPFeedbackDetailsImplCopyWith(_$MCPFeedbackDetailsImpl value,
          $Res Function(_$MCPFeedbackDetailsImpl) then) =
      __$$MCPFeedbackDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? affectedFeatures,
      List<String>? availableFeatures,
      String? workaround,
      DateTime? estimatedResolution,
      String? technicalDetails,
      String? retryInfo});
}

/// @nodoc
class __$$MCPFeedbackDetailsImplCopyWithImpl<$Res>
    extends _$MCPFeedbackDetailsCopyWithImpl<$Res, _$MCPFeedbackDetailsImpl>
    implements _$$MCPFeedbackDetailsImplCopyWith<$Res> {
  __$$MCPFeedbackDetailsImplCopyWithImpl(_$MCPFeedbackDetailsImpl _value,
      $Res Function(_$MCPFeedbackDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPFeedbackDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? affectedFeatures = freezed,
    Object? availableFeatures = freezed,
    Object? workaround = freezed,
    Object? estimatedResolution = freezed,
    Object? technicalDetails = freezed,
    Object? retryInfo = freezed,
  }) {
    return _then(_$MCPFeedbackDetailsImpl(
      affectedFeatures: freezed == affectedFeatures
          ? _value._affectedFeatures
          : affectedFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      availableFeatures: freezed == availableFeatures
          ? _value._availableFeatures
          : availableFeatures // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      workaround: freezed == workaround
          ? _value.workaround
          : workaround // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedResolution: freezed == estimatedResolution
          ? _value.estimatedResolution
          : estimatedResolution // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      technicalDetails: freezed == technicalDetails
          ? _value.technicalDetails
          : technicalDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      retryInfo: freezed == retryInfo
          ? _value.retryInfo
          : retryInfo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPFeedbackDetailsImpl implements _MCPFeedbackDetails {
  const _$MCPFeedbackDetailsImpl(
      {final List<String>? affectedFeatures,
      final List<String>? availableFeatures,
      this.workaround,
      this.estimatedResolution,
      this.technicalDetails,
      this.retryInfo})
      : _affectedFeatures = affectedFeatures,
        _availableFeatures = availableFeatures;

  factory _$MCPFeedbackDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPFeedbackDetailsImplFromJson(json);

  final List<String>? _affectedFeatures;
  @override
  List<String>? get affectedFeatures {
    final value = _affectedFeatures;
    if (value == null) return null;
    if (_affectedFeatures is EqualUnmodifiableListView)
      return _affectedFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _availableFeatures;
  @override
  List<String>? get availableFeatures {
    final value = _availableFeatures;
    if (value == null) return null;
    if (_availableFeatures is EqualUnmodifiableListView)
      return _availableFeatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? workaround;
  @override
  final DateTime? estimatedResolution;
  @override
  final String? technicalDetails;
  @override
  final String? retryInfo;

  @override
  String toString() {
    return 'MCPFeedbackDetails(affectedFeatures: $affectedFeatures, availableFeatures: $availableFeatures, workaround: $workaround, estimatedResolution: $estimatedResolution, technicalDetails: $technicalDetails, retryInfo: $retryInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPFeedbackDetailsImpl &&
            const DeepCollectionEquality()
                .equals(other._affectedFeatures, _affectedFeatures) &&
            const DeepCollectionEquality()
                .equals(other._availableFeatures, _availableFeatures) &&
            (identical(other.workaround, workaround) ||
                other.workaround == workaround) &&
            (identical(other.estimatedResolution, estimatedResolution) ||
                other.estimatedResolution == estimatedResolution) &&
            (identical(other.technicalDetails, technicalDetails) ||
                other.technicalDetails == technicalDetails) &&
            (identical(other.retryInfo, retryInfo) ||
                other.retryInfo == retryInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_affectedFeatures),
      const DeepCollectionEquality().hash(_availableFeatures),
      workaround,
      estimatedResolution,
      technicalDetails,
      retryInfo);

  /// Create a copy of MCPFeedbackDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPFeedbackDetailsImplCopyWith<_$MCPFeedbackDetailsImpl> get copyWith =>
      __$$MCPFeedbackDetailsImplCopyWithImpl<_$MCPFeedbackDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPFeedbackDetailsImplToJson(
      this,
    );
  }
}

abstract class _MCPFeedbackDetails implements MCPFeedbackDetails {
  const factory _MCPFeedbackDetails(
      {final List<String>? affectedFeatures,
      final List<String>? availableFeatures,
      final String? workaround,
      final DateTime? estimatedResolution,
      final String? technicalDetails,
      final String? retryInfo}) = _$MCPFeedbackDetailsImpl;

  factory _MCPFeedbackDetails.fromJson(Map<String, dynamic> json) =
      _$MCPFeedbackDetailsImpl.fromJson;

  @override
  List<String>? get affectedFeatures;
  @override
  List<String>? get availableFeatures;
  @override
  String? get workaround;
  @override
  DateTime? get estimatedResolution;
  @override
  String? get technicalDetails;
  @override
  String? get retryInfo;

  /// Create a copy of MCPFeedbackDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPFeedbackDetailsImplCopyWith<_$MCPFeedbackDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MCPSystemHealth _$MCPSystemHealthFromJson(Map<String, dynamic> json) {
  return _MCPSystemHealth.fromJson(json);
}

/// @nodoc
mixin _$MCPSystemHealth {
  MCPSystemHealthLevel get level => throw _privateConstructorUsedError;
  int get healthyServices => throw _privateConstructorUsedError;
  int get degradedServices => throw _privateConstructorUsedError;
  int get unhealthyServices => throw _privateConstructorUsedError;
  int get offlineServices => throw _privateConstructorUsedError;
  int get totalServices => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this MCPSystemHealth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPSystemHealth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPSystemHealthCopyWith<MCPSystemHealth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPSystemHealthCopyWith<$Res> {
  factory $MCPSystemHealthCopyWith(
          MCPSystemHealth value, $Res Function(MCPSystemHealth) then) =
      _$MCPSystemHealthCopyWithImpl<$Res, MCPSystemHealth>;
  @useResult
  $Res call(
      {MCPSystemHealthLevel level,
      int healthyServices,
      int degradedServices,
      int unhealthyServices,
      int offlineServices,
      int totalServices,
      DateTime lastUpdated});
}

/// @nodoc
class _$MCPSystemHealthCopyWithImpl<$Res, $Val extends MCPSystemHealth>
    implements $MCPSystemHealthCopyWith<$Res> {
  _$MCPSystemHealthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPSystemHealth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? healthyServices = null,
    Object? degradedServices = null,
    Object? unhealthyServices = null,
    Object? offlineServices = null,
    Object? totalServices = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as MCPSystemHealthLevel,
      healthyServices: null == healthyServices
          ? _value.healthyServices
          : healthyServices // ignore: cast_nullable_to_non_nullable
              as int,
      degradedServices: null == degradedServices
          ? _value.degradedServices
          : degradedServices // ignore: cast_nullable_to_non_nullable
              as int,
      unhealthyServices: null == unhealthyServices
          ? _value.unhealthyServices
          : unhealthyServices // ignore: cast_nullable_to_non_nullable
              as int,
      offlineServices: null == offlineServices
          ? _value.offlineServices
          : offlineServices // ignore: cast_nullable_to_non_nullable
              as int,
      totalServices: null == totalServices
          ? _value.totalServices
          : totalServices // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCPSystemHealthImplCopyWith<$Res>
    implements $MCPSystemHealthCopyWith<$Res> {
  factory _$$MCPSystemHealthImplCopyWith(_$MCPSystemHealthImpl value,
          $Res Function(_$MCPSystemHealthImpl) then) =
      __$$MCPSystemHealthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MCPSystemHealthLevel level,
      int healthyServices,
      int degradedServices,
      int unhealthyServices,
      int offlineServices,
      int totalServices,
      DateTime lastUpdated});
}

/// @nodoc
class __$$MCPSystemHealthImplCopyWithImpl<$Res>
    extends _$MCPSystemHealthCopyWithImpl<$Res, _$MCPSystemHealthImpl>
    implements _$$MCPSystemHealthImplCopyWith<$Res> {
  __$$MCPSystemHealthImplCopyWithImpl(
      _$MCPSystemHealthImpl _value, $Res Function(_$MCPSystemHealthImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCPSystemHealth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? healthyServices = null,
    Object? degradedServices = null,
    Object? unhealthyServices = null,
    Object? offlineServices = null,
    Object? totalServices = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$MCPSystemHealthImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as MCPSystemHealthLevel,
      healthyServices: null == healthyServices
          ? _value.healthyServices
          : healthyServices // ignore: cast_nullable_to_non_nullable
              as int,
      degradedServices: null == degradedServices
          ? _value.degradedServices
          : degradedServices // ignore: cast_nullable_to_non_nullable
              as int,
      unhealthyServices: null == unhealthyServices
          ? _value.unhealthyServices
          : unhealthyServices // ignore: cast_nullable_to_non_nullable
              as int,
      offlineServices: null == offlineServices
          ? _value.offlineServices
          : offlineServices // ignore: cast_nullable_to_non_nullable
              as int,
      totalServices: null == totalServices
          ? _value.totalServices
          : totalServices // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPSystemHealthImpl implements _MCPSystemHealth {
  const _$MCPSystemHealthImpl(
      {required this.level,
      required this.healthyServices,
      required this.degradedServices,
      required this.unhealthyServices,
      required this.offlineServices,
      required this.totalServices,
      required this.lastUpdated});

  factory _$MCPSystemHealthImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPSystemHealthImplFromJson(json);

  @override
  final MCPSystemHealthLevel level;
  @override
  final int healthyServices;
  @override
  final int degradedServices;
  @override
  final int unhealthyServices;
  @override
  final int offlineServices;
  @override
  final int totalServices;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'MCPSystemHealth(level: $level, healthyServices: $healthyServices, degradedServices: $degradedServices, unhealthyServices: $unhealthyServices, offlineServices: $offlineServices, totalServices: $totalServices, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPSystemHealthImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.healthyServices, healthyServices) ||
                other.healthyServices == healthyServices) &&
            (identical(other.degradedServices, degradedServices) ||
                other.degradedServices == degradedServices) &&
            (identical(other.unhealthyServices, unhealthyServices) ||
                other.unhealthyServices == unhealthyServices) &&
            (identical(other.offlineServices, offlineServices) ||
                other.offlineServices == offlineServices) &&
            (identical(other.totalServices, totalServices) ||
                other.totalServices == totalServices) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      level,
      healthyServices,
      degradedServices,
      unhealthyServices,
      offlineServices,
      totalServices,
      lastUpdated);

  /// Create a copy of MCPSystemHealth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPSystemHealthImplCopyWith<_$MCPSystemHealthImpl> get copyWith =>
      __$$MCPSystemHealthImplCopyWithImpl<_$MCPSystemHealthImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPSystemHealthImplToJson(
      this,
    );
  }
}

abstract class _MCPSystemHealth implements MCPSystemHealth {
  const factory _MCPSystemHealth(
      {required final MCPSystemHealthLevel level,
      required final int healthyServices,
      required final int degradedServices,
      required final int unhealthyServices,
      required final int offlineServices,
      required final int totalServices,
      required final DateTime lastUpdated}) = _$MCPSystemHealthImpl;

  factory _MCPSystemHealth.fromJson(Map<String, dynamic> json) =
      _$MCPSystemHealthImpl.fromJson;

  @override
  MCPSystemHealthLevel get level;
  @override
  int get healthyServices;
  @override
  int get degradedServices;
  @override
  int get unhealthyServices;
  @override
  int get offlineServices;
  @override
  int get totalServices;
  @override
  DateTime get lastUpdated;

  /// Create a copy of MCPSystemHealth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPSystemHealthImplCopyWith<_$MCPSystemHealthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
