// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnalyticsDataPoint _$AnalyticsDataPointFromJson(Map<String, dynamic> json) {
  return _AnalyticsDataPoint.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsDataPoint {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get metricType => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsDataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsDataPointCopyWith<AnalyticsDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsDataPointCopyWith<$Res> {
  factory $AnalyticsDataPointCopyWith(
          AnalyticsDataPoint value, $Res Function(AnalyticsDataPoint) then) =
      _$AnalyticsDataPointCopyWithImpl<$Res, AnalyticsDataPoint>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String metricType,
      double value,
      DateTime timestamp,
      Map<String, dynamic> metadata,
      String? category,
      String? source});
}

/// @nodoc
class _$AnalyticsDataPointCopyWithImpl<$Res, $Val extends AnalyticsDataPoint>
    implements $AnalyticsDataPointCopyWith<$Res> {
  _$AnalyticsDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? metricType = null,
    Object? value = null,
    Object? timestamp = null,
    Object? metadata = null,
    Object? category = freezed,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      metricType: null == metricType
          ? _value.metricType
          : metricType // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyticsDataPointImplCopyWith<$Res>
    implements $AnalyticsDataPointCopyWith<$Res> {
  factory _$$AnalyticsDataPointImplCopyWith(_$AnalyticsDataPointImpl value,
          $Res Function(_$AnalyticsDataPointImpl) then) =
      __$$AnalyticsDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String metricType,
      double value,
      DateTime timestamp,
      Map<String, dynamic> metadata,
      String? category,
      String? source});
}

/// @nodoc
class __$$AnalyticsDataPointImplCopyWithImpl<$Res>
    extends _$AnalyticsDataPointCopyWithImpl<$Res, _$AnalyticsDataPointImpl>
    implements _$$AnalyticsDataPointImplCopyWith<$Res> {
  __$$AnalyticsDataPointImplCopyWithImpl(_$AnalyticsDataPointImpl _value,
      $Res Function(_$AnalyticsDataPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? metricType = null,
    Object? value = null,
    Object? timestamp = null,
    Object? metadata = null,
    Object? category = freezed,
    Object? source = freezed,
  }) {
    return _then(_$AnalyticsDataPointImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      metricType: null == metricType
          ? _value.metricType
          : metricType // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsDataPointImpl implements _AnalyticsDataPoint {
  const _$AnalyticsDataPointImpl(
      {required this.id,
      required this.userId,
      required this.metricType,
      required this.value,
      required this.timestamp,
      required final Map<String, dynamic> metadata,
      this.category,
      this.source})
      : _metadata = metadata;

  factory _$AnalyticsDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsDataPointImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String metricType;
  @override
  final double value;
  @override
  final DateTime timestamp;
  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? category;
  @override
  final String? source;

  @override
  String toString() {
    return 'AnalyticsDataPoint(id: $id, userId: $userId, metricType: $metricType, value: $value, timestamp: $timestamp, metadata: $metadata, category: $category, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsDataPointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.metricType, metricType) ||
                other.metricType == metricType) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      metricType,
      value,
      timestamp,
      const DeepCollectionEquality().hash(_metadata),
      category,
      source);

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsDataPointImplCopyWith<_$AnalyticsDataPointImpl> get copyWith =>
      __$$AnalyticsDataPointImplCopyWithImpl<_$AnalyticsDataPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsDataPointImplToJson(
      this,
    );
  }
}

abstract class _AnalyticsDataPoint implements AnalyticsDataPoint {
  const factory _AnalyticsDataPoint(
      {required final String id,
      required final String userId,
      required final String metricType,
      required final double value,
      required final DateTime timestamp,
      required final Map<String, dynamic> metadata,
      final String? category,
      final String? source}) = _$AnalyticsDataPointImpl;

  factory _AnalyticsDataPoint.fromJson(Map<String, dynamic> json) =
      _$AnalyticsDataPointImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get metricType;
  @override
  double get value;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get category;
  @override
  String? get source;

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsDataPointImplCopyWith<_$AnalyticsDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PatternRecognitionResult _$PatternRecognitionResultFromJson(
    Map<String, dynamic> json) {
  return _PatternRecognitionResult.fromJson(json);
}

/// @nodoc
mixin _$PatternRecognitionResult {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get patternType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get detectedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get patternData => throw _privateConstructorUsedError;
  List<String> get triggers => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  List<AnalyticsDataPoint> get supportingData =>
      throw _privateConstructorUsedError;

  /// Serializes this PatternRecognitionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatternRecognitionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternRecognitionResultCopyWith<PatternRecognitionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternRecognitionResultCopyWith<$Res> {
  factory $PatternRecognitionResultCopyWith(PatternRecognitionResult value,
          $Res Function(PatternRecognitionResult) then) =
      _$PatternRecognitionResultCopyWithImpl<$Res, PatternRecognitionResult>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String patternType,
      String description,
      double confidence,
      DateTime detectedAt,
      Map<String, dynamic> patternData,
      List<String> triggers,
      List<String> recommendations,
      List<AnalyticsDataPoint> supportingData});
}

