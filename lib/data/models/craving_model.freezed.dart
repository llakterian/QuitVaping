// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'craving_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CravingModel _$CravingModelFromJson(Map<String, dynamic> json) {
  return _CravingModel.fromJson(json);
}

/// @nodoc
mixin _$CravingModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get intensity => throw _privateConstructorUsedError; // 1-10 scale
  String get triggerCategory =>
      throw _privateConstructorUsedError; // emotional, social, environmental, physical
  String? get specificTrigger => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get activity => throw _privateConstructorUsedError;
  String? get emotion => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError; // in minutes
  String? get copingStrategy => throw _privateConstructorUsedError;
  bool get resolved => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get aiInsights => throw _privateConstructorUsedError;

  /// Serializes this CravingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CravingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CravingModelCopyWith<CravingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CravingModelCopyWith<$Res> {
  factory $CravingModelCopyWith(
          CravingModel value, $Res Function(CravingModel) then) =
      _$CravingModelCopyWithImpl<$Res, CravingModel>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      int intensity,
      String triggerCategory,
      String? specificTrigger,
      String? location,
      String? activity,
      String? emotion,
      int? duration,
      String? copingStrategy,
      bool resolved,
      String? notes,
      Map<String, dynamic>? aiInsights});
}

/// @nodoc
class _$CravingModelCopyWithImpl<$Res, $Val extends CravingModel>
    implements $CravingModelCopyWith<$Res> {
  _$CravingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CravingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? intensity = null,
    Object? triggerCategory = null,
    Object? specificTrigger = freezed,
    Object? location = freezed,
    Object? activity = freezed,
    Object? emotion = freezed,
    Object? duration = freezed,
    Object? copingStrategy = freezed,
    Object? resolved = null,
    Object? notes = freezed,
    Object? aiInsights = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      triggerCategory: null == triggerCategory
          ? _value.triggerCategory
          : triggerCategory // ignore: cast_nullable_to_non_nullable
              as String,
      specificTrigger: freezed == specificTrigger
          ? _value.specificTrigger
          : specificTrigger // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      activity: freezed == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as String?,
      emotion: freezed == emotion
          ? _value.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      copingStrategy: freezed == copingStrategy
          ? _value.copingStrategy
          : copingStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
      resolved: null == resolved
          ? _value.resolved
          : resolved // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      aiInsights: freezed == aiInsights
          ? _value.aiInsights
          : aiInsights // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CravingModelImplCopyWith<$Res>
    implements $CravingModelCopyWith<$Res> {
  factory _$$CravingModelImplCopyWith(
          _$CravingModelImpl value, $Res Function(_$CravingModelImpl) then) =
      __$$CravingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      int intensity,
      String triggerCategory,
      String? specificTrigger,
      String? location,
      String? activity,
      String? emotion,
      int? duration,
      String? copingStrategy,
      bool resolved,
      String? notes,
      Map<String, dynamic>? aiInsights});
}

