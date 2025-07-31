// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIChatMessage _$AIChatMessageFromJson(Map<String, dynamic> json) {
  return _AIChatMessage.fromJson(json);
}

/// @nodoc
mixin _$AIChatMessage {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError; // 'user' or 'ai'
  String? get intent =>
      throw _privateConstructorUsedError; // The detected intent of the message
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this AIChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIChatMessageCopyWith<AIChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIChatMessageCopyWith<$Res> {
  factory $AIChatMessageCopyWith(
          AIChatMessage value, $Res Function(AIChatMessage) then) =
      _$AIChatMessageCopyWithImpl<$Res, AIChatMessage>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String content,
      String sender,
      String? intent,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AIChatMessageCopyWithImpl<$Res, $Val extends AIChatMessage>
    implements $AIChatMessageCopyWith<$Res> {
  _$AIChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? content = null,
    Object? sender = null,
    Object? intent = freezed,
    Object? metadata = freezed,
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIChatMessageImplCopyWith<$Res>
    implements $AIChatMessageCopyWith<$Res> {
  factory _$$AIChatMessageImplCopyWith(
          _$AIChatMessageImpl value, $Res Function(_$AIChatMessageImpl) then) =
      __$$AIChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String content,
      String sender,
      String? intent,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$AIChatMessageImplCopyWithImpl<$Res>
    extends _$AIChatMessageCopyWithImpl<$Res, _$AIChatMessageImpl>
    implements _$$AIChatMessageImplCopyWith<$Res> {
  __$$AIChatMessageImplCopyWithImpl(
      _$AIChatMessageImpl _value, $Res Function(_$AIChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? content = null,
    Object? sender = null,
    Object? intent = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$AIChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIChatMessageImpl implements _AIChatMessage {
  const _$AIChatMessageImpl(
      {required this.id,
      required this.timestamp,
      required this.content,
      required this.sender,
      this.intent,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$AIChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final String content;
  @override
  final String sender;
// 'user' or 'ai'
  @override
  final String? intent;
// The detected intent of the message
  final Map<String, dynamic>? _metadata;
// The detected intent of the message
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
    return 'AIChatMessage(id: $id, timestamp: $timestamp, content: $content, sender: $sender, intent: $intent, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, timestamp, content, sender,
      intent, const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIChatMessageImplCopyWith<_$AIChatMessageImpl> get copyWith =>
      __$$AIChatMessageImplCopyWithImpl<_$AIChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIChatMessageImplToJson(
      this,
    );
  }
}

abstract class _AIChatMessage implements AIChatMessage {
  const factory _AIChatMessage(
      {required final String id,
      required final DateTime timestamp,
      required final String content,
      required final String sender,
      final String? intent,
      final Map<String, dynamic>? metadata}) = _$AIChatMessageImpl;

  factory _AIChatMessage.fromJson(Map<String, dynamic> json) =
      _$AIChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  String get content;
  @override
  String get sender; // 'user' or 'ai'
  @override
  String? get intent; // The detected intent of the message
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIChatMessageImplCopyWith<_$AIChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIRecommendation _$AIRecommendationFromJson(Map<String, dynamic> json) {
  return _AIRecommendation.fromJson(json);
}

/// @nodoc
mixin _$AIRecommendation {
  String get id => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'coping_strategy', 'motivation', 'education', etc.
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  double get relevanceScore => throw _privateConstructorUsedError; // 0.0 to 1.0
  String? get triggerContext => throw _privateConstructorUsedError;
  Map<String, dynamic>? get actionableSteps =>
      throw _privateConstructorUsedError;
  bool get userRated => throw _privateConstructorUsedError;
  int? get userRating => throw _privateConstructorUsedError;

  /// Serializes this AIRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIRecommendationCopyWith<AIRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIRecommendationCopyWith<$Res> {
  factory $AIRecommendationCopyWith(
          AIRecommendation value, $Res Function(AIRecommendation) then) =
      _$AIRecommendationCopyWithImpl<$Res, AIRecommendation>;
  @useResult
  $Res call(
      {String id,
      DateTime generatedAt,
      String type,
      String title,
      String content,
      double relevanceScore,
      String? triggerContext,
      Map<String, dynamic>? actionableSteps,
      bool userRated,
      int? userRating});
}

/// @nodoc
class _$AIRecommendationCopyWithImpl<$Res, $Val extends AIRecommendation>
    implements $AIRecommendationCopyWith<$Res> {
  _$AIRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? generatedAt = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? relevanceScore = null,
    Object? triggerContext = freezed,
    Object? actionableSteps = freezed,
    Object? userRated = null,
    Object? userRating = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      triggerContext: freezed == triggerContext
          ? _value.triggerContext
          : triggerContext // ignore: cast_nullable_to_non_nullable
              as String?,
      actionableSteps: freezed == actionableSteps
          ? _value.actionableSteps
          : actionableSteps // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      userRated: null == userRated
          ? _value.userRated
          : userRated // ignore: cast_nullable_to_non_nullable
              as bool,
      userRating: freezed == userRating
          ? _value.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIRecommendationImplCopyWith<$Res>
    implements $AIRecommendationCopyWith<$Res> {
  factory _$$AIRecommendationImplCopyWith(_$AIRecommendationImpl value,
          $Res Function(_$AIRecommendationImpl) then) =
      __$$AIRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime generatedAt,
      String type,
      String title,
      String content,
      double relevanceScore,
      String? triggerContext,
      Map<String, dynamic>? actionableSteps,
      bool userRated,
      int? userRating});
}

/// @nodoc
class __$$AIRecommendationImplCopyWithImpl<$Res>
    extends _$AIRecommendationCopyWithImpl<$Res, _$AIRecommendationImpl>
    implements _$$AIRecommendationImplCopyWith<$Res> {
  __$$AIRecommendationImplCopyWithImpl(_$AIRecommendationImpl _value,
      $Res Function(_$AIRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? generatedAt = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? relevanceScore = null,
    Object? triggerContext = freezed,
    Object? actionableSteps = freezed,
    Object? userRated = null,
    Object? userRating = freezed,
  }) {
    return _then(_$AIRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      triggerContext: freezed == triggerContext
          ? _value.triggerContext
          : triggerContext // ignore: cast_nullable_to_non_nullable
              as String?,
      actionableSteps: freezed == actionableSteps
          ? _value._actionableSteps
          : actionableSteps // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      userRated: null == userRated
          ? _value.userRated
          : userRated // ignore: cast_nullable_to_non_nullable
              as bool,
      userRating: freezed == userRating
          ? _value.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIRecommendationImpl implements _AIRecommendation {
  const _$AIRecommendationImpl(
      {required this.id,
      required this.generatedAt,
      required this.type,
      required this.title,
      required this.content,
      required this.relevanceScore,
      this.triggerContext,
      final Map<String, dynamic>? actionableSteps,
      required this.userRated,
      this.userRating})
      : _actionableSteps = actionableSteps;

  factory _$AIRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime generatedAt;
  @override
  final String type;
// 'coping_strategy', 'motivation', 'education', etc.
  @override
  final String title;
  @override
  final String content;
  @override
  final double relevanceScore;
// 0.0 to 1.0
  @override
  final String? triggerContext;
  final Map<String, dynamic>? _actionableSteps;
  @override
  Map<String, dynamic>? get actionableSteps {
    final value = _actionableSteps;
    if (value == null) return null;
    if (_actionableSteps is EqualUnmodifiableMapView) return _actionableSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool userRated;
  @override
  final int? userRating;

  @override
  String toString() {
    return 'AIRecommendation(id: $id, generatedAt: $generatedAt, type: $type, title: $title, content: $content, relevanceScore: $relevanceScore, triggerContext: $triggerContext, actionableSteps: $actionableSteps, userRated: $userRated, userRating: $userRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore) &&
            (identical(other.triggerContext, triggerContext) ||
                other.triggerContext == triggerContext) &&
            const DeepCollectionEquality()
                .equals(other._actionableSteps, _actionableSteps) &&
            (identical(other.userRated, userRated) ||
                other.userRated == userRated) &&
            (identical(other.userRating, userRating) ||
                other.userRating == userRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      generatedAt,
      type,
      title,
      content,
      relevanceScore,
      triggerContext,
      const DeepCollectionEquality().hash(_actionableSteps),
      userRated,
      userRating);

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIRecommendationImplCopyWith<_$AIRecommendationImpl> get copyWith =>
      __$$AIRecommendationImplCopyWithImpl<_$AIRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIRecommendationImplToJson(
      this,
    );
  }
}

abstract class _AIRecommendation implements AIRecommendation {
  const factory _AIRecommendation(
      {required final String id,
      required final DateTime generatedAt,
      required final String type,
      required final String title,
      required final String content,
      required final double relevanceScore,
      final String? triggerContext,
      final Map<String, dynamic>? actionableSteps,
      required final bool userRated,
      final int? userRating}) = _$AIRecommendationImpl;

  factory _AIRecommendation.fromJson(Map<String, dynamic> json) =
      _$AIRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get generatedAt;
  @override
  String get type; // 'coping_strategy', 'motivation', 'education', etc.
  @override
  String get title;
  @override
  String get content;
  @override
  double get relevanceScore; // 0.0 to 1.0
  @override
  String? get triggerContext;
  @override
  Map<String, dynamic>? get actionableSteps;
  @override
  bool get userRated;
  @override
  int? get userRating;

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIRecommendationImplCopyWith<_$AIRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIPatternAnalysis _$AIPatternAnalysisFromJson(Map<String, dynamic> json) {
  return _AIPatternAnalysis.fromJson(json);
}

/// @nodoc
mixin _$AIPatternAnalysis {
  String get id => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get identifiedPatterns =>
      throw _privateConstructorUsedError;
  Map<String, List<String>> get triggersByCategory =>
      throw _privateConstructorUsedError;
  Map<String, double> get timeOfDayDistribution =>
      throw _privateConstructorUsedError;
  List<String> get mostEffectiveStrategies =>
      throw _privateConstructorUsedError;
  List<String> get leastEffectiveStrategies =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get customInsights => throw _privateConstructorUsedError;

  /// Serializes this AIPatternAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIPatternAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIPatternAnalysisCopyWith<AIPatternAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIPatternAnalysisCopyWith<$Res> {
  factory $AIPatternAnalysisCopyWith(
          AIPatternAnalysis value, $Res Function(AIPatternAnalysis) then) =
      _$AIPatternAnalysisCopyWithImpl<$Res, AIPatternAnalysis>;
  @useResult
  $Res call(
      {String id,
      DateTime generatedAt,
      String userId,
      List<Map<String, dynamic>> identifiedPatterns,
      Map<String, List<String>> triggersByCategory,
      Map<String, double> timeOfDayDistribution,
      List<String> mostEffectiveStrategies,
      List<String> leastEffectiveStrategies,
      Map<String, dynamic> customInsights});
}

/// @nodoc
class _$AIPatternAnalysisCopyWithImpl<$Res, $Val extends AIPatternAnalysis>
    implements $AIPatternAnalysisCopyWith<$Res> {
  _$AIPatternAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIPatternAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? generatedAt = null,
    Object? userId = null,
    Object? identifiedPatterns = null,
    Object? triggersByCategory = null,
    Object? timeOfDayDistribution = null,
    Object? mostEffectiveStrategies = null,
    Object? leastEffectiveStrategies = null,
    Object? customInsights = null,
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
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      identifiedPatterns: null == identifiedPatterns
          ? _value.identifiedPatterns
          : identifiedPatterns // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      triggersByCategory: null == triggersByCategory
          ? _value.triggersByCategory
          : triggersByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      timeOfDayDistribution: null == timeOfDayDistribution
          ? _value.timeOfDayDistribution
          : timeOfDayDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      mostEffectiveStrategies: null == mostEffectiveStrategies
          ? _value.mostEffectiveStrategies
          : mostEffectiveStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      leastEffectiveStrategies: null == leastEffectiveStrategies
          ? _value.leastEffectiveStrategies
          : leastEffectiveStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customInsights: null == customInsights
          ? _value.customInsights
          : customInsights // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIPatternAnalysisImplCopyWith<$Res>
    implements $AIPatternAnalysisCopyWith<$Res> {
  factory _$$AIPatternAnalysisImplCopyWith(_$AIPatternAnalysisImpl value,
          $Res Function(_$AIPatternAnalysisImpl) then) =
      __$$AIPatternAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime generatedAt,
      String userId,
      List<Map<String, dynamic>> identifiedPatterns,
      Map<String, List<String>> triggersByCategory,
      Map<String, double> timeOfDayDistribution,
      List<String> mostEffectiveStrategies,
      List<String> leastEffectiveStrategies,
      Map<String, dynamic> customInsights});
}

/// @nodoc
class __$$AIPatternAnalysisImplCopyWithImpl<$Res>
    extends _$AIPatternAnalysisCopyWithImpl<$Res, _$AIPatternAnalysisImpl>
    implements _$$AIPatternAnalysisImplCopyWith<$Res> {
  __$$AIPatternAnalysisImplCopyWithImpl(_$AIPatternAnalysisImpl _value,
      $Res Function(_$AIPatternAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIPatternAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? generatedAt = null,
    Object? userId = null,
    Object? identifiedPatterns = null,
    Object? triggersByCategory = null,
    Object? timeOfDayDistribution = null,
    Object? mostEffectiveStrategies = null,
    Object? leastEffectiveStrategies = null,
    Object? customInsights = null,
  }) {
    return _then(_$AIPatternAnalysisImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      identifiedPatterns: null == identifiedPatterns
          ? _value._identifiedPatterns
          : identifiedPatterns // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      triggersByCategory: null == triggersByCategory
          ? _value._triggersByCategory
          : triggersByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      timeOfDayDistribution: null == timeOfDayDistribution
          ? _value._timeOfDayDistribution
          : timeOfDayDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      mostEffectiveStrategies: null == mostEffectiveStrategies
          ? _value._mostEffectiveStrategies
          : mostEffectiveStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      leastEffectiveStrategies: null == leastEffectiveStrategies
          ? _value._leastEffectiveStrategies
          : leastEffectiveStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customInsights: null == customInsights
          ? _value._customInsights
          : customInsights // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIPatternAnalysisImpl implements _AIPatternAnalysis {
  const _$AIPatternAnalysisImpl(
      {required this.id,
      required this.generatedAt,
      required this.userId,
      required final List<Map<String, dynamic>> identifiedPatterns,
      required final Map<String, List<String>> triggersByCategory,
      required final Map<String, double> timeOfDayDistribution,
      required final List<String> mostEffectiveStrategies,
      required final List<String> leastEffectiveStrategies,
      required final Map<String, dynamic> customInsights})
      : _identifiedPatterns = identifiedPatterns,
        _triggersByCategory = triggersByCategory,
        _timeOfDayDistribution = timeOfDayDistribution,
        _mostEffectiveStrategies = mostEffectiveStrategies,
        _leastEffectiveStrategies = leastEffectiveStrategies,
        _customInsights = customInsights;

  factory _$AIPatternAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIPatternAnalysisImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime generatedAt;
  @override
  final String userId;
  final List<Map<String, dynamic>> _identifiedPatterns;
  @override
  List<Map<String, dynamic>> get identifiedPatterns {
    if (_identifiedPatterns is EqualUnmodifiableListView)
      return _identifiedPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_identifiedPatterns);
  }

  final Map<String, List<String>> _triggersByCategory;
  @override
  Map<String, List<String>> get triggersByCategory {
    if (_triggersByCategory is EqualUnmodifiableMapView)
      return _triggersByCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_triggersByCategory);
  }

  final Map<String, double> _timeOfDayDistribution;
  @override
  Map<String, double> get timeOfDayDistribution {
    if (_timeOfDayDistribution is EqualUnmodifiableMapView)
      return _timeOfDayDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_timeOfDayDistribution);
  }

  final List<String> _mostEffectiveStrategies;
  @override
  List<String> get mostEffectiveStrategies {
    if (_mostEffectiveStrategies is EqualUnmodifiableListView)
      return _mostEffectiveStrategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostEffectiveStrategies);
  }

  final List<String> _leastEffectiveStrategies;
  @override
  List<String> get leastEffectiveStrategies {
    if (_leastEffectiveStrategies is EqualUnmodifiableListView)
      return _leastEffectiveStrategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leastEffectiveStrategies);
  }

  final Map<String, dynamic> _customInsights;
  @override
  Map<String, dynamic> get customInsights {
    if (_customInsights is EqualUnmodifiableMapView) return _customInsights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customInsights);
  }

  @override
  String toString() {
    return 'AIPatternAnalysis(id: $id, generatedAt: $generatedAt, userId: $userId, identifiedPatterns: $identifiedPatterns, triggersByCategory: $triggersByCategory, timeOfDayDistribution: $timeOfDayDistribution, mostEffectiveStrategies: $mostEffectiveStrategies, leastEffectiveStrategies: $leastEffectiveStrategies, customInsights: $customInsights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIPatternAnalysisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._identifiedPatterns, _identifiedPatterns) &&
            const DeepCollectionEquality()
                .equals(other._triggersByCategory, _triggersByCategory) &&
            const DeepCollectionEquality()
                .equals(other._timeOfDayDistribution, _timeOfDayDistribution) &&
            const DeepCollectionEquality().equals(
                other._mostEffectiveStrategies, _mostEffectiveStrategies) &&
            const DeepCollectionEquality().equals(
                other._leastEffectiveStrategies, _leastEffectiveStrategies) &&
            const DeepCollectionEquality()
                .equals(other._customInsights, _customInsights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      generatedAt,
      userId,
      const DeepCollectionEquality().hash(_identifiedPatterns),
      const DeepCollectionEquality().hash(_triggersByCategory),
      const DeepCollectionEquality().hash(_timeOfDayDistribution),
      const DeepCollectionEquality().hash(_mostEffectiveStrategies),
      const DeepCollectionEquality().hash(_leastEffectiveStrategies),
      const DeepCollectionEquality().hash(_customInsights));

  /// Create a copy of AIPatternAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIPatternAnalysisImplCopyWith<_$AIPatternAnalysisImpl> get copyWith =>
      __$$AIPatternAnalysisImplCopyWithImpl<_$AIPatternAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIPatternAnalysisImplToJson(
      this,
    );
  }
}

abstract class _AIPatternAnalysis implements AIPatternAnalysis {
  const factory _AIPatternAnalysis(
          {required final String id,
          required final DateTime generatedAt,
          required final String userId,
          required final List<Map<String, dynamic>> identifiedPatterns,
          required final Map<String, List<String>> triggersByCategory,
          required final Map<String, double> timeOfDayDistribution,
          required final List<String> mostEffectiveStrategies,
          required final List<String> leastEffectiveStrategies,
          required final Map<String, dynamic> customInsights}) =
      _$AIPatternAnalysisImpl;

  factory _AIPatternAnalysis.fromJson(Map<String, dynamic> json) =
      _$AIPatternAnalysisImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get generatedAt;
  @override
  String get userId;
  @override
  List<Map<String, dynamic>> get identifiedPatterns;
  @override
  Map<String, List<String>> get triggersByCategory;
  @override
  Map<String, double> get timeOfDayDistribution;
  @override
  List<String> get mostEffectiveStrategies;
  @override
  List<String> get leastEffectiveStrategies;
  @override
  Map<String, dynamic> get customInsights;

  /// Create a copy of AIPatternAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIPatternAnalysisImplCopyWith<_$AIPatternAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