/// @nodoc
class _$PatternRecognitionResultCopyWithImpl<$Res,
        $Val extends PatternRecognitionResult>
    implements $PatternRecognitionResultCopyWith<$Res> {
  _$PatternRecognitionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternRecognitionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? patternType = null,
    Object? description = null,
    Object? confidence = null,
    Object? detectedAt = null,
    Object? patternData = null,
    Object? triggers = null,
    Object? recommendations = null,
    Object? supportingData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      patternType: null == patternType
          ? _value.patternType
          : patternType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      detectedAt: null == detectedAt
          ? _value.detectedAt
          : detectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      patternData: null == patternData
          ? _value.patternData
          : patternData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      triggers: null == triggers
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      supportingData: null == supportingData
          ? _value.supportingData
          : supportingData // ignore: cast_nullable_to_non_nullable
              as List<AnalyticsDataPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatternRecognitionResultImplCopyWith<$Res>
    implements $PatternRecognitionResultCopyWith<$Res> {
  factory _$$PatternRecognitionResultImplCopyWith(
          _$PatternRecognitionResultImpl value,
          $Res Function(_$PatternRecognitionResultImpl) then) =
      __$$PatternRecognitionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String patternType,
      String description,
      double confidence,
      DateTime detectedAt,
      Map<String, dynamic> patternData,
      List<String> triggers,
      List<String> recommendations,
      List<AnalyticsDataPoint> supportingData});
}

/// @nodoc
class __$$PatternRecognitionResultImplCopyWithImpl<$Res>
    extends _$PatternRecognitionResultCopyWithImpl<$Res,
        _$PatternRecognitionResultImpl>
    implements _$$PatternRecognitionResultImplCopyWith<$Res> {
  __$$PatternRecognitionResultImplCopyWithImpl(
      _$PatternRecognitionResultImpl _value,
      $Res Function(_$PatternRecognitionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternRecognitionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? patternType = null,
    Object? description = null,
    Object? confidence = null,
    Object? detectedAt = null,
    Object? patternData = null,
    Object? triggers = null,
    Object? recommendations = null,
    Object? supportingData = null,
  }) {
    return _then(_$PatternRecognitionResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      patternType: null == patternType
          ? _value.patternType
          : patternType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      detectedAt: null == detectedAt
          ? _value.detectedAt
          : detectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      patternData: null == patternData
          ? _value._patternData
          : patternData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      triggers: null == triggers
          ? _value._triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      supportingData: null == supportingData
          ? _value._supportingData
          : supportingData // ignore: cast_nullable_to_non_nullable
              as List<AnalyticsDataPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatternRecognitionResultImpl implements _PatternRecognitionResult {
  const _$PatternRecognitionResultImpl(
      {required this.id,
      required this.userId,
      required this.patternType,
      required this.description,
      required this.confidence,
      required this.detectedAt,
      required final Map<String, dynamic> patternData,
      required final List<String> triggers,
      required final List<String> recommendations,
      final List<AnalyticsDataPoint> supportingData = const []})
      : _patternData = patternData,
        _triggers = triggers,
        _recommendations = recommendations,
        _supportingData = supportingData;

  factory _$PatternRecognitionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatternRecognitionResultImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String patternType;
  @override
  final String description;
  @override
  final double confidence;
  @override
  final DateTime detectedAt;
  final Map<String, dynamic> _patternData;
  @override
  Map<String, dynamic> get patternData {
    if (_patternData is EqualUnmodifiableMapView) return _patternData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_patternData);
  }

  final List<String> _triggers;
  @override
  List<String> get triggers {
    if (_triggers is EqualUnmodifiableListView) return _triggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triggers);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<AnalyticsDataPoint> _supportingData;
  @override
  @JsonKey()
  List<AnalyticsDataPoint> get supportingData {
    if (_supportingData is EqualUnmodifiableListView) return _supportingData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportingData);
  }

  @override
  String toString() {
    return 'PatternRecognitionResult(id: $id, userId: $userId, patternType: $patternType, description: $description, confidence: $confidence, detectedAt: $detectedAt, patternData: $patternData, triggers: $triggers, recommendations: $recommendations, supportingData: $supportingData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatternRecognitionResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.patternType, patternType) ||
                other.patternType == patternType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.detectedAt, detectedAt) ||
                other.detectedAt == detectedAt) &&
            const DeepCollectionEquality()
                .equals(other._patternData, _patternData) &&
            const DeepCollectionEquality().equals(other._triggers, _triggers) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality()
                .equals(other._supportingData, _supportingData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      patternType,
      description,
      confidence,
      detectedAt,
      const DeepCollectionEquality().hash(_patternData),
      const DeepCollectionEquality().hash(_triggers),
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_supportingData));

  /// Create a copy of PatternRecognitionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatternRecognitionResultImplCopyWith<_$PatternRecognitionResultImpl>
      get copyWith => __$$PatternRecognitionResultImplCopyWithImpl<
          _$PatternRecognitionResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatternRecognitionResultImplToJson(
      this,
    );
  }
}

abstract class _PatternRecognitionResult implements PatternRecognitionResult {
  const factory _PatternRecognitionResult(
          {required final String id,
          required final String userId,
          required final String patternType,
          required final String description,
          required final double confidence,
          required final DateTime detectedAt,
          required final Map<String, dynamic> patternData,
          required final List<String> triggers,
          required final List<String> recommendations,
          final List<AnalyticsDataPoint> supportingData}) =
      _$PatternRecognitionResultImpl;

  factory _PatternRecognitionResult.fromJson(Map<String, dynamic> json) =
      _$PatternRecognitionResultImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get patternType;
  @override
  String get description;
  @override
  double get confidence;
  @override
  DateTime get detectedAt;
  @override
  Map<String, dynamic> get patternData;
  @override
  List<String> get triggers;
  @override
  List<String> get recommendations;
  @override
  List<AnalyticsDataPoint> get supportingData;