/// @nodoc
class __$$CravingModelImplCopyWithImpl<$Res>
    extends _$CravingModelCopyWithImpl<$Res, _$CravingModelImpl>
    implements _$$CravingModelImplCopyWith<$Res> {
  __$$CravingModelImplCopyWithImpl(
      _$CravingModelImpl _value, $Res Function(_$CravingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CravingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? intensity = null,
    Object? triggerCategory = null,
    Object? specificTrigger = freezed,
    Object? location = freezed,
    Object? activity = freezed,
    Object? emotion = freezed,
    Object? duration = freezed,
    Object? copingStrategy = freezed,
    Object? resolved = null,
    Object? notes = freezed,
    Object? aiInsights = freezed,
  }) {
    return _then(_$CravingModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      triggerCategory: null == triggerCategory
          ? _value.triggerCategory
          : triggerCategory // ignore: cast_nullable_to_non_nullable
              as String,
      specificTrigger: freezed == specificTrigger
          ? _value.specificTrigger
          : specificTrigger // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      activity: freezed == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as String?,
      emotion: freezed == emotion
          ? _value.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      copingStrategy: freezed == copingStrategy
          ? _value.copingStrategy
          : copingStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
      resolved: null == resolved
          ? _value.resolved
          : resolved // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      aiInsights: freezed == aiInsights
          ? _value._aiInsights
          : aiInsights // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CravingModelImpl extends _CravingModel {
  const _$CravingModelImpl(
      {required this.id,
      required this.timestamp,
      required this.intensity,
      required this.triggerCategory,
      this.specificTrigger,
      this.location,
      this.activity,
      this.emotion,
      this.duration,
      this.copingStrategy,
      required this.resolved,
      this.notes,
      final Map<String, dynamic>? aiInsights})
      : _aiInsights = aiInsights,
        super._();

  factory _$CravingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CravingModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final int intensity;
// 1-10 scale
  @override
  final String triggerCategory;
// emotional, social, environmental, physical
  @override
  final String? specificTrigger;
  @override
  final String? location;
  @override
  final String? activity;
  @override
  final String? emotion;
  @override
  final int? duration;
// in minutes
  @override
  final String? copingStrategy;
  @override
  final bool resolved;
  @override
  final String? notes;
  final Map<String, dynamic>? _aiInsights;
  @override
  Map<String, dynamic>? get aiInsights {
    final value = _aiInsights;
    if (value == null) return null;
    if (_aiInsights is EqualUnmodifiableMapView) return _aiInsights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CravingModel(id: $id, timestamp: $timestamp, intensity: $intensity, triggerCategory: $triggerCategory, specificTrigger: $specificTrigger, location: $location, activity: $activity, emotion: $emotion, duration: $duration, copingStrategy: $copingStrategy, resolved: $resolved, notes: $notes, aiInsights: $aiInsights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CravingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.triggerCategory, triggerCategory) ||
                other.triggerCategory == triggerCategory) &&
            (identical(other.specificTrigger, specificTrigger) ||
                other.specificTrigger == specificTrigger) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.emotion, emotion) || other.emotion == emotion) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.copingStrategy, copingStrategy) ||
                other.copingStrategy == copingStrategy) &&
            (identical(other.resolved, resolved) ||
                other.resolved == resolved) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._aiInsights, _aiInsights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      intensity,
      triggerCategory,
      specificTrigger,
      location,
      activity,
      emotion,
      duration,
      copingStrategy,
      resolved,
      notes,
      const DeepCollectionEquality().hash(_aiInsights));

  /// Create a copy of CravingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CravingModelImplCopyWith<_$CravingModelImpl> get copyWith =>
      __$$CravingModelImplCopyWithImpl<_$CravingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CravingModelImplToJson(
      this,
    );
  }
}

abstract class _CravingModel extends CravingModel {
  const factory _CravingModel(
      {required final String id,
      required final DateTime timestamp,
      required final int intensity,
      required final String triggerCategory,
      final String? specificTrigger,
      final String? location,
      final String? activity,
      final String? emotion,
      final int? duration,
      final String? copingStrategy,
      required final bool resolved,
      final String? notes,
      final Map<String, dynamic>? aiInsights}) = _$CravingModelImpl;
  const _CravingModel._() : super._();

  factory _CravingModel.fromJson(Map<String, dynamic> json) =
      _$CravingModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  int get intensity; // 1-10 scale
  @override
  String get triggerCategory; // emotional, social, environmental, physical
  @override
  String? get specificTrigger;
  @override
  String? get location;
  @override
  String? get activity;
  @override
  String? get emotion;
  @override
  int? get duration; // in minutes
  @override
  String? get copingStrategy;
  @override
  bool get resolved;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get aiInsights;

  /// Create a copy of CravingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CravingModelImplCopyWith<_$CravingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CravingInsightModel _$CravingInsightModelFromJson(Map<String, dynamic> json) {
  return _CravingInsightModel.fromJson(json);
}

/// @nodoc
mixin _$CravingInsightModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String get insightType =>
      throw _privateConstructorUsedError; // pattern, trigger, time, location, etc.
  String get description => throw _privateConstructorUsedError;
  double get confidenceScore =>
      throw _privateConstructorUsedError; // 0.0 to 1.0
  Map<String, dynamic> get supportingData => throw _privateConstructorUsedError;
  List<String>? get recommendedStrategies => throw _privateConstructorUsedError;

  /// Serializes this CravingInsightModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CravingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CravingInsightModelCopyWith<CravingInsightModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CravingInsightModelCopyWith<$Res> {
  factory $CravingInsightModelCopyWith(
          CravingInsightModel value, $Res Function(CravingInsightModel) then) =
      _$CravingInsightModelCopyWithImpl<$Res, CravingInsightModel>;
  @useResult
  $Res call(
      {String id,
      DateTime generatedAt,
      String insightType,
      String description,
      double confidenceScore,
      Map<String, dynamic> supportingData,
      List<String>? recommendedStrategies});
}