  /// Create a copy of PatternRecognitionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatternRecognitionResultImplCopyWith<_$PatternRecognitionResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PredictiveModelResult _$PredictiveModelResultFromJson(
    Map<String, dynamic> json) {
  return _PredictiveModelResult.fromJson(json);
}

/// @nodoc
mixin _$PredictiveModelResult {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get modelType => throw _privateConstructorUsedError;
  double get prediction => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get modelData => throw _privateConstructorUsedError;
  List<String> get influencingFactors => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  List<AnalyticsDataPoint> get inputData => throw _privateConstructorUsedError;

  /// Serializes this PredictiveModelResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PredictiveModelResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictiveModelResultCopyWith<PredictiveModelResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictiveModelResultCopyWith<$Res> {
  factory $PredictiveModelResultCopyWith(PredictiveModelResult value,
          $Res Function(PredictiveModelResult) then) =
      _$PredictiveModelResultCopyWithImpl<$Res, PredictiveModelResult>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String modelType,
      double prediction,
      double confidence,
      DateTime generatedAt,
      Map<String, dynamic> modelData,
      List<String> influencingFactors,
      List<String> recommendations,
      List<AnalyticsDataPoint> inputData});
}

/// @nodoc
class _$PredictiveModelResultCopyWithImpl<$Res,
        $Val extends PredictiveModelResult>
    implements $PredictiveModelResultCopyWith<$Res> {
  _$PredictiveModelResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictiveModelResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? modelType = null,
    Object? prediction = null,
    Object? confidence = null,
    Object? generatedAt = null,
    Object? modelData = null,
    Object? influencingFactors = null,
    Object? recommendations = null,
    Object? inputData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      modelType: null == modelType
          ? _value.modelType
          : modelType // ignore: cast_nullable_to_non_nullable
              as String,
      prediction: null == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modelData: null == modelData
          ? _value.modelData
          : modelData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      influencingFactors: null == influencingFactors
          ? _value.influencingFactors
          : influencingFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inputData: null == inputData
          ? _value.inputData
          : inputData // ignore: cast_nullable_to_non_nullable
              as List<AnalyticsDataPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PredictiveModelResultImplCopyWith<$Res>
    implements $PredictiveModelResultCopyWith<$Res> {
  factory _$$PredictiveModelResultImplCopyWith(
          _$PredictiveModelResultImpl value,
          $Res Function(_$PredictiveModelResultImpl) then) =
      __$$PredictiveModelResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String modelType,
      double prediction,
      double confidence,
      DateTime generatedAt,
      Map<String, dynamic> modelData,
      List<String> influencingFactors,
      List<String> recommendations,
      List<AnalyticsDataPoint> inputData});
}

/// @nodoc
class __$$PredictiveModelResultImplCopyWithImpl<$Res>
    extends _$PredictiveModelResultCopyWithImpl<$Res,
        _$PredictiveModelResultImpl>
    implements _$$PredictiveModelResultImplCopyWith<$Res> {
  __$$PredictiveModelResultImplCopyWithImpl(_$PredictiveModelResultImpl _value,
      $Res Function(_$PredictiveModelResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of PredictiveModelResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? modelType = null,
    Object? prediction = null,
    Object? confidence = null,
    Object? generatedAt = null,
    Object? modelData = null,
    Object? influencingFactors = null,
    Object? recommendations = null,
    Object? inputData = null,
  }) {
    return _then(_$PredictiveModelResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      modelType: null == modelType
          ? _value.modelType
          : modelType // ignore: cast_nullable_to_non_nullable
              as String,
      prediction: null == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modelData: null == modelData
          ? _value._modelData
          : modelData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      influencingFactors: null == influencingFactors
          ? _value._influencingFactors
          : influencingFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inputData: null == inputData
          ? _value._inputData
          : inputData // ignore: cast_nullable_to_non_nullable
              as List<AnalyticsDataPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictiveModelResultImpl implements _PredictiveModelResult {
  const _$PredictiveModelResultImpl(
      {required this.id,
      required this.userId,
      required this.modelType,
      required this.prediction,
      required this.confidence,
      required this.generatedAt,
      required final Map<String, dynamic> modelData,
      required final List<String> influencingFactors,
      required final List<String> recommendations,
      final List<AnalyticsDataPoint> inputData = const []})
      : _modelData = modelData,
        _influencingFactors = influencingFactors,
        _recommendations = recommendations,
        _inputData = inputData;

  factory _$PredictiveModelResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictiveModelResultImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String modelType;
  @override
  final double prediction;
  @override
  final double confidence;
  @override
  final DateTime generatedAt;
  final Map<String, dynamic> _modelData;
  @override
  Map<String, dynamic> get modelData {
    if (_modelData is EqualUnmodifiableMapView) return _modelData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_modelData);
  }

  final List<String> _influencingFactors;
  @override
  List<String> get influencingFactors {
    if (_influencingFactors is EqualUnmodifiableListView)
      return _influencingFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_influencingFactors);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<AnalyticsDataPoint> _inputData;
  @override
  @JsonKey()
  List<AnalyticsDataPoint> get inputData {
    if (_inputData is EqualUnmodifiableListView) return _inputData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputData);
  }

  @override
  String toString() {
    return 'PredictiveModelResult(id: $id, userId: $userId, modelType: $modelType, prediction: $prediction, confidence: $confidence, generatedAt: $generatedAt, modelData: $modelData, influencingFactors: $influencingFactors, recommendations: $recommendations, inputData: $inputData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictiveModelResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.modelType, modelType) ||
                other.modelType == modelType) &&
            (identical(other.prediction, prediction) ||
                other.prediction == prediction) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality()
                .equals(other._modelData, _modelData) &&
            const DeepCollectionEquality()
                .equals(other._influencingFactors, _influencingFactors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality()
                .equals(other._inputData, _inputData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      modelType,
      prediction,
      confidence,
      generatedAt,
      const DeepCollectionEquality().hash(_modelData),
      const DeepCollectionEquality().hash(_influencingFactors),
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_inputData));

  /// Create a copy of PredictiveModelResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictiveModelResultImplCopyWith<_$PredictiveModelResultImpl>
      get copyWith => __$$PredictiveModelResultImplCopyWithImpl<
          _$PredictiveModelResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictiveModelResultImplToJson(
      this,
    );
  }
}

abstract class _PredictiveModelResult implements PredictiveModelResult {
  const factory _PredictiveModelResult(
      {required final String id,
      required final String userId,
      required final String modelType,
      required final double prediction,
      required final double confidence,
      required final DateTime generatedAt,
      required final Map<String, dynamic> modelData,
      required final List<String> influencingFactors,
      required final List<String> recommendations,
      final List<AnalyticsDataPoint> inputData}) = _$PredictiveModelResultImpl;

  factory _PredictiveModelResult.fromJson(Map<String, dynamic> json) =
      _$PredictiveModelResultImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get modelType;
  @override
  double get prediction;
  @override
  double get confidence;
  @override
  DateTime get generatedAt;
  @override
  Map<String, dynamic> get modelData;
  @override
  List<String> get influencingFactors;
  @override
  List<String> get recommendations;
  @override
  List<AnalyticsDataPoint> get inputData;

  /// Create a copy of PredictiveModelResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictiveModelResultImplCopyWith<_$PredictiveModelResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PersonalizedReport _$PersonalizedReportFromJson(Map<String, dynamic> json) {
  return _PersonalizedReport.fromJson(json);
}

/// @nodoc
mixin _$PersonalizedReport {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get reportType => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get reportData => throw _privateConstructorUsedError;
  List<InsightSection> get sections => throw _privateConstructorUsedError;
  List<String> get keyFindings => throw _privateConstructorUsedError;
  List<String> get actionableRecommendations =>
      throw _privateConstructorUsedError;
  bool get isShareable => throw _privateConstructorUsedError;

  /// Serializes this PersonalizedReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalizedReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalizedReportCopyWith<PersonalizedReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalizedReportCopyWith<$Res> {
  factory $PersonalizedReportCopyWith(
          PersonalizedReport value, $Res Function(PersonalizedReport) then) =
      _$PersonalizedReportCopyWithImpl<$Res, PersonalizedReport>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String reportType,
      DateTime generatedAt,
      Map<String, dynamic> reportData,
      List<InsightSection> sections,
      List<String> keyFindings,
      List<String> actionableRecommendations,
      bool isShareable});
}

/// @nodoc
class _$PersonalizedReportCopyWithImpl<$Res, $Val extends PersonalizedReport>
    implements $PersonalizedReportCopyWith<$Res> {
  _$PersonalizedReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalizedReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? reportType = null,
    Object? generatedAt = null,
    Object? reportData = null,
    Object? sections = null,
    Object? keyFindings = null,
    Object? actionableRecommendations = null,
    Object? isShareable = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reportData: null == reportData
          ? _value.reportData
          : reportData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<InsightSection>,
      keyFindings: null == keyFindings
          ? _value.keyFindings
          : keyFindings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      actionableRecommendations: null == actionableRecommendations
          ? _value.actionableRecommendations
          : actionableRecommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isShareable: null == isShareable
          ? _value.isShareable
          : isShareable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalizedReportImplCopyWith<$Res>
    implements $PersonalizedReportCopyWith<$Res> {
  factory _$$PersonalizedReportImplCopyWith(_$PersonalizedReportImpl value,
          $Res Function(_$PersonalizedReportImpl) then) =
      __$$PersonalizedReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String reportType,
      DateTime generatedAt,
      Map<String, dynamic> reportData,
      List<InsightSection> sections,
      List<String> keyFindings,
      List<String> actionableRecommendations,
      bool isShareable});
}