/// @nodoc
class _$CravingInsightModelCopyWithImpl<$Res, $Val extends CravingInsightModel>
    implements $CravingInsightModelCopyWith<$Res> {
  _$CravingInsightModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CravingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? generatedAt = null,
    Object? insightType = null,
    Object? description = null,
    Object? confidenceScore = null,
    Object? supportingData = null,
    Object? recommendedStrategies = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insightType: null == insightType
          ? _value.insightType
          : insightType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      supportingData: null == supportingData
          ? _value.supportingData
          : supportingData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      recommendedStrategies: freezed == recommendedStrategies
          ? _value.recommendedStrategies
          : recommendedStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CravingInsightModelImplCopyWith<$Res>
    implements $CravingInsightModelCopyWith<$Res> {
  factory _$$CravingInsightModelImplCopyWith(_$CravingInsightModelImpl value,
          $Res Function(_$CravingInsightModelImpl) then) =
      __$$CravingInsightModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime generatedAt,
      String insightType,
      String description,
      double confidenceScore,
      Map<String, dynamic> supportingData,
      List<String>? recommendedStrategies});
}

/// @nodoc
class __$$CravingInsightModelImplCopyWithImpl<$Res>
    extends _$CravingInsightModelCopyWithImpl<$Res, _$CravingInsightModelImpl>
    implements _$$CravingInsightModelImplCopyWith<$Res> {
  __$$CravingInsightModelImplCopyWithImpl(_$CravingInsightModelImpl _value,
      $Res Function(_$CravingInsightModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CravingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? generatedAt = null,
    Object? insightType = null,
    Object? description = null,
    Object? confidenceScore = null,
    Object? supportingData = null,
    Object? recommendedStrategies = freezed,
  }) {
    return _then(_$CravingInsightModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insightType: null == insightType
          ? _value.insightType
          : insightType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      supportingData: null == supportingData
          ? _value._supportingData
          : supportingData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      recommendedStrategies: freezed == recommendedStrategies
          ? _value._recommendedStrategies
          : recommendedStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CravingInsightModelImpl implements _CravingInsightModel {
  const _$CravingInsightModelImpl(
      {required this.id,
      required this.generatedAt,
      required this.insightType,
      required this.description,
      required this.confidenceScore,
      required final Map<String, dynamic> supportingData,
      final List<String>? recommendedStrategies})
      : _supportingData = supportingData,
        _recommendedStrategies = recommendedStrategies;

  factory _$CravingInsightModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CravingInsightModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime generatedAt;
  @override
  final String insightType;
// pattern, trigger, time, location, etc.
  @override
  final String description;
  @override
  final double confidenceScore;
// 0.0 to 1.0
  final Map<String, dynamic> _supportingData;
// 0.0 to 1.0
  @override
  Map<String, dynamic> get supportingData {
    if (_supportingData is EqualUnmodifiableMapView) return _supportingData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_supportingData);
  }

  final List<String>? _recommendedStrategies;
  @override
  List<String>? get recommendedStrategies {
    final value = _recommendedStrategies;
    if (value == null) return null;
    if (_recommendedStrategies is EqualUnmodifiableListView)
      return _recommendedStrategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CravingInsightModel(id: $id, generatedAt: $generatedAt, insightType: $insightType, description: $description, confidenceScore: $confidenceScore, supportingData: $supportingData, recommendedStrategies: $recommendedStrategies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CravingInsightModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.insightType, insightType) ||
                other.insightType == insightType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            const DeepCollectionEquality()
                .equals(other._supportingData, _supportingData) &&
            const DeepCollectionEquality()
                .equals(other._recommendedStrategies, _recommendedStrategies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      generatedAt,
      insightType,
      description,
      confidenceScore,
      const DeepCollectionEquality().hash(_supportingData),
      const DeepCollectionEquality().hash(_recommendedStrategies));

  /// Create a copy of CravingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CravingInsightModelImplCopyWith<_$CravingInsightModelImpl> get copyWith =>
      __$$CravingInsightModelImplCopyWithImpl<_$CravingInsightModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CravingInsightModelImplToJson(
      this,
    );
  }
}

abstract class _CravingInsightModel implements CravingInsightModel {
  const factory _CravingInsightModel(
      {required final String id,
      required final DateTime generatedAt,
      required final String insightType,
      required final String description,
      required final double confidenceScore,
      required final Map<String, dynamic> supportingData,
      final List<String>? recommendedStrategies}) = _$CravingInsightModelImpl;

  factory _CravingInsightModel.fromJson(Map<String, dynamic> json) =
      _$CravingInsightModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get generatedAt;
  @override
  String get insightType; // pattern, trigger, time, location, etc.
  @override
  String get description;
  @override
  double get confidenceScore; // 0.0 to 1.0
  @override
  Map<String, dynamic> get supportingData;
  @override
  List<String>? get recommendedStrategies;

  /// Create a copy of CravingInsightModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CravingInsightModelImplCopyWith<_$CravingInsightModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