/// @nodoc
class __$$PersonalizedReportImplCopyWithImpl<$Res>
    extends _$PersonalizedReportCopyWithImpl<$Res, _$PersonalizedReportImpl>
    implements _$$PersonalizedReportImplCopyWith<$Res> {
  __$$PersonalizedReportImplCopyWithImpl(_$PersonalizedReportImpl _value,
      $Res Function(_$PersonalizedReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonalizedReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? reportType = null,
    Object? generatedAt = null,
    Object? reportData = null,
    Object? sections = null,
    Object? keyFindings = null,
    Object? actionableRecommendations = null,
    Object? isShareable = null,
  }) {
    return _then(_$PersonalizedReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reportData: null == reportData
          ? _value._reportData
          : reportData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<InsightSection>,
      keyFindings: null == keyFindings
          ? _value._keyFindings
          : keyFindings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      actionableRecommendations: null == actionableRecommendations
          ? _value._actionableRecommendations
          : actionableRecommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isShareable: null == isShareable
          ? _value.isShareable
          : isShareable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalizedReportImpl implements _PersonalizedReport {
  const _$PersonalizedReportImpl(
      {required this.id,
      required this.userId,
      required this.reportType,
      required this.generatedAt,
      required final Map<String, dynamic> reportData,
      required final List<InsightSection> sections,
      required final List<String> keyFindings,
      required final List<String> actionableRecommendations,
      this.isShareable = false})
      : _reportData = reportData,
        _sections = sections,
        _keyFindings = keyFindings,
        _actionableRecommendations = actionableRecommendations;

  factory _$PersonalizedReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalizedReportImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String reportType;
  @override
  final DateTime generatedAt;
  final Map<String, dynamic> _reportData;
  @override
  Map<String, dynamic> get reportData {
    if (_reportData is EqualUnmodifiableMapView) return _reportData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reportData);
  }

  final List<InsightSection> _sections;
  @override
  List<InsightSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  final List<String> _keyFindings;
  @override
  List<String> get keyFindings {
    if (_keyFindings is EqualUnmodifiableListView) return _keyFindings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyFindings);
  }

  final List<String> _actionableRecommendations;
  @override
  List<String> get actionableRecommendations {
    if (_actionableRecommendations is EqualUnmodifiableListView)
      return _actionableRecommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionableRecommendations);
  }

  @override
  @JsonKey()
  final bool isShareable;

  @override
  String toString() {
    return 'PersonalizedReport(id: $id, userId: $userId, reportType: $reportType, generatedAt: $generatedAt, reportData: $reportData, sections: $sections, keyFindings: $keyFindings, actionableRecommendations: $actionableRecommendations, isShareable: $isShareable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalizedReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality()
                .equals(other._reportData, _reportData) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            const DeepCollectionEquality()
                .equals(other._keyFindings, _keyFindings) &&
            const DeepCollectionEquality().equals(
                other._actionableRecommendations, _actionableRecommendations) &&
            (identical(other.isShareable, isShareable) ||
                other.isShareable == isShareable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      reportType,
      generatedAt,
      const DeepCollectionEquality().hash(_reportData),
      const DeepCollectionEquality().hash(_sections),
      const DeepCollectionEquality().hash(_keyFindings),
      const DeepCollectionEquality().hash(_actionableRecommendations),
      isShareable);

  /// Create a copy of PersonalizedReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalizedReportImplCopyWith<_$PersonalizedReportImpl> get copyWith =>
      __$$PersonalizedReportImplCopyWithImpl<_$PersonalizedReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalizedReportImplToJson(
      this,
    );
  }
}

abstract class _PersonalizedReport implements PersonalizedReport {
  const factory _PersonalizedReport(
      {required final String id,
      required final String userId,
      required final String reportType,
      required final DateTime generatedAt,
      required final Map<String, dynamic> reportData,
      required final List<InsightSection> sections,
      required final List<String> keyFindings,
      required final List<String> actionableRecommendations,
      final bool isShareable}) = _$PersonalizedReportImpl;

  factory _PersonalizedReport.fromJson(Map<String, dynamic> json) =
      _$PersonalizedReportImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get reportType;
  @override
  DateTime get generatedAt;
  @override
  Map<String, dynamic> get reportData;
  @override
  List<InsightSection> get sections;
  @override
  List<String> get keyFindings;
  @override
  List<String> get actionableRecommendations;
  @override
  bool get isShareable;

  /// Create a copy of PersonalizedReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalizedReportImplCopyWith<_$PersonalizedReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InsightSection _$InsightSectionFromJson(Map<String, dynamic> json) {
  return _InsightSection.fromJson(json);
}

/// @nodoc
mixin _$InsightSection {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get sectionType => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  List<String> get visualizations => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  /// Serializes this InsightSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InsightSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsightSectionCopyWith<InsightSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightSectionCopyWith<$Res> {
  factory $InsightSectionCopyWith(
          InsightSection value, $Res Function(InsightSection) then) =
      _$InsightSectionCopyWithImpl<$Res, InsightSection>;
  @useResult
  $Res call(
      {String title,
      String content,
      String sectionType,
      Map<String, dynamic> data,
      List<String> visualizations,
      List<String> recommendations});
}

/// @nodoc
class _$InsightSectionCopyWithImpl<$Res, $Val extends InsightSection>
    implements $InsightSectionCopyWith<$Res> {
  _$InsightSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsightSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? sectionType = null,
    Object? data = null,
    Object? visualizations = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sectionType: null == sectionType
          ? _value.sectionType
          : sectionType // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      visualizations: null == visualizations
          ? _value.visualizations
          : visualizations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightSectionImplCopyWith<$Res>
    implements $InsightSectionCopyWith<$Res> {
  factory _$$InsightSectionImplCopyWith(_$InsightSectionImpl value,
          $Res Function(_$InsightSectionImpl) then) =
      __$$InsightSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      String sectionType,
      Map<String, dynamic> data,
      List<String> visualizations,
      List<String> recommendations});
}

/// @nodoc
class __$$InsightSectionImplCopyWithImpl<$Res>
    extends _$InsightSectionCopyWithImpl<$Res, _$InsightSectionImpl>
    implements _$$InsightSectionImplCopyWith<$Res> {
  __$$InsightSectionImplCopyWithImpl(
      _$InsightSectionImpl _value, $Res Function(_$InsightSectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of InsightSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? sectionType = null,
    Object? data = null,
    Object? visualizations = null,
    Object? recommendations = null,
  }) {
    return _then(_$InsightSectionImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sectionType: null == sectionType
          ? _value.sectionType
          : sectionType // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      visualizations: null == visualizations
          ? _value._visualizations
          : visualizations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsightSectionImpl implements _InsightSection {
  const _$InsightSectionImpl(
      {required this.title,
      required this.content,
      required this.sectionType,
      required final Map<String, dynamic> data,
      final List<String> visualizations = const [],
      final List<String> recommendations = const []})
      : _data = data,
        _visualizations = visualizations,
        _recommendations = recommendations;

  factory _$InsightSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsightSectionImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  final String sectionType;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  final List<String> _visualizations;
  @override
  @JsonKey()
  List<String> get visualizations {
    if (_visualizations is EqualUnmodifiableListView) return _visualizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visualizations);
  }

  final List<String> _recommendations;
  @override
  @JsonKey()
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'InsightSection(title: $title, content: $content, sectionType: $sectionType, data: $data, visualizations: $visualizations, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightSectionImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sectionType, sectionType) ||
                other.sectionType == sectionType) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._visualizations, _visualizations) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      content,
      sectionType,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_visualizations),
      const DeepCollectionEquality().hash(_recommendations));

  /// Create a copy of InsightSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightSectionImplCopyWith<_$InsightSectionImpl> get copyWith =>
      __$$InsightSectionImplCopyWithImpl<_$InsightSectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InsightSectionImplToJson(
      this,
    );
  }
}

abstract class _InsightSection implements InsightSection {
  const factory _InsightSection(
      {required final String title,
      required final String content,
      required final String sectionType,
      required final Map<String, dynamic> data,
      final List<String> visualizations,
      final List<String> recommendations}) = _$InsightSectionImpl;

  factory _InsightSection.fromJson(Map<String, dynamic> json) =
      _$InsightSectionImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  String get sectionType;
  @override
  Map<String, dynamic> get data;
  @override
  List<String> get visualizations;
  @override
  List<String> get recommendations;

  /// Create a copy of InsightSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsightSectionImplCopyWith<_$InsightSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsWorkflowContext _$AnalyticsWorkflowContextFromJson(
    Map<String, dynamic> json) {
  return _AnalyticsWorkflowContext.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsWorkflowContext {
  String get userId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<String> get analysisTypes => throw _privateConstructorUsedError;
  Map<String, dynamic> get userProfile => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;
  List<AnalyticsDataPoint> get historicalData =>
      throw _privateConstructorUsedError;

  /// Serializes this AnalyticsWorkflowContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsWorkflowContextCopyWith<AnalyticsWorkflowContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsWorkflowContextCopyWith<$Res> {
  factory $AnalyticsWorkflowContextCopyWith(AnalyticsWorkflowContext value,
          $Res Function(AnalyticsWorkflowContext) then) =
      _$AnalyticsWorkflowContextCopyWithImpl<$Res, AnalyticsWorkflowContext>;
  @useResult
  $Res call(
      {String userId,
      DateTime startDate,
      DateTime endDate,
      List<String> analysisTypes,
      Map<String, dynamic> userProfile,
      Map<String, dynamic> preferences,
      List<AnalyticsDataPoint> historicalData});
}

/// @nodoc
class _$AnalyticsWorkflowContextCopyWithImpl<$Res,
        $Val extends AnalyticsWorkflowContext>
    implements $AnalyticsWorkflowContextCopyWith<$Res> {
  _$AnalyticsWorkflowContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? analysisTypes = null,
    Object? userProfile = null,
    Object? preferences = null,
    Object? historicalData = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      analysisTypes: null == analysisTypes
          ? _value.analysisTypes
          : analysisTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userProfile: null == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      historicalData: null == historicalData
          ? _value.historicalData
          : historicalData // ignore: cast_nullable_to_non_nullable
              as List<AnalyticsDataPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyticsWorkflowContextImplCopyWith<$Res>
    implements $AnalyticsWorkflowContextCopyWith<$Res> {
  factory _$$AnalyticsWorkflowContextImplCopyWith(
          _$AnalyticsWorkflowContextImpl value,
          $Res Function(_$AnalyticsWorkflowContextImpl) then) =
      __$$AnalyticsWorkflowContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime startDate,
      DateTime endDate,
      List<String> analysisTypes,
      Map<String, dynamic> userProfile,
      Map<String, dynamic> preferences,
      List<AnalyticsDataPoint> historicalData});
}

/// @nodoc
class __$$AnalyticsWorkflowContextImplCopyWithImpl<$Res>
    extends _$AnalyticsWorkflowContextCopyWithImpl<$Res,
        _$AnalyticsWorkflowContextImpl>
    implements _$$AnalyticsWorkflowContextImplCopyWith<$Res> {
  __$$AnalyticsWorkflowContextImplCopyWithImpl(
      _$AnalyticsWorkflowContextImpl _value,
      $Res Function(_$AnalyticsWorkflowContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? analysisTypes = null,
    Object? userProfile = null,
    Object? preferences = null,
    Object? historicalData = null,
  }) {
    return _then(_$AnalyticsWorkflowContextImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      analysisTypes: null == analysisTypes
          ? _value._analysisTypes
          : analysisTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userProfile: null == userProfile
          ? _value._userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      historicalData: null == historicalData
          ? _value._historicalData
          : historicalData // ignore: cast_nullable_to_non_nullable
              as List<AnalyticsDataPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsWorkflowContextImpl implements _AnalyticsWorkflowContext {
  const _$AnalyticsWorkflowContextImpl(
      {required this.userId,
      required this.startDate,
      required this.endDate,
      required final List<String> analysisTypes,
      required final Map<String, dynamic> userProfile,
      final Map<String, dynamic> preferences = const {},
      final List<AnalyticsDataPoint> historicalData = const []})
      : _analysisTypes = analysisTypes,
        _userProfile = userProfile,
        _preferences = preferences,
        _historicalData = historicalData;

  factory _$AnalyticsWorkflowContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsWorkflowContextImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<String> _analysisTypes;
  @override
  List<String> get analysisTypes {
    if (_analysisTypes is EqualUnmodifiableListView) return _analysisTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_analysisTypes);
  }

  final Map<String, dynamic> _userProfile;
  @override
  Map<String, dynamic> get userProfile {
    if (_userProfile is EqualUnmodifiableMapView) return _userProfile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userProfile);
  }

  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  final List<AnalyticsDataPoint> _historicalData;
  @override
  @JsonKey()
  List<AnalyticsDataPoint> get historicalData {
    if (_historicalData is EqualUnmodifiableListView) return _historicalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalData);
  }

  @override
  String toString() {
    return 'AnalyticsWorkflowContext(userId: $userId, startDate: $startDate, endDate: $endDate, analysisTypes: $analysisTypes, userProfile: $userProfile, preferences: $preferences, historicalData: $historicalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsWorkflowContextImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality()
                .equals(other._analysisTypes, _analysisTypes) &&
            const DeepCollectionEquality()
                .equals(other._userProfile, _userProfile) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            const DeepCollectionEquality()
                .equals(other._historicalData, _historicalData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_analysisTypes),
      const DeepCollectionEquality().hash(_userProfile),
      const DeepCollectionEquality().hash(_preferences),
      const DeepCollectionEquality().hash(_historicalData));

  /// Create a copy of AnalyticsWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsWorkflowContextImplCopyWith<_$AnalyticsWorkflowContextImpl>
      get copyWith => __$$AnalyticsWorkflowContextImplCopyWithImpl<
          _$AnalyticsWorkflowContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsWorkflowContextImplToJson(
      this,
    );
  }
}

abstract class _AnalyticsWorkflowContext implements AnalyticsWorkflowContext {
  const factory _AnalyticsWorkflowContext(
          {required final String userId,
          required final DateTime startDate,
          required final DateTime endDate,
          required final List<String> analysisTypes,
          required final Map<String, dynamic> userProfile,
          final Map<String, dynamic> preferences,
          final List<AnalyticsDataPoint> historicalData}) =
      _$AnalyticsWorkflowContextImpl;

  factory _AnalyticsWorkflowContext.fromJson(Map<String, dynamic> json) =
      _$AnalyticsWorkflowContextImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<String> get analysisTypes;
  @override
  Map<String, dynamic> get userProfile;
  @override
  Map<String, dynamic> get preferences;
  @override
  List<AnalyticsDataPoint> get historicalData;

  /// Create a copy of AnalyticsWorkflowContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsWorkflowContextImplCopyWith<_$AnalyticsWorkflowContextImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuitSuccessPrediction _$QuitSuccessPredictionFromJson(
    Map<String, dynamic> json) {
  return _QuitSuccessPrediction.fromJson(json);
}

/// @nodoc
mixin _$QuitSuccessPrediction {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get successProbability => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get predictionDate => throw _privateConstructorUsedError;
  String get timeHorizon => throw _privateConstructorUsedError;
  List<String> get positiveFactors => throw _privateConstructorUsedError;
  List<String> get riskFactors => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  Map<String, dynamic> get modelMetrics => throw _privateConstructorUsedError;

  /// Serializes this QuitSuccessPrediction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuitSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuitSuccessPredictionCopyWith<QuitSuccessPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuitSuccessPredictionCopyWith<$Res> {
  factory $QuitSuccessPredictionCopyWith(QuitSuccessPrediction value,
          $Res Function(QuitSuccessPrediction) then) =
      _$QuitSuccessPredictionCopyWithImpl<$Res, QuitSuccessPrediction>;
  @useResult
  $Res call(
      {String id,
      String userId,
      double successProbability,
      double confidence,
      DateTime predictionDate,
      String timeHorizon,
      List<String> positiveFactors,
      List<String> riskFactors,
      List<String> recommendations,
      Map<String, dynamic> modelMetrics});
}

/// @nodoc
class _$QuitSuccessPredictionCopyWithImpl<$Res,
        $Val extends QuitSuccessPrediction>
    implements $QuitSuccessPredictionCopyWith<$Res> {
  _$QuitSuccessPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuitSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? successProbability = null,
    Object? confidence = null,
    Object? predictionDate = null,
    Object? timeHorizon = null,
    Object? positiveFactors = null,
    Object? riskFactors = null,
    Object? recommendations = null,
    Object? modelMetrics = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _value.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      predictionDate: null == predictionDate
          ? _value.predictionDate
          : predictionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeHorizon: null == timeHorizon
          ? _value.timeHorizon
          : timeHorizon // ignore: cast_nullable_to_non_nullable
              as String,
      positiveFactors: null == positiveFactors
          ? _value.positiveFactors
          : positiveFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      riskFactors: null == riskFactors
          ? _value.riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      modelMetrics: null == modelMetrics
          ? _value.modelMetrics
          : modelMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuitSuccessPredictionImplCopyWith<$Res>
    implements $QuitSuccessPredictionCopyWith<$Res> {
  factory _$$QuitSuccessPredictionImplCopyWith(
          _$QuitSuccessPredictionImpl value,
          $Res Function(_$QuitSuccessPredictionImpl) then) =
      __$$QuitSuccessPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      double successProbability,
      double confidence,
      DateTime predictionDate,
      String timeHorizon,
      List<String> positiveFactors,
      List<String> riskFactors,
      List<String> recommendations,
      Map<String, dynamic> modelMetrics});
}

/// @nodoc
class __$$QuitSuccessPredictionImplCopyWithImpl<$Res>
    extends _$QuitSuccessPredictionCopyWithImpl<$Res,
        _$QuitSuccessPredictionImpl>
    implements _$$QuitSuccessPredictionImplCopyWith<$Res> {
  __$$QuitSuccessPredictionImplCopyWithImpl(_$QuitSuccessPredictionImpl _value,
      $Res Function(_$QuitSuccessPredictionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuitSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? successProbability = null,
    Object? confidence = null,
    Object? predictionDate = null,
    Object? timeHorizon = null,
    Object? positiveFactors = null,
    Object? riskFactors = null,
    Object? recommendations = null,
    Object? modelMetrics = null,
  }) {
    return _then(_$QuitSuccessPredictionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _value.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      predictionDate: null == predictionDate
          ? _value.predictionDate
          : predictionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeHorizon: null == timeHorizon
          ? _value.timeHorizon
          : timeHorizon // ignore: cast_nullable_to_non_nullable
              as String,
      positiveFactors: null == positiveFactors
          ? _value._positiveFactors
          : positiveFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      riskFactors: null == riskFactors
          ? _value._riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      modelMetrics: null == modelMetrics
          ? _value._modelMetrics
          : modelMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuitSuccessPredictionImpl implements _QuitSuccessPrediction {
  const _$QuitSuccessPredictionImpl(
      {required this.id,
      required this.userId,
      required this.successProbability,
      required this.confidence,
      required this.predictionDate,
      required this.timeHorizon,
      required final List<String> positiveFactors,
      required final List<String> riskFactors,
      required final List<String> recommendations,
      required final Map<String, dynamic> modelMetrics})
      : _positiveFactors = positiveFactors,
        _riskFactors = riskFactors,
        _recommendations = recommendations,
        _modelMetrics = modelMetrics;

  factory _$QuitSuccessPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuitSuccessPredictionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final double successProbability;
  @override
  final double confidence;
  @override
  final DateTime predictionDate;
  @override
  final String timeHorizon;
  final List<String> _positiveFactors;
  @override
  List<String> get positiveFactors {
    if (_positiveFactors is EqualUnmodifiableListView) return _positiveFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_positiveFactors);
  }

  final List<String> _riskFactors;
  @override
  List<String> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final Map<String, dynamic> _modelMetrics;
  @override
  Map<String, dynamic> get modelMetrics {
    if (_modelMetrics is EqualUnmodifiableMapView) return _modelMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_modelMetrics);
  }

  @override
  String toString() {
    return 'QuitSuccessPrediction(id: $id, userId: $userId, successProbability: $successProbability, confidence: $confidence, predictionDate: $predictionDate, timeHorizon: $timeHorizon, positiveFactors: $positiveFactors, riskFactors: $riskFactors, recommendations: $recommendations, modelMetrics: $modelMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuitSuccessPredictionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.predictionDate, predictionDate) ||
                other.predictionDate == predictionDate) &&
            (identical(other.timeHorizon, timeHorizon) ||
                other.timeHorizon == timeHorizon) &&
            const DeepCollectionEquality()
                .equals(other._positiveFactors, _positiveFactors) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality()
                .equals(other._modelMetrics, _modelMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      successProbability,
      confidence,
      predictionDate,
      timeHorizon,
      const DeepCollectionEquality().hash(_positiveFactors),
      const DeepCollectionEquality().hash(_riskFactors),
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_modelMetrics));

  /// Create a copy of QuitSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuitSuccessPredictionImplCopyWith<_$QuitSuccessPredictionImpl>
      get copyWith => __$$QuitSuccessPredictionImplCopyWithImpl<
          _$QuitSuccessPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuitSuccessPredictionImplToJson(
      this,
    );
  }
}

abstract class _QuitSuccessPrediction implements QuitSuccessPrediction {
  const factory _QuitSuccessPrediction(
          {required final String id,
          required final String userId,
          required final double successProbability,
          required final double confidence,
          required final DateTime predictionDate,
          required final String timeHorizon,
          required final List<String> positiveFactors,
          required final List<String> riskFactors,
          required final List<String> recommendations,
          required final Map<String, dynamic> modelMetrics}) =
      _$QuitSuccessPredictionImpl;

  factory _QuitSuccessPrediction.fromJson(Map<String, dynamic> json) =
      _$QuitSuccessPredictionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  double get successProbability;
  @override
  double get confidence;
  @override
  DateTime get predictionDate;
  @override
  String get timeHorizon;
  @override
  List<String> get positiveFactors;
  @override
  List<String> get riskFactors;
  @override
  List<String> get recommendations;
  @override
  Map<String, dynamic> get modelMetrics;

  /// Create a copy of QuitSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuitSuccessPredictionImplCopyWith<_$QuitSuccessPredictionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
