// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthRecoveryTimeline _$HealthRecoveryTimelineFromJson(
    Map<String, dynamic> json) {
  return _HealthRecoveryTimeline.fromJson(json);
}

/// @nodoc
mixin _$HealthRecoveryTimeline {
  String get userId => throw _privateConstructorUsedError;
  List<HealthBenefit> get benefits => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  bool get personalized => throw _privateConstructorUsedError;

  /// Serializes this HealthRecoveryTimeline to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthRecoveryTimeline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthRecoveryTimelineCopyWith<HealthRecoveryTimeline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthRecoveryTimelineCopyWith<$Res> {
  factory $HealthRecoveryTimelineCopyWith(HealthRecoveryTimeline value,
          $Res Function(HealthRecoveryTimeline) then) =
      _$HealthRecoveryTimelineCopyWithImpl<$Res, HealthRecoveryTimeline>;
  @useResult
  $Res call(
      {String userId,
      List<HealthBenefit> benefits,
      DateTime generatedAt,
      bool personalized});
}

/// @nodoc
class _$HealthRecoveryTimelineCopyWithImpl<$Res,
        $Val extends HealthRecoveryTimeline>
    implements $HealthRecoveryTimelineCopyWith<$Res> {
  _$HealthRecoveryTimelineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthRecoveryTimeline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? benefits = null,
    Object? generatedAt = null,
    Object? personalized = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      benefits: null == benefits
          ? _value.benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<HealthBenefit>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      personalized: null == personalized
          ? _value.personalized
          : personalized // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthRecoveryTimelineImplCopyWith<$Res>
    implements $HealthRecoveryTimelineCopyWith<$Res> {
  factory _$$HealthRecoveryTimelineImplCopyWith(
          _$HealthRecoveryTimelineImpl value,
          $Res Function(_$HealthRecoveryTimelineImpl) then) =
      __$$HealthRecoveryTimelineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      List<HealthBenefit> benefits,
      DateTime generatedAt,
      bool personalized});
}

/// @nodoc
class __$$HealthRecoveryTimelineImplCopyWithImpl<$Res>
    extends _$HealthRecoveryTimelineCopyWithImpl<$Res,
        _$HealthRecoveryTimelineImpl>
    implements _$$HealthRecoveryTimelineImplCopyWith<$Res> {
  __$$HealthRecoveryTimelineImplCopyWithImpl(
      _$HealthRecoveryTimelineImpl _value,
      $Res Function(_$HealthRecoveryTimelineImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecoveryTimeline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? benefits = null,
    Object? generatedAt = null,
    Object? personalized = null,
  }) {
    return _then(_$HealthRecoveryTimelineImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      benefits: null == benefits
          ? _value._benefits
          : benefits // ignore: cast_nullable_to_non_nullable
              as List<HealthBenefit>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      personalized: null == personalized
          ? _value.personalized
          : personalized // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthRecoveryTimelineImpl implements _HealthRecoveryTimeline {
  const _$HealthRecoveryTimelineImpl(
      {required this.userId,
      required final List<HealthBenefit> benefits,
      required this.generatedAt,
      this.personalized = false})
      : _benefits = benefits;

  factory _$HealthRecoveryTimelineImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthRecoveryTimelineImplFromJson(json);

  @override
  final String userId;
  final List<HealthBenefit> _benefits;
  @override
  List<HealthBenefit> get benefits {
    if (_benefits is EqualUnmodifiableListView) return _benefits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_benefits);
  }

  @override
  final DateTime generatedAt;
  @override
  @JsonKey()
  final bool personalized;

  @override
  String toString() {
    return 'HealthRecoveryTimeline(userId: $userId, benefits: $benefits, generatedAt: $generatedAt, personalized: $personalized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthRecoveryTimelineImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._benefits, _benefits) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.personalized, personalized) ||
                other.personalized == personalized));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      const DeepCollectionEquality().hash(_benefits),
      generatedAt,
      personalized);

  /// Create a copy of HealthRecoveryTimeline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthRecoveryTimelineImplCopyWith<_$HealthRecoveryTimelineImpl>
      get copyWith => __$$HealthRecoveryTimelineImplCopyWithImpl<
          _$HealthRecoveryTimelineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthRecoveryTimelineImplToJson(
      this,
    );
  }
}

abstract class _HealthRecoveryTimeline implements HealthRecoveryTimeline {
  const factory _HealthRecoveryTimeline(
      {required final String userId,
      required final List<HealthBenefit> benefits,
      required final DateTime generatedAt,
      final bool personalized}) = _$HealthRecoveryTimelineImpl;

  factory _HealthRecoveryTimeline.fromJson(Map<String, dynamic> json) =
      _$HealthRecoveryTimelineImpl.fromJson;

  @override
  String get userId;
  @override
  List<HealthBenefit> get benefits;
  @override
  DateTime get generatedAt;
  @override
  bool get personalized;

  /// Create a copy of HealthRecoveryTimeline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthRecoveryTimelineImplCopyWith<_$HealthRecoveryTimelineImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HealthBenefit _$HealthBenefitFromJson(Map<String, dynamic> json) {
  return _HealthBenefit.fromJson(json);
}

/// @nodoc
mixin _$HealthBenefit {
  String get timeDescription => throw _privateConstructorUsedError;
  String get benefitDescription => throw _privateConstructorUsedError;
  HealthBenefitStage get stage => throw _privateConstructorUsedError;
  double get confidenceLevel => throw _privateConstructorUsedError;
  List<String> get personalizationFactors => throw _privateConstructorUsedError;
  bool get achieved => throw _privateConstructorUsedError;
  String? get personalizedMessage => throw _privateConstructorUsedError;

  /// Serializes this HealthBenefit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthBenefit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthBenefitCopyWith<HealthBenefit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthBenefitCopyWith<$Res> {
  factory $HealthBenefitCopyWith(
          HealthBenefit value, $Res Function(HealthBenefit) then) =
      _$HealthBenefitCopyWithImpl<$Res, HealthBenefit>;
  @useResult
  $Res call(
      {String timeDescription,
      String benefitDescription,
      HealthBenefitStage stage,
      double confidenceLevel,
      List<String> personalizationFactors,
      bool achieved,
      String? personalizedMessage});
}

/// @nodoc
class _$HealthBenefitCopyWithImpl<$Res, $Val extends HealthBenefit>
    implements $HealthBenefitCopyWith<$Res> {
  _$HealthBenefitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthBenefit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeDescription = null,
    Object? benefitDescription = null,
    Object? stage = null,
    Object? confidenceLevel = null,
    Object? personalizationFactors = null,
    Object? achieved = null,
    Object? personalizedMessage = freezed,
  }) {
    return _then(_value.copyWith(
      timeDescription: null == timeDescription
          ? _value.timeDescription
          : timeDescription // ignore: cast_nullable_to_non_nullable
              as String,
      benefitDescription: null == benefitDescription
          ? _value.benefitDescription
          : benefitDescription // ignore: cast_nullable_to_non_nullable
              as String,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as HealthBenefitStage,
      confidenceLevel: null == confidenceLevel
          ? _value.confidenceLevel
          : confidenceLevel // ignore: cast_nullable_to_non_nullable
              as double,
      personalizationFactors: null == personalizationFactors
          ? _value.personalizationFactors
          : personalizationFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      personalizedMessage: freezed == personalizedMessage
          ? _value.personalizedMessage
          : personalizedMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthBenefitImplCopyWith<$Res>
    implements $HealthBenefitCopyWith<$Res> {
  factory _$$HealthBenefitImplCopyWith(
          _$HealthBenefitImpl value, $Res Function(_$HealthBenefitImpl) then) =
      __$$HealthBenefitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String timeDescription,
      String benefitDescription,
      HealthBenefitStage stage,
      double confidenceLevel,
      List<String> personalizationFactors,
      bool achieved,
      String? personalizedMessage});
}

/// @nodoc
class __$$HealthBenefitImplCopyWithImpl<$Res>
    extends _$HealthBenefitCopyWithImpl<$Res, _$HealthBenefitImpl>
    implements _$$HealthBenefitImplCopyWith<$Res> {
  __$$HealthBenefitImplCopyWithImpl(
      _$HealthBenefitImpl _value, $Res Function(_$HealthBenefitImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthBenefit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeDescription = null,
    Object? benefitDescription = null,
    Object? stage = null,
    Object? confidenceLevel = null,
    Object? personalizationFactors = null,
    Object? achieved = null,
    Object? personalizedMessage = freezed,
  }) {
    return _then(_$HealthBenefitImpl(
      timeDescription: null == timeDescription
          ? _value.timeDescription
          : timeDescription // ignore: cast_nullable_to_non_nullable
              as String,
      benefitDescription: null == benefitDescription
          ? _value.benefitDescription
          : benefitDescription // ignore: cast_nullable_to_non_nullable
              as String,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as HealthBenefitStage,
      confidenceLevel: null == confidenceLevel
          ? _value.confidenceLevel
          : confidenceLevel // ignore: cast_nullable_to_non_nullable
              as double,
      personalizationFactors: null == personalizationFactors
          ? _value._personalizationFactors
          : personalizationFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      personalizedMessage: freezed == personalizedMessage
          ? _value.personalizedMessage
          : personalizedMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthBenefitImpl implements _HealthBenefit {
  const _$HealthBenefitImpl(
      {required this.timeDescription,
      required this.benefitDescription,
      required this.stage,
      this.confidenceLevel = 1.0,
      final List<String> personalizationFactors = const [],
      this.achieved = false,
      this.personalizedMessage})
      : _personalizationFactors = personalizationFactors;

  factory _$HealthBenefitImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthBenefitImplFromJson(json);

  @override
  final String timeDescription;
  @override
  final String benefitDescription;
  @override
  final HealthBenefitStage stage;
  @override
  @JsonKey()
  final double confidenceLevel;
  final List<String> _personalizationFactors;
  @override
  @JsonKey()
  List<String> get personalizationFactors {
    if (_personalizationFactors is EqualUnmodifiableListView)
      return _personalizationFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_personalizationFactors);
  }

  @override
  @JsonKey()
  final bool achieved;
  @override
  final String? personalizedMessage;

  @override
  String toString() {
    return 'HealthBenefit(timeDescription: $timeDescription, benefitDescription: $benefitDescription, stage: $stage, confidenceLevel: $confidenceLevel, personalizationFactors: $personalizationFactors, achieved: $achieved, personalizedMessage: $personalizedMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthBenefitImpl &&
            (identical(other.timeDescription, timeDescription) ||
                other.timeDescription == timeDescription) &&
            (identical(other.benefitDescription, benefitDescription) ||
                other.benefitDescription == benefitDescription) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.confidenceLevel, confidenceLevel) ||
                other.confidenceLevel == confidenceLevel) &&
            const DeepCollectionEquality().equals(
                other._personalizationFactors, _personalizationFactors) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.personalizedMessage, personalizedMessage) ||
                other.personalizedMessage == personalizedMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      timeDescription,
      benefitDescription,
      stage,
      confidenceLevel,
      const DeepCollectionEquality().hash(_personalizationFactors),
      achieved,
      personalizedMessage);

  /// Create a copy of HealthBenefit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthBenefitImplCopyWith<_$HealthBenefitImpl> get copyWith =>
      __$$HealthBenefitImplCopyWithImpl<_$HealthBenefitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthBenefitImplToJson(
      this,
    );
  }
}

abstract class _HealthBenefit implements HealthBenefit {
  const factory _HealthBenefit(
      {required final String timeDescription,
      required final String benefitDescription,
      required final HealthBenefitStage stage,
      final double confidenceLevel,
      final List<String> personalizationFactors,
      final bool achieved,
      final String? personalizedMessage}) = _$HealthBenefitImpl;

  factory _HealthBenefit.fromJson(Map<String, dynamic> json) =
      _$HealthBenefitImpl.fromJson;

  @override
  String get timeDescription;
  @override
  String get benefitDescription;
  @override
  HealthBenefitStage get stage;
  @override
  double get confidenceLevel;
  @override
  List<String> get personalizationFactors;
  @override
  bool get achieved;
  @override
  String? get personalizedMessage;

  /// Create a copy of HealthBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthBenefitImplCopyWith<_$HealthBenefitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserHealthProfile _$UserHealthProfileFromJson(Map<String, dynamic> json) {
  return _UserHealthProfile.fromJson(json);
}

/// @nodoc
mixin _$UserHealthProfile {
  String get userId => throw _privateConstructorUsedError;
  DateTime get quitDate => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  int get vapingDurationMonths => throw _privateConstructorUsedError;
  String get dailyUsageLevel =>
      throw _privateConstructorUsedError; // low, medium, high
  List<String> get healthConditions => throw _privateConstructorUsedError;
  String get fitnessLevel => throw _privateConstructorUsedError;

  /// Serializes this UserHealthProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserHealthProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserHealthProfileCopyWith<UserHealthProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserHealthProfileCopyWith<$Res> {
  factory $UserHealthProfileCopyWith(
          UserHealthProfile value, $Res Function(UserHealthProfile) then) =
      _$UserHealthProfileCopyWithImpl<$Res, UserHealthProfile>;
  @useResult
  $Res call(
      {String userId,
      DateTime quitDate,
      int age,
      int vapingDurationMonths,
      String dailyUsageLevel,
      List<String> healthConditions,
      String fitnessLevel});
}

/// @nodoc
class _$UserHealthProfileCopyWithImpl<$Res, $Val extends UserHealthProfile>
    implements $UserHealthProfileCopyWith<$Res> {
  _$UserHealthProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserHealthProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? quitDate = null,
    Object? age = null,
    Object? vapingDurationMonths = null,
    Object? dailyUsageLevel = null,
    Object? healthConditions = null,
    Object? fitnessLevel = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      quitDate: null == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      vapingDurationMonths: null == vapingDurationMonths
          ? _value.vapingDurationMonths
          : vapingDurationMonths // ignore: cast_nullable_to_non_nullable
              as int,
      dailyUsageLevel: null == dailyUsageLevel
          ? _value.dailyUsageLevel
          : dailyUsageLevel // ignore: cast_nullable_to_non_nullable
              as String,
      healthConditions: null == healthConditions
          ? _value.healthConditions
          : healthConditions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fitnessLevel: null == fitnessLevel
          ? _value.fitnessLevel
          : fitnessLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserHealthProfileImplCopyWith<$Res>
    implements $UserHealthProfileCopyWith<$Res> {
  factory _$$UserHealthProfileImplCopyWith(_$UserHealthProfileImpl value,
          $Res Function(_$UserHealthProfileImpl) then) =
      __$$UserHealthProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime quitDate,
      int age,
      int vapingDurationMonths,
      String dailyUsageLevel,
      List<String> healthConditions,
      String fitnessLevel});
}

/// @nodoc
class __$$UserHealthProfileImplCopyWithImpl<$Res>
    extends _$UserHealthProfileCopyWithImpl<$Res, _$UserHealthProfileImpl>
    implements _$$UserHealthProfileImplCopyWith<$Res> {
  __$$UserHealthProfileImplCopyWithImpl(_$UserHealthProfileImpl _value,
      $Res Function(_$UserHealthProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserHealthProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? quitDate = null,
    Object? age = null,
    Object? vapingDurationMonths = null,
    Object? dailyUsageLevel = null,
    Object? healthConditions = null,
    Object? fitnessLevel = null,
  }) {
    return _then(_$UserHealthProfileImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      quitDate: null == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      vapingDurationMonths: null == vapingDurationMonths
          ? _value.vapingDurationMonths
          : vapingDurationMonths // ignore: cast_nullable_to_non_nullable
              as int,
      dailyUsageLevel: null == dailyUsageLevel
          ? _value.dailyUsageLevel
          : dailyUsageLevel // ignore: cast_nullable_to_non_nullable
              as String,
      healthConditions: null == healthConditions
          ? _value._healthConditions
          : healthConditions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fitnessLevel: null == fitnessLevel
          ? _value.fitnessLevel
          : fitnessLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserHealthProfileImpl implements _UserHealthProfile {
  const _$UserHealthProfileImpl(
      {required this.userId,
      required this.quitDate,
      required this.age,
      required this.vapingDurationMonths,
      required this.dailyUsageLevel,
      final List<String> healthConditions = const [],
      this.fitnessLevel = 'fair'})
      : _healthConditions = healthConditions;

  factory _$UserHealthProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserHealthProfileImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime quitDate;
  @override
  final int age;
  @override
  final int vapingDurationMonths;
  @override
  final String dailyUsageLevel;
// low, medium, high
  final List<String> _healthConditions;
// low, medium, high
  @override
  @JsonKey()
  List<String> get healthConditions {
    if (_healthConditions is EqualUnmodifiableListView)
      return _healthConditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_healthConditions);
  }

  @override
  @JsonKey()
  final String fitnessLevel;

  @override
  String toString() {
    return 'UserHealthProfile(userId: $userId, quitDate: $quitDate, age: $age, vapingDurationMonths: $vapingDurationMonths, dailyUsageLevel: $dailyUsageLevel, healthConditions: $healthConditions, fitnessLevel: $fitnessLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserHealthProfileImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.quitDate, quitDate) ||
                other.quitDate == quitDate) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.vapingDurationMonths, vapingDurationMonths) ||
                other.vapingDurationMonths == vapingDurationMonths) &&
            (identical(other.dailyUsageLevel, dailyUsageLevel) ||
                other.dailyUsageLevel == dailyUsageLevel) &&
            const DeepCollectionEquality()
                .equals(other._healthConditions, _healthConditions) &&
            (identical(other.fitnessLevel, fitnessLevel) ||
                other.fitnessLevel == fitnessLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      quitDate,
      age,
      vapingDurationMonths,
      dailyUsageLevel,
      const DeepCollectionEquality().hash(_healthConditions),
      fitnessLevel);

  /// Create a copy of UserHealthProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserHealthProfileImplCopyWith<_$UserHealthProfileImpl> get copyWith =>
      __$$UserHealthProfileImplCopyWithImpl<_$UserHealthProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserHealthProfileImplToJson(
      this,
    );
  }
}

abstract class _UserHealthProfile implements UserHealthProfile {
  const factory _UserHealthProfile(
      {required final String userId,
      required final DateTime quitDate,
      required final int age,
      required final int vapingDurationMonths,
      required final String dailyUsageLevel,
      final List<String> healthConditions,
      final String fitnessLevel}) = _$UserHealthProfileImpl;

  factory _UserHealthProfile.fromJson(Map<String, dynamic> json) =
      _$UserHealthProfileImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get quitDate;
  @override
  int get age;
  @override
  int get vapingDurationMonths;
  @override
  String get dailyUsageLevel; // low, medium, high
  @override
  List<String> get healthConditions;
  @override
  String get fitnessLevel;

  /// Create a copy of UserHealthProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserHealthProfileImplCopyWith<_$UserHealthProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTProtocol _$NRTProtocolFromJson(Map<String, dynamic> json) {
  return _NRTProtocol.fromJson(json);
}

/// @nodoc
mixin _$NRTProtocol {
  String get recommendedNrtType => throw _privateConstructorUsedError;
  List<NRTDosageSchedule> get dosageSchedule =>
      throw _privateConstructorUsedError;
  int get durationWeeks => throw _privateConstructorUsedError;
  List<String> get monitoringSchedule => throw _privateConstructorUsedError;
  List<String> get successIndicators => throw _privateConstructorUsedError;
  List<String> get safetyWarnings => throw _privateConstructorUsedError;

  /// Serializes this NRTProtocol to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTProtocol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTProtocolCopyWith<NRTProtocol> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTProtocolCopyWith<$Res> {
  factory $NRTProtocolCopyWith(
          NRTProtocol value, $Res Function(NRTProtocol) then) =
      _$NRTProtocolCopyWithImpl<$Res, NRTProtocol>;
  @useResult
  $Res call(
      {String recommendedNrtType,
      List<NRTDosageSchedule> dosageSchedule,
      int durationWeeks,
      List<String> monitoringSchedule,
      List<String> successIndicators,
      List<String> safetyWarnings});
}

/// @nodoc
class _$NRTProtocolCopyWithImpl<$Res, $Val extends NRTProtocol>
    implements $NRTProtocolCopyWith<$Res> {
  _$NRTProtocolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTProtocol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendedNrtType = null,
    Object? dosageSchedule = null,
    Object? durationWeeks = null,
    Object? monitoringSchedule = null,
    Object? successIndicators = null,
    Object? safetyWarnings = null,
  }) {
    return _then(_value.copyWith(
      recommendedNrtType: null == recommendedNrtType
          ? _value.recommendedNrtType
          : recommendedNrtType // ignore: cast_nullable_to_non_nullable
              as String,
      dosageSchedule: null == dosageSchedule
          ? _value.dosageSchedule
          : dosageSchedule // ignore: cast_nullable_to_non_nullable
              as List<NRTDosageSchedule>,
      durationWeeks: null == durationWeeks
          ? _value.durationWeeks
          : durationWeeks // ignore: cast_nullable_to_non_nullable
              as int,
      monitoringSchedule: null == monitoringSchedule
          ? _value.monitoringSchedule
          : monitoringSchedule // ignore: cast_nullable_to_non_nullable
              as List<String>,
      successIndicators: null == successIndicators
          ? _value.successIndicators
          : successIndicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      safetyWarnings: null == safetyWarnings
          ? _value.safetyWarnings
          : safetyWarnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTProtocolImplCopyWith<$Res>
    implements $NRTProtocolCopyWith<$Res> {
  factory _$$NRTProtocolImplCopyWith(
          _$NRTProtocolImpl value, $Res Function(_$NRTProtocolImpl) then) =
      __$$NRTProtocolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String recommendedNrtType,
      List<NRTDosageSchedule> dosageSchedule,
      int durationWeeks,
      List<String> monitoringSchedule,
      List<String> successIndicators,
      List<String> safetyWarnings});
}

/// @nodoc
class __$$NRTProtocolImplCopyWithImpl<$Res>
    extends _$NRTProtocolCopyWithImpl<$Res, _$NRTProtocolImpl>
    implements _$$NRTProtocolImplCopyWith<$Res> {
  __$$NRTProtocolImplCopyWithImpl(
      _$NRTProtocolImpl _value, $Res Function(_$NRTProtocolImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTProtocol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendedNrtType = null,
    Object? dosageSchedule = null,
    Object? durationWeeks = null,
    Object? monitoringSchedule = null,
    Object? successIndicators = null,
    Object? safetyWarnings = null,
  }) {
    return _then(_$NRTProtocolImpl(
      recommendedNrtType: null == recommendedNrtType
          ? _value.recommendedNrtType
          : recommendedNrtType // ignore: cast_nullable_to_non_nullable
              as String,
      dosageSchedule: null == dosageSchedule
          ? _value._dosageSchedule
          : dosageSchedule // ignore: cast_nullable_to_non_nullable
              as List<NRTDosageSchedule>,
      durationWeeks: null == durationWeeks
          ? _value.durationWeeks
          : durationWeeks // ignore: cast_nullable_to_non_nullable
              as int,
      monitoringSchedule: null == monitoringSchedule
          ? _value._monitoringSchedule
          : monitoringSchedule // ignore: cast_nullable_to_non_nullable
              as List<String>,
      successIndicators: null == successIndicators
          ? _value._successIndicators
          : successIndicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      safetyWarnings: null == safetyWarnings
          ? _value._safetyWarnings
          : safetyWarnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTProtocolImpl implements _NRTProtocol {
  const _$NRTProtocolImpl(
      {required this.recommendedNrtType,
      required final List<NRTDosageSchedule> dosageSchedule,
      required this.durationWeeks,
      required final List<String> monitoringSchedule,
      required final List<String> successIndicators,
      final List<String> safetyWarnings = const []})
      : _dosageSchedule = dosageSchedule,
        _monitoringSchedule = monitoringSchedule,
        _successIndicators = successIndicators,
        _safetyWarnings = safetyWarnings;

  factory _$NRTProtocolImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTProtocolImplFromJson(json);

  @override
  final String recommendedNrtType;
  final List<NRTDosageSchedule> _dosageSchedule;
  @override
  List<NRTDosageSchedule> get dosageSchedule {
    if (_dosageSchedule is EqualUnmodifiableListView) return _dosageSchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dosageSchedule);
  }

  @override
  final int durationWeeks;
  final List<String> _monitoringSchedule;
  @override
  List<String> get monitoringSchedule {
    if (_monitoringSchedule is EqualUnmodifiableListView)
      return _monitoringSchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monitoringSchedule);
  }

  final List<String> _successIndicators;
  @override
  List<String> get successIndicators {
    if (_successIndicators is EqualUnmodifiableListView)
      return _successIndicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successIndicators);
  }

  final List<String> _safetyWarnings;
  @override
  @JsonKey()
  List<String> get safetyWarnings {
    if (_safetyWarnings is EqualUnmodifiableListView) return _safetyWarnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_safetyWarnings);
  }

  @override
  String toString() {
    return 'NRTProtocol(recommendedNrtType: $recommendedNrtType, dosageSchedule: $dosageSchedule, durationWeeks: $durationWeeks, monitoringSchedule: $monitoringSchedule, successIndicators: $successIndicators, safetyWarnings: $safetyWarnings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTProtocolImpl &&
            (identical(other.recommendedNrtType, recommendedNrtType) ||
                other.recommendedNrtType == recommendedNrtType) &&
            const DeepCollectionEquality()
                .equals(other._dosageSchedule, _dosageSchedule) &&
            (identical(other.durationWeeks, durationWeeks) ||
                other.durationWeeks == durationWeeks) &&
            const DeepCollectionEquality()
                .equals(other._monitoringSchedule, _monitoringSchedule) &&
            const DeepCollectionEquality()
                .equals(other._successIndicators, _successIndicators) &&
            const DeepCollectionEquality()
                .equals(other._safetyWarnings, _safetyWarnings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      recommendedNrtType,
      const DeepCollectionEquality().hash(_dosageSchedule),
      durationWeeks,
      const DeepCollectionEquality().hash(_monitoringSchedule),
      const DeepCollectionEquality().hash(_successIndicators),
      const DeepCollectionEquality().hash(_safetyWarnings));

  /// Create a copy of NRTProtocol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTProtocolImplCopyWith<_$NRTProtocolImpl> get copyWith =>
      __$$NRTProtocolImplCopyWithImpl<_$NRTProtocolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTProtocolImplToJson(
      this,
    );
  }
}

abstract class _NRTProtocol implements NRTProtocol {
  const factory _NRTProtocol(
      {required final String recommendedNrtType,
      required final List<NRTDosageSchedule> dosageSchedule,
      required final int durationWeeks,
      required final List<String> monitoringSchedule,
      required final List<String> successIndicators,
      final List<String> safetyWarnings}) = _$NRTProtocolImpl;

  factory _NRTProtocol.fromJson(Map<String, dynamic> json) =
      _$NRTProtocolImpl.fromJson;

  @override
  String get recommendedNrtType;
  @override
  List<NRTDosageSchedule> get dosageSchedule;
  @override
  int get durationWeeks;
  @override
  List<String> get monitoringSchedule;
  @override
  List<String> get successIndicators;
  @override
  List<String> get safetyWarnings;

  /// Create a copy of NRTProtocol
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTProtocolImplCopyWith<_$NRTProtocolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTDosageSchedule _$NRTDosageScheduleFromJson(Map<String, dynamic> json) {
  return _NRTDosageSchedule.fromJson(json);
}

/// @nodoc
mixin _$NRTDosageSchedule {
  String get week => throw _privateConstructorUsedError;
  String get dosage => throw _privateConstructorUsedError;
  String? get additional => throw _privateConstructorUsedError;

  /// Serializes this NRTDosageSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTDosageSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTDosageScheduleCopyWith<NRTDosageSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTDosageScheduleCopyWith<$Res> {
  factory $NRTDosageScheduleCopyWith(
          NRTDosageSchedule value, $Res Function(NRTDosageSchedule) then) =
      _$NRTDosageScheduleCopyWithImpl<$Res, NRTDosageSchedule>;
  @useResult
  $Res call({String week, String dosage, String? additional});
}

/// @nodoc
class _$NRTDosageScheduleCopyWithImpl<$Res, $Val extends NRTDosageSchedule>
    implements $NRTDosageScheduleCopyWith<$Res> {
  _$NRTDosageScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTDosageSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = null,
    Object? dosage = null,
    Object? additional = freezed,
  }) {
    return _then(_value.copyWith(
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      additional: freezed == additional
          ? _value.additional
          : additional // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTDosageScheduleImplCopyWith<$Res>
    implements $NRTDosageScheduleCopyWith<$Res> {
  factory _$$NRTDosageScheduleImplCopyWith(_$NRTDosageScheduleImpl value,
          $Res Function(_$NRTDosageScheduleImpl) then) =
      __$$NRTDosageScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String week, String dosage, String? additional});
}

/// @nodoc
class __$$NRTDosageScheduleImplCopyWithImpl<$Res>
    extends _$NRTDosageScheduleCopyWithImpl<$Res, _$NRTDosageScheduleImpl>
    implements _$$NRTDosageScheduleImplCopyWith<$Res> {
  __$$NRTDosageScheduleImplCopyWithImpl(_$NRTDosageScheduleImpl _value,
      $Res Function(_$NRTDosageScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTDosageSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = null,
    Object? dosage = null,
    Object? additional = freezed,
  }) {
    return _then(_$NRTDosageScheduleImpl(
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      additional: freezed == additional
          ? _value.additional
          : additional // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTDosageScheduleImpl implements _NRTDosageSchedule {
  const _$NRTDosageScheduleImpl(
      {required this.week, required this.dosage, this.additional});

  factory _$NRTDosageScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTDosageScheduleImplFromJson(json);

  @override
  final String week;
  @override
  final String dosage;
  @override
  final String? additional;

  @override
  String toString() {
    return 'NRTDosageSchedule(week: $week, dosage: $dosage, additional: $additional)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTDosageScheduleImpl &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.additional, additional) ||
                other.additional == additional));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, week, dosage, additional);

  /// Create a copy of NRTDosageSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTDosageScheduleImplCopyWith<_$NRTDosageScheduleImpl> get copyWith =>
      __$$NRTDosageScheduleImplCopyWithImpl<_$NRTDosageScheduleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTDosageScheduleImplToJson(
      this,
    );
  }
}

abstract class _NRTDosageSchedule implements NRTDosageSchedule {
  const factory _NRTDosageSchedule(
      {required final String week,
      required final String dosage,
      final String? additional}) = _$NRTDosageScheduleImpl;

  factory _NRTDosageSchedule.fromJson(Map<String, dynamic> json) =
      _$NRTDosageScheduleImpl.fromJson;

  @override
  String get week;
  @override
  String get dosage;
  @override
  String? get additional;

  /// Create a copy of NRTDosageSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTDosageScheduleImplCopyWith<_$NRTDosageScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PersonalizedHealthInsights _$PersonalizedHealthInsightsFromJson(
    Map<String, dynamic> json) {
  return _PersonalizedHealthInsights.fromJson(json);
}

/// @nodoc
mixin _$PersonalizedHealthInsights {
  QuitProgress get quitProgress => throw _privateConstructorUsedError;
  HealthImprovements get healthImprovements =>
      throw _privateConstructorUsedError;
  FinancialSavings get financialSavings => throw _privateConstructorUsedError;
  RiskReductions get riskReductions => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;

  /// Serializes this PersonalizedHealthInsights to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalizedHealthInsightsCopyWith<PersonalizedHealthInsights>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalizedHealthInsightsCopyWith<$Res> {
  factory $PersonalizedHealthInsightsCopyWith(PersonalizedHealthInsights value,
          $Res Function(PersonalizedHealthInsights) then) =
      _$PersonalizedHealthInsightsCopyWithImpl<$Res,
          PersonalizedHealthInsights>;
  @useResult
  $Res call(
      {QuitProgress quitProgress,
      HealthImprovements healthImprovements,
      FinancialSavings financialSavings,
      RiskReductions riskReductions,
      double confidenceScore});

  $QuitProgressCopyWith<$Res> get quitProgress;
  $HealthImprovementsCopyWith<$Res> get healthImprovements;
  $FinancialSavingsCopyWith<$Res> get financialSavings;
  $RiskReductionsCopyWith<$Res> get riskReductions;
}

/// @nodoc
class _$PersonalizedHealthInsightsCopyWithImpl<$Res,
        $Val extends PersonalizedHealthInsights>
    implements $PersonalizedHealthInsightsCopyWith<$Res> {
  _$PersonalizedHealthInsightsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quitProgress = null,
    Object? healthImprovements = null,
    Object? financialSavings = null,
    Object? riskReductions = null,
    Object? confidenceScore = null,
  }) {
    return _then(_value.copyWith(
      quitProgress: null == quitProgress
          ? _value.quitProgress
          : quitProgress // ignore: cast_nullable_to_non_nullable
              as QuitProgress,
      healthImprovements: null == healthImprovements
          ? _value.healthImprovements
          : healthImprovements // ignore: cast_nullable_to_non_nullable
              as HealthImprovements,
      financialSavings: null == financialSavings
          ? _value.financialSavings
          : financialSavings // ignore: cast_nullable_to_non_nullable
              as FinancialSavings,
      riskReductions: null == riskReductions
          ? _value.riskReductions
          : riskReductions // ignore: cast_nullable_to_non_nullable
              as RiskReductions,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuitProgressCopyWith<$Res> get quitProgress {
    return $QuitProgressCopyWith<$Res>(_value.quitProgress, (value) {
      return _then(_value.copyWith(quitProgress: value) as $Val);
    });
  }

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthImprovementsCopyWith<$Res> get healthImprovements {
    return $HealthImprovementsCopyWith<$Res>(_value.healthImprovements,
        (value) {
      return _then(_value.copyWith(healthImprovements: value) as $Val);
    });
  }

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FinancialSavingsCopyWith<$Res> get financialSavings {
    return $FinancialSavingsCopyWith<$Res>(_value.financialSavings, (value) {
      return _then(_value.copyWith(financialSavings: value) as $Val);
    });
  }

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskReductionsCopyWith<$Res> get riskReductions {
    return $RiskReductionsCopyWith<$Res>(_value.riskReductions, (value) {
      return _then(_value.copyWith(riskReductions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PersonalizedHealthInsightsImplCopyWith<$Res>
    implements $PersonalizedHealthInsightsCopyWith<$Res> {
  factory _$$PersonalizedHealthInsightsImplCopyWith(
          _$PersonalizedHealthInsightsImpl value,
          $Res Function(_$PersonalizedHealthInsightsImpl) then) =
      __$$PersonalizedHealthInsightsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QuitProgress quitProgress,
      HealthImprovements healthImprovements,
      FinancialSavings financialSavings,
      RiskReductions riskReductions,
      double confidenceScore});

  @override
  $QuitProgressCopyWith<$Res> get quitProgress;
  @override
  $HealthImprovementsCopyWith<$Res> get healthImprovements;
  @override
  $FinancialSavingsCopyWith<$Res> get financialSavings;
  @override
  $RiskReductionsCopyWith<$Res> get riskReductions;
}

/// @nodoc
class __$$PersonalizedHealthInsightsImplCopyWithImpl<$Res>
    extends _$PersonalizedHealthInsightsCopyWithImpl<$Res,
        _$PersonalizedHealthInsightsImpl>
    implements _$$PersonalizedHealthInsightsImplCopyWith<$Res> {
  __$$PersonalizedHealthInsightsImplCopyWithImpl(
      _$PersonalizedHealthInsightsImpl _value,
      $Res Function(_$PersonalizedHealthInsightsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quitProgress = null,
    Object? healthImprovements = null,
    Object? financialSavings = null,
    Object? riskReductions = null,
    Object? confidenceScore = null,
  }) {
    return _then(_$PersonalizedHealthInsightsImpl(
      quitProgress: null == quitProgress
          ? _value.quitProgress
          : quitProgress // ignore: cast_nullable_to_non_nullable
              as QuitProgress,
      healthImprovements: null == healthImprovements
          ? _value.healthImprovements
          : healthImprovements // ignore: cast_nullable_to_non_nullable
              as HealthImprovements,
      financialSavings: null == financialSavings
          ? _value.financialSavings
          : financialSavings // ignore: cast_nullable_to_non_nullable
              as FinancialSavings,
      riskReductions: null == riskReductions
          ? _value.riskReductions
          : riskReductions // ignore: cast_nullable_to_non_nullable
              as RiskReductions,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalizedHealthInsightsImpl implements _PersonalizedHealthInsights {
  const _$PersonalizedHealthInsightsImpl(
      {required this.quitProgress,
      required this.healthImprovements,
      required this.financialSavings,
      required this.riskReductions,
      this.confidenceScore = 0.8});

  factory _$PersonalizedHealthInsightsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PersonalizedHealthInsightsImplFromJson(json);

  @override
  final QuitProgress quitProgress;
  @override
  final HealthImprovements healthImprovements;
  @override
  final FinancialSavings financialSavings;
  @override
  final RiskReductions riskReductions;
  @override
  @JsonKey()
  final double confidenceScore;

  @override
  String toString() {
    return 'PersonalizedHealthInsights(quitProgress: $quitProgress, healthImprovements: $healthImprovements, financialSavings: $financialSavings, riskReductions: $riskReductions, confidenceScore: $confidenceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalizedHealthInsightsImpl &&
            (identical(other.quitProgress, quitProgress) ||
                other.quitProgress == quitProgress) &&
            (identical(other.healthImprovements, healthImprovements) ||
                other.healthImprovements == healthImprovements) &&
            (identical(other.financialSavings, financialSavings) ||
                other.financialSavings == financialSavings) &&
            (identical(other.riskReductions, riskReductions) ||
                other.riskReductions == riskReductions) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quitProgress, healthImprovements,
      financialSavings, riskReductions, confidenceScore);

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalizedHealthInsightsImplCopyWith<_$PersonalizedHealthInsightsImpl>
      get copyWith => __$$PersonalizedHealthInsightsImplCopyWithImpl<
          _$PersonalizedHealthInsightsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalizedHealthInsightsImplToJson(
      this,
    );
  }
}

abstract class _PersonalizedHealthInsights
    implements PersonalizedHealthInsights {
  const factory _PersonalizedHealthInsights(
      {required final QuitProgress quitProgress,
      required final HealthImprovements healthImprovements,
      required final FinancialSavings financialSavings,
      required final RiskReductions riskReductions,
      final double confidenceScore}) = _$PersonalizedHealthInsightsImpl;

  factory _PersonalizedHealthInsights.fromJson(Map<String, dynamic> json) =
      _$PersonalizedHealthInsightsImpl.fromJson;

  @override
  QuitProgress get quitProgress;
  @override
  HealthImprovements get healthImprovements;
  @override
  FinancialSavings get financialSavings;
  @override
  RiskReductions get riskReductions;
  @override
  double get confidenceScore;

  /// Create a copy of PersonalizedHealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalizedHealthInsightsImplCopyWith<_$PersonalizedHealthInsightsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuitProgress _$QuitProgressFromJson(Map<String, dynamic> json) {
  return _QuitProgress.fromJson(json);
}

/// @nodoc
mixin _$QuitProgress {
  int get daysQuit => throw _privateConstructorUsedError;
  double get percentageComplete => throw _privateConstructorUsedError;
  HealthMilestone get nextMilestone => throw _privateConstructorUsedError;

  /// Serializes this QuitProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuitProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuitProgressCopyWith<QuitProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuitProgressCopyWith<$Res> {
  factory $QuitProgressCopyWith(
          QuitProgress value, $Res Function(QuitProgress) then) =
      _$QuitProgressCopyWithImpl<$Res, QuitProgress>;
  @useResult
  $Res call(
      {int daysQuit, double percentageComplete, HealthMilestone nextMilestone});

  $HealthMilestoneCopyWith<$Res> get nextMilestone;
}

/// @nodoc
class _$QuitProgressCopyWithImpl<$Res, $Val extends QuitProgress>
    implements $QuitProgressCopyWith<$Res> {
  _$QuitProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuitProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysQuit = null,
    Object? percentageComplete = null,
    Object? nextMilestone = null,
  }) {
    return _then(_value.copyWith(
      daysQuit: null == daysQuit
          ? _value.daysQuit
          : daysQuit // ignore: cast_nullable_to_non_nullable
              as int,
      percentageComplete: null == percentageComplete
          ? _value.percentageComplete
          : percentageComplete // ignore: cast_nullable_to_non_nullable
              as double,
      nextMilestone: null == nextMilestone
          ? _value.nextMilestone
          : nextMilestone // ignore: cast_nullable_to_non_nullable
              as HealthMilestone,
    ) as $Val);
  }

  /// Create a copy of QuitProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthMilestoneCopyWith<$Res> get nextMilestone {
    return $HealthMilestoneCopyWith<$Res>(_value.nextMilestone, (value) {
      return _then(_value.copyWith(nextMilestone: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuitProgressImplCopyWith<$Res>
    implements $QuitProgressCopyWith<$Res> {
  factory _$$QuitProgressImplCopyWith(
          _$QuitProgressImpl value, $Res Function(_$QuitProgressImpl) then) =
      __$$QuitProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int daysQuit, double percentageComplete, HealthMilestone nextMilestone});

  @override
  $HealthMilestoneCopyWith<$Res> get nextMilestone;
}

/// @nodoc
class __$$QuitProgressImplCopyWithImpl<$Res>
    extends _$QuitProgressCopyWithImpl<$Res, _$QuitProgressImpl>
    implements _$$QuitProgressImplCopyWith<$Res> {
  __$$QuitProgressImplCopyWithImpl(
      _$QuitProgressImpl _value, $Res Function(_$QuitProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuitProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysQuit = null,
    Object? percentageComplete = null,
    Object? nextMilestone = null,
  }) {
    return _then(_$QuitProgressImpl(
      daysQuit: null == daysQuit
          ? _value.daysQuit
          : daysQuit // ignore: cast_nullable_to_non_nullable
              as int,
      percentageComplete: null == percentageComplete
          ? _value.percentageComplete
          : percentageComplete // ignore: cast_nullable_to_non_nullable
              as double,
      nextMilestone: null == nextMilestone
          ? _value.nextMilestone
          : nextMilestone // ignore: cast_nullable_to_non_nullable
              as HealthMilestone,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuitProgressImpl implements _QuitProgress {
  const _$QuitProgressImpl(
      {required this.daysQuit,
      required this.percentageComplete,
      required this.nextMilestone});

  factory _$QuitProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuitProgressImplFromJson(json);

  @override
  final int daysQuit;
  @override
  final double percentageComplete;
  @override
  final HealthMilestone nextMilestone;

  @override
  String toString() {
    return 'QuitProgress(daysQuit: $daysQuit, percentageComplete: $percentageComplete, nextMilestone: $nextMilestone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuitProgressImpl &&
            (identical(other.daysQuit, daysQuit) ||
                other.daysQuit == daysQuit) &&
            (identical(other.percentageComplete, percentageComplete) ||
                other.percentageComplete == percentageComplete) &&
            (identical(other.nextMilestone, nextMilestone) ||
                other.nextMilestone == nextMilestone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, daysQuit, percentageComplete, nextMilestone);

  /// Create a copy of QuitProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuitProgressImplCopyWith<_$QuitProgressImpl> get copyWith =>
      __$$QuitProgressImplCopyWithImpl<_$QuitProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuitProgressImplToJson(
      this,
    );
  }
}

abstract class _QuitProgress implements QuitProgress {
  const factory _QuitProgress(
      {required final int daysQuit,
      required final double percentageComplete,
      required final HealthMilestone nextMilestone}) = _$QuitProgressImpl;

  factory _QuitProgress.fromJson(Map<String, dynamic> json) =
      _$QuitProgressImpl.fromJson;

  @override
  int get daysQuit;
  @override
  double get percentageComplete;
  @override
  HealthMilestone get nextMilestone;

  /// Create a copy of QuitProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuitProgressImplCopyWith<_$QuitProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthImprovements _$HealthImprovementsFromJson(Map<String, dynamic> json) {
  return _HealthImprovements.fromJson(json);
}

/// @nodoc
mixin _$HealthImprovements {
  double get lungCapacityImprovement => throw _privateConstructorUsedError;
  double get circulationImprovement => throw _privateConstructorUsedError;
  double get tasteSmellRecovery => throw _privateConstructorUsedError;
  double get energyLevelIncrease => throw _privateConstructorUsedError;
  double get heartRateImprovement => throw _privateConstructorUsedError;
  double get bloodPressureImprovement => throw _privateConstructorUsedError;

  /// Serializes this HealthImprovements to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthImprovements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthImprovementsCopyWith<HealthImprovements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthImprovementsCopyWith<$Res> {
  factory $HealthImprovementsCopyWith(
          HealthImprovements value, $Res Function(HealthImprovements) then) =
      _$HealthImprovementsCopyWithImpl<$Res, HealthImprovements>;
  @useResult
  $Res call(
      {double lungCapacityImprovement,
      double circulationImprovement,
      double tasteSmellRecovery,
      double energyLevelIncrease,
      double heartRateImprovement,
      double bloodPressureImprovement});
}

/// @nodoc
class _$HealthImprovementsCopyWithImpl<$Res, $Val extends HealthImprovements>
    implements $HealthImprovementsCopyWith<$Res> {
  _$HealthImprovementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthImprovements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lungCapacityImprovement = null,
    Object? circulationImprovement = null,
    Object? tasteSmellRecovery = null,
    Object? energyLevelIncrease = null,
    Object? heartRateImprovement = null,
    Object? bloodPressureImprovement = null,
  }) {
    return _then(_value.copyWith(
      lungCapacityImprovement: null == lungCapacityImprovement
          ? _value.lungCapacityImprovement
          : lungCapacityImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      circulationImprovement: null == circulationImprovement
          ? _value.circulationImprovement
          : circulationImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      tasteSmellRecovery: null == tasteSmellRecovery
          ? _value.tasteSmellRecovery
          : tasteSmellRecovery // ignore: cast_nullable_to_non_nullable
              as double,
      energyLevelIncrease: null == energyLevelIncrease
          ? _value.energyLevelIncrease
          : energyLevelIncrease // ignore: cast_nullable_to_non_nullable
              as double,
      heartRateImprovement: null == heartRateImprovement
          ? _value.heartRateImprovement
          : heartRateImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      bloodPressureImprovement: null == bloodPressureImprovement
          ? _value.bloodPressureImprovement
          : bloodPressureImprovement // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthImprovementsImplCopyWith<$Res>
    implements $HealthImprovementsCopyWith<$Res> {
  factory _$$HealthImprovementsImplCopyWith(_$HealthImprovementsImpl value,
          $Res Function(_$HealthImprovementsImpl) then) =
      __$$HealthImprovementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double lungCapacityImprovement,
      double circulationImprovement,
      double tasteSmellRecovery,
      double energyLevelIncrease,
      double heartRateImprovement,
      double bloodPressureImprovement});
}

/// @nodoc
class __$$HealthImprovementsImplCopyWithImpl<$Res>
    extends _$HealthImprovementsCopyWithImpl<$Res, _$HealthImprovementsImpl>
    implements _$$HealthImprovementsImplCopyWith<$Res> {
  __$$HealthImprovementsImplCopyWithImpl(_$HealthImprovementsImpl _value,
      $Res Function(_$HealthImprovementsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthImprovements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lungCapacityImprovement = null,
    Object? circulationImprovement = null,
    Object? tasteSmellRecovery = null,
    Object? energyLevelIncrease = null,
    Object? heartRateImprovement = null,
    Object? bloodPressureImprovement = null,
  }) {
    return _then(_$HealthImprovementsImpl(
      lungCapacityImprovement: null == lungCapacityImprovement
          ? _value.lungCapacityImprovement
          : lungCapacityImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      circulationImprovement: null == circulationImprovement
          ? _value.circulationImprovement
          : circulationImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      tasteSmellRecovery: null == tasteSmellRecovery
          ? _value.tasteSmellRecovery
          : tasteSmellRecovery // ignore: cast_nullable_to_non_nullable
              as double,
      energyLevelIncrease: null == energyLevelIncrease
          ? _value.energyLevelIncrease
          : energyLevelIncrease // ignore: cast_nullable_to_non_nullable
              as double,
      heartRateImprovement: null == heartRateImprovement
          ? _value.heartRateImprovement
          : heartRateImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      bloodPressureImprovement: null == bloodPressureImprovement
          ? _value.bloodPressureImprovement
          : bloodPressureImprovement // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthImprovementsImpl implements _HealthImprovements {
  const _$HealthImprovementsImpl(
      {this.lungCapacityImprovement = 0.0,
      this.circulationImprovement = 0.0,
      this.tasteSmellRecovery = 0.0,
      this.energyLevelIncrease = 0.0,
      this.heartRateImprovement = 0.0,
      this.bloodPressureImprovement = 0.0});

  factory _$HealthImprovementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthImprovementsImplFromJson(json);

  @override
  @JsonKey()
  final double lungCapacityImprovement;
  @override
  @JsonKey()
  final double circulationImprovement;
  @override
  @JsonKey()
  final double tasteSmellRecovery;
  @override
  @JsonKey()
  final double energyLevelIncrease;
  @override
  @JsonKey()
  final double heartRateImprovement;
  @override
  @JsonKey()
  final double bloodPressureImprovement;

  @override
  String toString() {
    return 'HealthImprovements(lungCapacityImprovement: $lungCapacityImprovement, circulationImprovement: $circulationImprovement, tasteSmellRecovery: $tasteSmellRecovery, energyLevelIncrease: $energyLevelIncrease, heartRateImprovement: $heartRateImprovement, bloodPressureImprovement: $bloodPressureImprovement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthImprovementsImpl &&
            (identical(
                    other.lungCapacityImprovement, lungCapacityImprovement) ||
                other.lungCapacityImprovement == lungCapacityImprovement) &&
            (identical(other.circulationImprovement, circulationImprovement) ||
                other.circulationImprovement == circulationImprovement) &&
            (identical(other.tasteSmellRecovery, tasteSmellRecovery) ||
                other.tasteSmellRecovery == tasteSmellRecovery) &&
            (identical(other.energyLevelIncrease, energyLevelIncrease) ||
                other.energyLevelIncrease == energyLevelIncrease) &&
            (identical(other.heartRateImprovement, heartRateImprovement) ||
                other.heartRateImprovement == heartRateImprovement) &&
            (identical(
                    other.bloodPressureImprovement, bloodPressureImprovement) ||
                other.bloodPressureImprovement == bloodPressureImprovement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lungCapacityImprovement,
      circulationImprovement,
      tasteSmellRecovery,
      energyLevelIncrease,
      heartRateImprovement,
      bloodPressureImprovement);

  /// Create a copy of HealthImprovements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthImprovementsImplCopyWith<_$HealthImprovementsImpl> get copyWith =>
      __$$HealthImprovementsImplCopyWithImpl<_$HealthImprovementsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthImprovementsImplToJson(
      this,
    );
  }
}

abstract class _HealthImprovements implements HealthImprovements {
  const factory _HealthImprovements(
      {final double lungCapacityImprovement,
      final double circulationImprovement,
      final double tasteSmellRecovery,
      final double energyLevelIncrease,
      final double heartRateImprovement,
      final double bloodPressureImprovement}) = _$HealthImprovementsImpl;

  factory _HealthImprovements.fromJson(Map<String, dynamic> json) =
      _$HealthImprovementsImpl.fromJson;

  @override
  double get lungCapacityImprovement;
  @override
  double get circulationImprovement;
  @override
  double get tasteSmellRecovery;
  @override
  double get energyLevelIncrease;
  @override
  double get heartRateImprovement;
  @override
  double get bloodPressureImprovement;

  /// Create a copy of HealthImprovements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthImprovementsImplCopyWith<_$HealthImprovementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FinancialSavings _$FinancialSavingsFromJson(Map<String, dynamic> json) {
  return _FinancialSavings.fromJson(json);
}

/// @nodoc
mixin _$FinancialSavings {
  double get totalSaved => throw _privateConstructorUsedError;
  double get dailySavings => throw _privateConstructorUsedError;
  double get weeklySavings => throw _privateConstructorUsedError;
  double get monthlySavings => throw _privateConstructorUsedError;
  double get yearlySavings => throw _privateConstructorUsedError;
  int get daysQuit => throw _privateConstructorUsedError;

  /// Serializes this FinancialSavings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinancialSavings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialSavingsCopyWith<FinancialSavings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialSavingsCopyWith<$Res> {
  factory $FinancialSavingsCopyWith(
          FinancialSavings value, $Res Function(FinancialSavings) then) =
      _$FinancialSavingsCopyWithImpl<$Res, FinancialSavings>;
  @useResult
  $Res call(
      {double totalSaved,
      double dailySavings,
      double weeklySavings,
      double monthlySavings,
      double yearlySavings,
      int daysQuit});
}

/// @nodoc
class _$FinancialSavingsCopyWithImpl<$Res, $Val extends FinancialSavings>
    implements $FinancialSavingsCopyWith<$Res> {
  _$FinancialSavingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialSavings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSaved = null,
    Object? dailySavings = null,
    Object? weeklySavings = null,
    Object? monthlySavings = null,
    Object? yearlySavings = null,
    Object? daysQuit = null,
  }) {
    return _then(_value.copyWith(
      totalSaved: null == totalSaved
          ? _value.totalSaved
          : totalSaved // ignore: cast_nullable_to_non_nullable
              as double,
      dailySavings: null == dailySavings
          ? _value.dailySavings
          : dailySavings // ignore: cast_nullable_to_non_nullable
              as double,
      weeklySavings: null == weeklySavings
          ? _value.weeklySavings
          : weeklySavings // ignore: cast_nullable_to_non_nullable
              as double,
      monthlySavings: null == monthlySavings
          ? _value.monthlySavings
          : monthlySavings // ignore: cast_nullable_to_non_nullable
              as double,
      yearlySavings: null == yearlySavings
          ? _value.yearlySavings
          : yearlySavings // ignore: cast_nullable_to_non_nullable
              as double,
      daysQuit: null == daysQuit
          ? _value.daysQuit
          : daysQuit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialSavingsImplCopyWith<$Res>
    implements $FinancialSavingsCopyWith<$Res> {
  factory _$$FinancialSavingsImplCopyWith(_$FinancialSavingsImpl value,
          $Res Function(_$FinancialSavingsImpl) then) =
      __$$FinancialSavingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalSaved,
      double dailySavings,
      double weeklySavings,
      double monthlySavings,
      double yearlySavings,
      int daysQuit});
}

/// @nodoc
class __$$FinancialSavingsImplCopyWithImpl<$Res>
    extends _$FinancialSavingsCopyWithImpl<$Res, _$FinancialSavingsImpl>
    implements _$$FinancialSavingsImplCopyWith<$Res> {
  __$$FinancialSavingsImplCopyWithImpl(_$FinancialSavingsImpl _value,
      $Res Function(_$FinancialSavingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialSavings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSaved = null,
    Object? dailySavings = null,
    Object? weeklySavings = null,
    Object? monthlySavings = null,
    Object? yearlySavings = null,
    Object? daysQuit = null,
  }) {
    return _then(_$FinancialSavingsImpl(
      totalSaved: null == totalSaved
          ? _value.totalSaved
          : totalSaved // ignore: cast_nullable_to_non_nullable
              as double,
      dailySavings: null == dailySavings
          ? _value.dailySavings
          : dailySavings // ignore: cast_nullable_to_non_nullable
              as double,
      weeklySavings: null == weeklySavings
          ? _value.weeklySavings
          : weeklySavings // ignore: cast_nullable_to_non_nullable
              as double,
      monthlySavings: null == monthlySavings
          ? _value.monthlySavings
          : monthlySavings // ignore: cast_nullable_to_non_nullable
              as double,
      yearlySavings: null == yearlySavings
          ? _value.yearlySavings
          : yearlySavings // ignore: cast_nullable_to_non_nullable
              as double,
      daysQuit: null == daysQuit
          ? _value.daysQuit
          : daysQuit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialSavingsImpl implements _FinancialSavings {
  const _$FinancialSavingsImpl(
      {required this.totalSaved,
      required this.dailySavings,
      required this.weeklySavings,
      required this.monthlySavings,
      required this.yearlySavings,
      required this.daysQuit});

  factory _$FinancialSavingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialSavingsImplFromJson(json);

  @override
  final double totalSaved;
  @override
  final double dailySavings;
  @override
  final double weeklySavings;
  @override
  final double monthlySavings;
  @override
  final double yearlySavings;
  @override
  final int daysQuit;

  @override
  String toString() {
    return 'FinancialSavings(totalSaved: $totalSaved, dailySavings: $dailySavings, weeklySavings: $weeklySavings, monthlySavings: $monthlySavings, yearlySavings: $yearlySavings, daysQuit: $daysQuit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialSavingsImpl &&
            (identical(other.totalSaved, totalSaved) ||
                other.totalSaved == totalSaved) &&
            (identical(other.dailySavings, dailySavings) ||
                other.dailySavings == dailySavings) &&
            (identical(other.weeklySavings, weeklySavings) ||
                other.weeklySavings == weeklySavings) &&
            (identical(other.monthlySavings, monthlySavings) ||
                other.monthlySavings == monthlySavings) &&
            (identical(other.yearlySavings, yearlySavings) ||
                other.yearlySavings == yearlySavings) &&
            (identical(other.daysQuit, daysQuit) ||
                other.daysQuit == daysQuit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalSaved, dailySavings,
      weeklySavings, monthlySavings, yearlySavings, daysQuit);

  /// Create a copy of FinancialSavings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialSavingsImplCopyWith<_$FinancialSavingsImpl> get copyWith =>
      __$$FinancialSavingsImplCopyWithImpl<_$FinancialSavingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialSavingsImplToJson(
      this,
    );
  }
}

abstract class _FinancialSavings implements FinancialSavings {
  const factory _FinancialSavings(
      {required final double totalSaved,
      required final double dailySavings,
      required final double weeklySavings,
      required final double monthlySavings,
      required final double yearlySavings,
      required final int daysQuit}) = _$FinancialSavingsImpl;

  factory _FinancialSavings.fromJson(Map<String, dynamic> json) =
      _$FinancialSavingsImpl.fromJson;

  @override
  double get totalSaved;
  @override
  double get dailySavings;
  @override
  double get weeklySavings;
  @override
  double get monthlySavings;
  @override
  double get yearlySavings;
  @override
  int get daysQuit;

  /// Create a copy of FinancialSavings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialSavingsImplCopyWith<_$FinancialSavingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskReductions _$RiskReductionsFromJson(Map<String, dynamic> json) {
  return _RiskReductions.fromJson(json);
}

/// @nodoc
mixin _$RiskReductions {
  double get heartAttackRisk => throw _privateConstructorUsedError;
  double get strokeRisk => throw _privateConstructorUsedError;
  double get lungCancerRisk => throw _privateConstructorUsedError;
  double get respiratoryInfectionRisk => throw _privateConstructorUsedError;

  /// Serializes this RiskReductions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskReductions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskReductionsCopyWith<RiskReductions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskReductionsCopyWith<$Res> {
  factory $RiskReductionsCopyWith(
          RiskReductions value, $Res Function(RiskReductions) then) =
      _$RiskReductionsCopyWithImpl<$Res, RiskReductions>;
  @useResult
  $Res call(
      {double heartAttackRisk,
      double strokeRisk,
      double lungCancerRisk,
      double respiratoryInfectionRisk});
}

/// @nodoc
class _$RiskReductionsCopyWithImpl<$Res, $Val extends RiskReductions>
    implements $RiskReductionsCopyWith<$Res> {
  _$RiskReductionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskReductions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heartAttackRisk = null,
    Object? strokeRisk = null,
    Object? lungCancerRisk = null,
    Object? respiratoryInfectionRisk = null,
  }) {
    return _then(_value.copyWith(
      heartAttackRisk: null == heartAttackRisk
          ? _value.heartAttackRisk
          : heartAttackRisk // ignore: cast_nullable_to_non_nullable
              as double,
      strokeRisk: null == strokeRisk
          ? _value.strokeRisk
          : strokeRisk // ignore: cast_nullable_to_non_nullable
              as double,
      lungCancerRisk: null == lungCancerRisk
          ? _value.lungCancerRisk
          : lungCancerRisk // ignore: cast_nullable_to_non_nullable
              as double,
      respiratoryInfectionRisk: null == respiratoryInfectionRisk
          ? _value.respiratoryInfectionRisk
          : respiratoryInfectionRisk // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskReductionsImplCopyWith<$Res>
    implements $RiskReductionsCopyWith<$Res> {
  factory _$$RiskReductionsImplCopyWith(_$RiskReductionsImpl value,
          $Res Function(_$RiskReductionsImpl) then) =
      __$$RiskReductionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double heartAttackRisk,
      double strokeRisk,
      double lungCancerRisk,
      double respiratoryInfectionRisk});
}

/// @nodoc
class __$$RiskReductionsImplCopyWithImpl<$Res>
    extends _$RiskReductionsCopyWithImpl<$Res, _$RiskReductionsImpl>
    implements _$$RiskReductionsImplCopyWith<$Res> {
  __$$RiskReductionsImplCopyWithImpl(
      _$RiskReductionsImpl _value, $Res Function(_$RiskReductionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskReductions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heartAttackRisk = null,
    Object? strokeRisk = null,
    Object? lungCancerRisk = null,
    Object? respiratoryInfectionRisk = null,
  }) {
    return _then(_$RiskReductionsImpl(
      heartAttackRisk: null == heartAttackRisk
          ? _value.heartAttackRisk
          : heartAttackRisk // ignore: cast_nullable_to_non_nullable
              as double,
      strokeRisk: null == strokeRisk
          ? _value.strokeRisk
          : strokeRisk // ignore: cast_nullable_to_non_nullable
              as double,
      lungCancerRisk: null == lungCancerRisk
          ? _value.lungCancerRisk
          : lungCancerRisk // ignore: cast_nullable_to_non_nullable
              as double,
      respiratoryInfectionRisk: null == respiratoryInfectionRisk
          ? _value.respiratoryInfectionRisk
          : respiratoryInfectionRisk // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskReductionsImpl implements _RiskReductions {
  const _$RiskReductionsImpl(
      {this.heartAttackRisk = 0.0,
      this.strokeRisk = 0.0,
      this.lungCancerRisk = 0.0,
      this.respiratoryInfectionRisk = 0.0});

  factory _$RiskReductionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskReductionsImplFromJson(json);

  @override
  @JsonKey()
  final double heartAttackRisk;
  @override
  @JsonKey()
  final double strokeRisk;
  @override
  @JsonKey()
  final double lungCancerRisk;
  @override
  @JsonKey()
  final double respiratoryInfectionRisk;

  @override
  String toString() {
    return 'RiskReductions(heartAttackRisk: $heartAttackRisk, strokeRisk: $strokeRisk, lungCancerRisk: $lungCancerRisk, respiratoryInfectionRisk: $respiratoryInfectionRisk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskReductionsImpl &&
            (identical(other.heartAttackRisk, heartAttackRisk) ||
                other.heartAttackRisk == heartAttackRisk) &&
            (identical(other.strokeRisk, strokeRisk) ||
                other.strokeRisk == strokeRisk) &&
            (identical(other.lungCancerRisk, lungCancerRisk) ||
                other.lungCancerRisk == lungCancerRisk) &&
            (identical(
                    other.respiratoryInfectionRisk, respiratoryInfectionRisk) ||
                other.respiratoryInfectionRisk == respiratoryInfectionRisk));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, heartAttackRisk, strokeRisk,
      lungCancerRisk, respiratoryInfectionRisk);

  /// Create a copy of RiskReductions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskReductionsImplCopyWith<_$RiskReductionsImpl> get copyWith =>
      __$$RiskReductionsImplCopyWithImpl<_$RiskReductionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskReductionsImplToJson(
      this,
    );
  }
}

abstract class _RiskReductions implements RiskReductions {
  const factory _RiskReductions(
      {final double heartAttackRisk,
      final double strokeRisk,
      final double lungCancerRisk,
      final double respiratoryInfectionRisk}) = _$RiskReductionsImpl;

  factory _RiskReductions.fromJson(Map<String, dynamic> json) =
      _$RiskReductionsImpl.fromJson;

  @override
  double get heartAttackRisk;
  @override
  double get strokeRisk;
  @override
  double get lungCancerRisk;
  @override
  double get respiratoryInfectionRisk;

  /// Create a copy of RiskReductions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskReductionsImplCopyWith<_$RiskReductionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthMilestone _$HealthMilestoneFromJson(Map<String, dynamic> json) {
  return _HealthMilestone.fromJson(json);
}

/// @nodoc
mixin _$HealthMilestone {
  int get days => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get achieved => throw _privateConstructorUsedError;
  int get daysRemaining => throw _privateConstructorUsedError;

  /// Serializes this HealthMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthMilestoneCopyWith<HealthMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthMilestoneCopyWith<$Res> {
  factory $HealthMilestoneCopyWith(
          HealthMilestone value, $Res Function(HealthMilestone) then) =
      _$HealthMilestoneCopyWithImpl<$Res, HealthMilestone>;
  @useResult
  $Res call(
      {int days,
      String title,
      String description,
      bool achieved,
      int daysRemaining});
}

/// @nodoc
class _$HealthMilestoneCopyWithImpl<$Res, $Val extends HealthMilestone>
    implements $HealthMilestoneCopyWith<$Res> {
  _$HealthMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? title = null,
    Object? description = null,
    Object? achieved = null,
    Object? daysRemaining = null,
  }) {
    return _then(_value.copyWith(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      daysRemaining: null == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthMilestoneImplCopyWith<$Res>
    implements $HealthMilestoneCopyWith<$Res> {
  factory _$$HealthMilestoneImplCopyWith(_$HealthMilestoneImpl value,
          $Res Function(_$HealthMilestoneImpl) then) =
      __$$HealthMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int days,
      String title,
      String description,
      bool achieved,
      int daysRemaining});
}

/// @nodoc
class __$$HealthMilestoneImplCopyWithImpl<$Res>
    extends _$HealthMilestoneCopyWithImpl<$Res, _$HealthMilestoneImpl>
    implements _$$HealthMilestoneImplCopyWith<$Res> {
  __$$HealthMilestoneImplCopyWithImpl(
      _$HealthMilestoneImpl _value, $Res Function(_$HealthMilestoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? title = null,
    Object? description = null,
    Object? achieved = null,
    Object? daysRemaining = null,
  }) {
    return _then(_$HealthMilestoneImpl(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      daysRemaining: null == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthMilestoneImpl implements _HealthMilestone {
  const _$HealthMilestoneImpl(
      {required this.days,
      required this.title,
      required this.description,
      this.achieved = false,
      this.daysRemaining = 0});

  factory _$HealthMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthMilestoneImplFromJson(json);

  @override
  final int days;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final bool achieved;
  @override
  @JsonKey()
  final int daysRemaining;

  @override
  String toString() {
    return 'HealthMilestone(days: $days, title: $title, description: $description, achieved: $achieved, daysRemaining: $daysRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthMilestoneImpl &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.daysRemaining, daysRemaining) ||
                other.daysRemaining == daysRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, days, title, description, achieved, daysRemaining);

  /// Create a copy of HealthMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthMilestoneImplCopyWith<_$HealthMilestoneImpl> get copyWith =>
      __$$HealthMilestoneImplCopyWithImpl<_$HealthMilestoneImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthMilestoneImplToJson(
      this,
    );
  }
}

abstract class _HealthMilestone implements HealthMilestone {
  const factory _HealthMilestone(
      {required final int days,
      required final String title,
      required final String description,
      final bool achieved,
      final int daysRemaining}) = _$HealthMilestoneImpl;

  factory _HealthMilestone.fromJson(Map<String, dynamic> json) =
      _$HealthMilestoneImpl.fromJson;

  @override
  int get days;
  @override
  String get title;
  @override
  String get description;
  @override
  bool get achieved;
  @override
  int get daysRemaining;

  /// Create a copy of HealthMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthMilestoneImplCopyWith<_$HealthMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthDataSource _$HealthDataSourceFromJson(Map<String, dynamic> json) {
  return _HealthDataSource.fromJson(json);
}

/// @nodoc
mixin _$HealthDataSource {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get reliability => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this HealthDataSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthDataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataSourceCopyWith<HealthDataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataSourceCopyWith<$Res> {
  factory $HealthDataSourceCopyWith(
          HealthDataSource value, $Res Function(HealthDataSource) then) =
      _$HealthDataSourceCopyWithImpl<$Res, HealthDataSource>;
  @useResult
  $Res call(
      {String name,
      String url,
      String description,
      double reliability,
      DateTime lastUpdated});
}

/// @nodoc
class _$HealthDataSourceCopyWithImpl<$Res, $Val extends HealthDataSource>
    implements $HealthDataSourceCopyWith<$Res> {
  _$HealthDataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthDataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
    Object? description = null,
    Object? reliability = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      reliability: null == reliability
          ? _value.reliability
          : reliability // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthDataSourceImplCopyWith<$Res>
    implements $HealthDataSourceCopyWith<$Res> {
  factory _$$HealthDataSourceImplCopyWith(_$HealthDataSourceImpl value,
          $Res Function(_$HealthDataSourceImpl) then) =
      __$$HealthDataSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String url,
      String description,
      double reliability,
      DateTime lastUpdated});
}

/// @nodoc
class __$$HealthDataSourceImplCopyWithImpl<$Res>
    extends _$HealthDataSourceCopyWithImpl<$Res, _$HealthDataSourceImpl>
    implements _$$HealthDataSourceImplCopyWith<$Res> {
  __$$HealthDataSourceImplCopyWithImpl(_$HealthDataSourceImpl _value,
      $Res Function(_$HealthDataSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthDataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
    Object? description = null,
    Object? reliability = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$HealthDataSourceImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      reliability: null == reliability
          ? _value.reliability
          : reliability // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthDataSourceImpl implements _HealthDataSource {
  const _$HealthDataSourceImpl(
      {required this.name,
      required this.url,
      required this.description,
      this.reliability = 1.0,
      required this.lastUpdated});

  factory _$HealthDataSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataSourceImplFromJson(json);

  @override
  final String name;
  @override
  final String url;
  @override
  final String description;
  @override
  @JsonKey()
  final double reliability;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'HealthDataSource(name: $name, url: $url, description: $description, reliability: $reliability, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataSourceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reliability, reliability) ||
                other.reliability == reliability) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, url, description, reliability, lastUpdated);

  /// Create a copy of HealthDataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataSourceImplCopyWith<_$HealthDataSourceImpl> get copyWith =>
      __$$HealthDataSourceImplCopyWithImpl<_$HealthDataSourceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataSourceImplToJson(
      this,
    );
  }
}

abstract class _HealthDataSource implements HealthDataSource {
  const factory _HealthDataSource(
      {required final String name,
      required final String url,
      required final String description,
      final double reliability,
      required final DateTime lastUpdated}) = _$HealthDataSourceImpl;

  factory _HealthDataSource.fromJson(Map<String, dynamic> json) =
      _$HealthDataSourceImpl.fromJson;

  @override
  String get name;
  @override
  String get url;
  @override
  String get description;
  @override
  double get reliability;
  @override
  DateTime get lastUpdated;

  /// Create a copy of HealthDataSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataSourceImplCopyWith<_$HealthDataSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthResearchCitation _$HealthResearchCitationFromJson(
    Map<String, dynamic> json) {
  return _HealthResearchCitation.fromJson(json);
}

/// @nodoc
mixin _$HealthResearchCitation {
  String get title => throw _privateConstructorUsedError;
  String get authors => throw _privateConstructorUsedError;
  String get journal => throw _privateConstructorUsedError;
  String get doi => throw _privateConstructorUsedError;
  DateTime get publishedDate => throw _privateConstructorUsedError;
  double get relevanceScore => throw _privateConstructorUsedError;

  /// Serializes this HealthResearchCitation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthResearchCitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthResearchCitationCopyWith<HealthResearchCitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthResearchCitationCopyWith<$Res> {
  factory $HealthResearchCitationCopyWith(HealthResearchCitation value,
          $Res Function(HealthResearchCitation) then) =
      _$HealthResearchCitationCopyWithImpl<$Res, HealthResearchCitation>;
  @useResult
  $Res call(
      {String title,
      String authors,
      String journal,
      String doi,
      DateTime publishedDate,
      double relevanceScore});
}

/// @nodoc
class _$HealthResearchCitationCopyWithImpl<$Res,
        $Val extends HealthResearchCitation>
    implements $HealthResearchCitationCopyWith<$Res> {
  _$HealthResearchCitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthResearchCitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = null,
    Object? journal = null,
    Object? doi = null,
    Object? publishedDate = null,
    Object? relevanceScore = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as String,
      journal: null == journal
          ? _value.journal
          : journal // ignore: cast_nullable_to_non_nullable
              as String,
      doi: null == doi
          ? _value.doi
          : doi // ignore: cast_nullable_to_non_nullable
              as String,
      publishedDate: null == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthResearchCitationImplCopyWith<$Res>
    implements $HealthResearchCitationCopyWith<$Res> {
  factory _$$HealthResearchCitationImplCopyWith(
          _$HealthResearchCitationImpl value,
          $Res Function(_$HealthResearchCitationImpl) then) =
      __$$HealthResearchCitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String authors,
      String journal,
      String doi,
      DateTime publishedDate,
      double relevanceScore});
}

/// @nodoc
class __$$HealthResearchCitationImplCopyWithImpl<$Res>
    extends _$HealthResearchCitationCopyWithImpl<$Res,
        _$HealthResearchCitationImpl>
    implements _$$HealthResearchCitationImplCopyWith<$Res> {
  __$$HealthResearchCitationImplCopyWithImpl(
      _$HealthResearchCitationImpl _value,
      $Res Function(_$HealthResearchCitationImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthResearchCitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? authors = null,
    Object? journal = null,
    Object? doi = null,
    Object? publishedDate = null,
    Object? relevanceScore = null,
  }) {
    return _then(_$HealthResearchCitationImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as String,
      journal: null == journal
          ? _value.journal
          : journal // ignore: cast_nullable_to_non_nullable
              as String,
      doi: null == doi
          ? _value.doi
          : doi // ignore: cast_nullable_to_non_nullable
              as String,
      publishedDate: null == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthResearchCitationImpl implements _HealthResearchCitation {
  const _$HealthResearchCitationImpl(
      {required this.title,
      required this.authors,
      required this.journal,
      required this.doi,
      required this.publishedDate,
      this.relevanceScore = 1.0});

  factory _$HealthResearchCitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthResearchCitationImplFromJson(json);

  @override
  final String title;
  @override
  final String authors;
  @override
  final String journal;
  @override
  final String doi;
  @override
  final DateTime publishedDate;
  @override
  @JsonKey()
  final double relevanceScore;

  @override
  String toString() {
    return 'HealthResearchCitation(title: $title, authors: $authors, journal: $journal, doi: $doi, publishedDate: $publishedDate, relevanceScore: $relevanceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthResearchCitationImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.authors, authors) || other.authors == authors) &&
            (identical(other.journal, journal) || other.journal == journal) &&
            (identical(other.doi, doi) || other.doi == doi) &&
            (identical(other.publishedDate, publishedDate) ||
                other.publishedDate == publishedDate) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, authors, journal, doi, publishedDate, relevanceScore);

  /// Create a copy of HealthResearchCitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthResearchCitationImplCopyWith<_$HealthResearchCitationImpl>
      get copyWith => __$$HealthResearchCitationImplCopyWithImpl<
          _$HealthResearchCitationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthResearchCitationImplToJson(
      this,
    );
  }
}

abstract class _HealthResearchCitation implements HealthResearchCitation {
  const factory _HealthResearchCitation(
      {required final String title,
      required final String authors,
      required final String journal,
      required final String doi,
      required final DateTime publishedDate,
      final double relevanceScore}) = _$HealthResearchCitationImpl;

  factory _HealthResearchCitation.fromJson(Map<String, dynamic> json) =
      _$HealthResearchCitationImpl.fromJson;

  @override
  String get title;
  @override
  String get authors;
  @override
  String get journal;
  @override
  String get doi;
  @override
  DateTime get publishedDate;
  @override
  double get relevanceScore;

  /// Create a copy of HealthResearchCitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthResearchCitationImplCopyWith<_$HealthResearchCitationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HealthAlert _$HealthAlertFromJson(Map<String, dynamic> json) {
  return _HealthAlert.fromJson(json);
}

/// @nodoc
mixin _$HealthAlert {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  HealthAlertType get type => throw _privateConstructorUsedError;
  HealthAlertPriority get priority => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get dismissed => throw _privateConstructorUsedError;
  String? get actionUrl => throw _privateConstructorUsedError;

  /// Serializes this HealthAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthAlertCopyWith<HealthAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthAlertCopyWith<$Res> {
  factory $HealthAlertCopyWith(
          HealthAlert value, $Res Function(HealthAlert) then) =
      _$HealthAlertCopyWithImpl<$Res, HealthAlert>;
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      HealthAlertType type,
      HealthAlertPriority priority,
      DateTime createdAt,
      bool dismissed,
      String? actionUrl});
}

/// @nodoc
class _$HealthAlertCopyWithImpl<$Res, $Val extends HealthAlert>
    implements $HealthAlertCopyWith<$Res> {
  _$HealthAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? dismissed = null,
    Object? actionUrl = freezed,
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
              as HealthAlertType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as HealthAlertPriority,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dismissed: null == dismissed
          ? _value.dismissed
          : dismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthAlertImplCopyWith<$Res>
    implements $HealthAlertCopyWith<$Res> {
  factory _$$HealthAlertImplCopyWith(
          _$HealthAlertImpl value, $Res Function(_$HealthAlertImpl) then) =
      __$$HealthAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      HealthAlertType type,
      HealthAlertPriority priority,
      DateTime createdAt,
      bool dismissed,
      String? actionUrl});
}

/// @nodoc
class __$$HealthAlertImplCopyWithImpl<$Res>
    extends _$HealthAlertCopyWithImpl<$Res, _$HealthAlertImpl>
    implements _$$HealthAlertImplCopyWith<$Res> {
  __$$HealthAlertImplCopyWithImpl(
      _$HealthAlertImpl _value, $Res Function(_$HealthAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? dismissed = null,
    Object? actionUrl = freezed,
  }) {
    return _then(_$HealthAlertImpl(
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
              as HealthAlertType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as HealthAlertPriority,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dismissed: null == dismissed
          ? _value.dismissed
          : dismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthAlertImpl implements _HealthAlert {
  const _$HealthAlertImpl(
      {required this.id,
      required this.title,
      required this.message,
      required this.type,
      required this.priority,
      required this.createdAt,
      this.dismissed = false,
      this.actionUrl});

  factory _$HealthAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String message;
  @override
  final HealthAlertType type;
  @override
  final HealthAlertPriority priority;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool dismissed;
  @override
  final String? actionUrl;

  @override
  String toString() {
    return 'HealthAlert(id: $id, title: $title, message: $message, type: $type, priority: $priority, createdAt: $createdAt, dismissed: $dismissed, actionUrl: $actionUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dismissed, dismissed) ||
                other.dismissed == dismissed) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, message, type,
      priority, createdAt, dismissed, actionUrl);

  /// Create a copy of HealthAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthAlertImplCopyWith<_$HealthAlertImpl> get copyWith =>
      __$$HealthAlertImplCopyWithImpl<_$HealthAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthAlertImplToJson(
      this,
    );
  }
}

abstract class _HealthAlert implements HealthAlert {
  const factory _HealthAlert(
      {required final String id,
      required final String title,
      required final String message,
      required final HealthAlertType type,
      required final HealthAlertPriority priority,
      required final DateTime createdAt,
      final bool dismissed,
      final String? actionUrl}) = _$HealthAlertImpl;

  factory _HealthAlert.fromJson(Map<String, dynamic> json) =
      _$HealthAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get message;
  @override
  HealthAlertType get type;
  @override
  HealthAlertPriority get priority;
  @override
  DateTime get createdAt;
  @override
  bool get dismissed;
  @override
  String? get actionUrl;

  /// Create a copy of HealthAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthAlertImplCopyWith<_$HealthAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthMetrics _$HealthMetricsFromJson(Map<String, dynamic> json) {
  return _HealthMetrics.fromJson(json);
}

/// @nodoc
mixin _$HealthMetrics {
  String get userId => throw _privateConstructorUsedError;
  DateTime get recordedAt => throw _privateConstructorUsedError;
  double? get heartRate => throw _privateConstructorUsedError;
  double? get bloodPressure => throw _privateConstructorUsedError;
  double? get oxygenSaturation => throw _privateConstructorUsedError;
  double? get lungCapacity => throw _privateConstructorUsedError;
  int? get stepsCount => throw _privateConstructorUsedError;
  double? get sleepQuality => throw _privateConstructorUsedError;
  int? get stressLevel => throw _privateConstructorUsedError;
  Map<String, dynamic>? get additionalMetrics =>
      throw _privateConstructorUsedError;

  /// Serializes this HealthMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthMetricsCopyWith<HealthMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthMetricsCopyWith<$Res> {
  factory $HealthMetricsCopyWith(
          HealthMetrics value, $Res Function(HealthMetrics) then) =
      _$HealthMetricsCopyWithImpl<$Res, HealthMetrics>;
  @useResult
  $Res call(
      {String userId,
      DateTime recordedAt,
      double? heartRate,
      double? bloodPressure,
      double? oxygenSaturation,
      double? lungCapacity,
      int? stepsCount,
      double? sleepQuality,
      int? stressLevel,
      Map<String, dynamic>? additionalMetrics});
}

/// @nodoc
class _$HealthMetricsCopyWithImpl<$Res, $Val extends HealthMetrics>
    implements $HealthMetricsCopyWith<$Res> {
  _$HealthMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? recordedAt = null,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? oxygenSaturation = freezed,
    Object? lungCapacity = freezed,
    Object? stepsCount = freezed,
    Object? sleepQuality = freezed,
    Object? stressLevel = freezed,
    Object? additionalMetrics = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      heartRate: freezed == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      bloodPressure: freezed == bloodPressure
          ? _value.bloodPressure
          : bloodPressure // ignore: cast_nullable_to_non_nullable
              as double?,
      oxygenSaturation: freezed == oxygenSaturation
          ? _value.oxygenSaturation
          : oxygenSaturation // ignore: cast_nullable_to_non_nullable
              as double?,
      lungCapacity: freezed == lungCapacity
          ? _value.lungCapacity
          : lungCapacity // ignore: cast_nullable_to_non_nullable
              as double?,
      stepsCount: freezed == stepsCount
          ? _value.stepsCount
          : stepsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as double?,
      stressLevel: freezed == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      additionalMetrics: freezed == additionalMetrics
          ? _value.additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthMetricsImplCopyWith<$Res>
    implements $HealthMetricsCopyWith<$Res> {
  factory _$$HealthMetricsImplCopyWith(
          _$HealthMetricsImpl value, $Res Function(_$HealthMetricsImpl) then) =
      __$$HealthMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime recordedAt,
      double? heartRate,
      double? bloodPressure,
      double? oxygenSaturation,
      double? lungCapacity,
      int? stepsCount,
      double? sleepQuality,
      int? stressLevel,
      Map<String, dynamic>? additionalMetrics});
}

/// @nodoc
class __$$HealthMetricsImplCopyWithImpl<$Res>
    extends _$HealthMetricsCopyWithImpl<$Res, _$HealthMetricsImpl>
    implements _$$HealthMetricsImplCopyWith<$Res> {
  __$$HealthMetricsImplCopyWithImpl(
      _$HealthMetricsImpl _value, $Res Function(_$HealthMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? recordedAt = null,
    Object? heartRate = freezed,
    Object? bloodPressure = freezed,
    Object? oxygenSaturation = freezed,
    Object? lungCapacity = freezed,
    Object? stepsCount = freezed,
    Object? sleepQuality = freezed,
    Object? stressLevel = freezed,
    Object? additionalMetrics = freezed,
  }) {
    return _then(_$HealthMetricsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      heartRate: freezed == heartRate
          ? _value.heartRate
          : heartRate // ignore: cast_nullable_to_non_nullable
              as double?,
      bloodPressure: freezed == bloodPressure
          ? _value.bloodPressure
          : bloodPressure // ignore: cast_nullable_to_non_nullable
              as double?,
      oxygenSaturation: freezed == oxygenSaturation
          ? _value.oxygenSaturation
          : oxygenSaturation // ignore: cast_nullable_to_non_nullable
              as double?,
      lungCapacity: freezed == lungCapacity
          ? _value.lungCapacity
          : lungCapacity // ignore: cast_nullable_to_non_nullable
              as double?,
      stepsCount: freezed == stepsCount
          ? _value.stepsCount
          : stepsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as double?,
      stressLevel: freezed == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      additionalMetrics: freezed == additionalMetrics
          ? _value._additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthMetricsImpl implements _HealthMetrics {
  const _$HealthMetricsImpl(
      {required this.userId,
      required this.recordedAt,
      this.heartRate,
      this.bloodPressure,
      this.oxygenSaturation,
      this.lungCapacity,
      this.stepsCount,
      this.sleepQuality,
      this.stressLevel,
      final Map<String, dynamic>? additionalMetrics})
      : _additionalMetrics = additionalMetrics;

  factory _$HealthMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthMetricsImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime recordedAt;
  @override
  final double? heartRate;
  @override
  final double? bloodPressure;
  @override
  final double? oxygenSaturation;
  @override
  final double? lungCapacity;
  @override
  final int? stepsCount;
  @override
  final double? sleepQuality;
  @override
  final int? stressLevel;
  final Map<String, dynamic>? _additionalMetrics;
  @override
  Map<String, dynamic>? get additionalMetrics {
    final value = _additionalMetrics;
    if (value == null) return null;
    if (_additionalMetrics is EqualUnmodifiableMapView)
      return _additionalMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HealthMetrics(userId: $userId, recordedAt: $recordedAt, heartRate: $heartRate, bloodPressure: $bloodPressure, oxygenSaturation: $oxygenSaturation, lungCapacity: $lungCapacity, stepsCount: $stepsCount, sleepQuality: $sleepQuality, stressLevel: $stressLevel, additionalMetrics: $additionalMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthMetricsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.oxygenSaturation, oxygenSaturation) ||
                other.oxygenSaturation == oxygenSaturation) &&
            (identical(other.lungCapacity, lungCapacity) ||
                other.lungCapacity == lungCapacity) &&
            (identical(other.stepsCount, stepsCount) ||
                other.stepsCount == stepsCount) &&
            (identical(other.sleepQuality, sleepQuality) ||
                other.sleepQuality == sleepQuality) &&
            (identical(other.stressLevel, stressLevel) ||
                other.stressLevel == stressLevel) &&
            const DeepCollectionEquality()
                .equals(other._additionalMetrics, _additionalMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      recordedAt,
      heartRate,
      bloodPressure,
      oxygenSaturation,
      lungCapacity,
      stepsCount,
      sleepQuality,
      stressLevel,
      const DeepCollectionEquality().hash(_additionalMetrics));

  /// Create a copy of HealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthMetricsImplCopyWith<_$HealthMetricsImpl> get copyWith =>
      __$$HealthMetricsImplCopyWithImpl<_$HealthMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthMetricsImplToJson(
      this,
    );
  }
}

abstract class _HealthMetrics implements HealthMetrics {
  const factory _HealthMetrics(
      {required final String userId,
      required final DateTime recordedAt,
      final double? heartRate,
      final double? bloodPressure,
      final double? oxygenSaturation,
      final double? lungCapacity,
      final int? stepsCount,
      final double? sleepQuality,
      final int? stressLevel,
      final Map<String, dynamic>? additionalMetrics}) = _$HealthMetricsImpl;

  factory _HealthMetrics.fromJson(Map<String, dynamic> json) =
      _$HealthMetricsImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get recordedAt;
  @override
  double? get heartRate;
  @override
  double? get bloodPressure;
  @override
  double? get oxygenSaturation;
  @override
  double? get lungCapacity;
  @override
  int? get stepsCount;
  @override
  double? get sleepQuality;
  @override
  int? get stressLevel;
  @override
  Map<String, dynamic>? get additionalMetrics;

  /// Create a copy of HealthMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthMetricsImplCopyWith<_$HealthMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthGoal _$HealthGoalFromJson(Map<String, dynamic> json) {
  return _HealthGoal.fromJson(json);
}

/// @nodoc
mixin _$HealthGoal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  HealthGoalType get type => throw _privateConstructorUsedError;
  double get targetValue => throw _privateConstructorUsedError;
  double get currentValue => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get targetDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get achieved => throw _privateConstructorUsedError;
  DateTime? get achievedAt => throw _privateConstructorUsedError;

  /// Serializes this HealthGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthGoalCopyWith<HealthGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthGoalCopyWith<$Res> {
  factory $HealthGoalCopyWith(
          HealthGoal value, $Res Function(HealthGoal) then) =
      _$HealthGoalCopyWithImpl<$Res, HealthGoal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      HealthGoalType type,
      double targetValue,
      double currentValue,
      String unit,
      DateTime targetDate,
      DateTime createdAt,
      bool achieved,
      DateTime? achievedAt});
}

/// @nodoc
class _$HealthGoalCopyWithImpl<$Res, $Val extends HealthGoal>
    implements $HealthGoalCopyWith<$Res> {
  _$HealthGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? unit = null,
    Object? targetDate = null,
    Object? createdAt = null,
    Object? achieved = null,
    Object? achievedAt = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthGoalType,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      achievedAt: freezed == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthGoalImplCopyWith<$Res>
    implements $HealthGoalCopyWith<$Res> {
  factory _$$HealthGoalImplCopyWith(
          _$HealthGoalImpl value, $Res Function(_$HealthGoalImpl) then) =
      __$$HealthGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      HealthGoalType type,
      double targetValue,
      double currentValue,
      String unit,
      DateTime targetDate,
      DateTime createdAt,
      bool achieved,
      DateTime? achievedAt});
}

/// @nodoc
class __$$HealthGoalImplCopyWithImpl<$Res>
    extends _$HealthGoalCopyWithImpl<$Res, _$HealthGoalImpl>
    implements _$$HealthGoalImplCopyWith<$Res> {
  __$$HealthGoalImplCopyWithImpl(
      _$HealthGoalImpl _value, $Res Function(_$HealthGoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? unit = null,
    Object? targetDate = null,
    Object? createdAt = null,
    Object? achieved = null,
    Object? achievedAt = freezed,
  }) {
    return _then(_$HealthGoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthGoalType,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      achievedAt: freezed == achievedAt
          ? _value.achievedAt
          : achievedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthGoalImpl implements _HealthGoal {
  const _$HealthGoalImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.type,
      required this.targetValue,
      required this.currentValue,
      required this.unit,
      required this.targetDate,
      required this.createdAt,
      this.achieved = false,
      this.achievedAt});

  factory _$HealthGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthGoalImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String description;
  @override
  final HealthGoalType type;
  @override
  final double targetValue;
  @override
  final double currentValue;
  @override
  final String unit;
  @override
  final DateTime targetDate;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool achieved;
  @override
  final DateTime? achievedAt;

  @override
  String toString() {
    return 'HealthGoal(id: $id, userId: $userId, title: $title, description: $description, type: $type, targetValue: $targetValue, currentValue: $currentValue, unit: $unit, targetDate: $targetDate, createdAt: $createdAt, achieved: $achieved, achievedAt: $achievedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.achievedAt, achievedAt) ||
                other.achievedAt == achievedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      type,
      targetValue,
      currentValue,
      unit,
      targetDate,
      createdAt,
      achieved,
      achievedAt);

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthGoalImplCopyWith<_$HealthGoalImpl> get copyWith =>
      __$$HealthGoalImplCopyWithImpl<_$HealthGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthGoalImplToJson(
      this,
    );
  }
}

abstract class _HealthGoal implements HealthGoal {
  const factory _HealthGoal(
      {required final String id,
      required final String userId,
      required final String title,
      required final String description,
      required final HealthGoalType type,
      required final double targetValue,
      required final double currentValue,
      required final String unit,
      required final DateTime targetDate,
      required final DateTime createdAt,
      final bool achieved,
      final DateTime? achievedAt}) = _$HealthGoalImpl;

  factory _HealthGoal.fromJson(Map<String, dynamic> json) =
      _$HealthGoalImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get description;
  @override
  HealthGoalType get type;
  @override
  double get targetValue;
  @override
  double get currentValue;
  @override
  String get unit;
  @override
  DateTime get targetDate;
  @override
  DateTime get createdAt;
  @override
  bool get achieved;
  @override
  DateTime? get achievedAt;

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthGoalImplCopyWith<_$HealthGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthRecommendation _$HealthRecommendationFromJson(Map<String, dynamic> json) {
  return _HealthRecommendation.fromJson(json);
}

/// @nodoc
mixin _$HealthRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  HealthRecommendationType get type => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;
  List<String> get evidenceSources => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  bool get implemented => throw _privateConstructorUsedError;
  DateTime? get implementedAt => throw _privateConstructorUsedError;
  String? get userFeedback => throw _privateConstructorUsedError;

  /// Serializes this HealthRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthRecommendationCopyWith<HealthRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthRecommendationCopyWith<$Res> {
  factory $HealthRecommendationCopyWith(HealthRecommendation value,
          $Res Function(HealthRecommendation) then) =
      _$HealthRecommendationCopyWithImpl<$Res, HealthRecommendation>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      HealthRecommendationType type,
      double confidenceScore,
      List<String> evidenceSources,
      DateTime generatedAt,
      bool implemented,
      DateTime? implementedAt,
      String? userFeedback});
}

/// @nodoc
class _$HealthRecommendationCopyWithImpl<$Res,
        $Val extends HealthRecommendation>
    implements $HealthRecommendationCopyWith<$Res> {
  _$HealthRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? confidenceScore = null,
    Object? evidenceSources = null,
    Object? generatedAt = null,
    Object? implemented = null,
    Object? implementedAt = freezed,
    Object? userFeedback = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthRecommendationType,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      evidenceSources: null == evidenceSources
          ? _value.evidenceSources
          : evidenceSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      implemented: null == implemented
          ? _value.implemented
          : implemented // ignore: cast_nullable_to_non_nullable
              as bool,
      implementedAt: freezed == implementedAt
          ? _value.implementedAt
          : implementedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userFeedback: freezed == userFeedback
          ? _value.userFeedback
          : userFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthRecommendationImplCopyWith<$Res>
    implements $HealthRecommendationCopyWith<$Res> {
  factory _$$HealthRecommendationImplCopyWith(_$HealthRecommendationImpl value,
          $Res Function(_$HealthRecommendationImpl) then) =
      __$$HealthRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      HealthRecommendationType type,
      double confidenceScore,
      List<String> evidenceSources,
      DateTime generatedAt,
      bool implemented,
      DateTime? implementedAt,
      String? userFeedback});
}

/// @nodoc
class __$$HealthRecommendationImplCopyWithImpl<$Res>
    extends _$HealthRecommendationCopyWithImpl<$Res, _$HealthRecommendationImpl>
    implements _$$HealthRecommendationImplCopyWith<$Res> {
  __$$HealthRecommendationImplCopyWithImpl(_$HealthRecommendationImpl _value,
      $Res Function(_$HealthRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? confidenceScore = null,
    Object? evidenceSources = null,
    Object? generatedAt = null,
    Object? implemented = null,
    Object? implementedAt = freezed,
    Object? userFeedback = freezed,
  }) {
    return _then(_$HealthRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthRecommendationType,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      evidenceSources: null == evidenceSources
          ? _value._evidenceSources
          : evidenceSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      implemented: null == implemented
          ? _value.implemented
          : implemented // ignore: cast_nullable_to_non_nullable
              as bool,
      implementedAt: freezed == implementedAt
          ? _value.implementedAt
          : implementedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userFeedback: freezed == userFeedback
          ? _value.userFeedback
          : userFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthRecommendationImpl implements _HealthRecommendation {
  const _$HealthRecommendationImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.type,
      required this.confidenceScore,
      required final List<String> evidenceSources,
      required this.generatedAt,
      this.implemented = false,
      this.implementedAt,
      this.userFeedback})
      : _evidenceSources = evidenceSources;

  factory _$HealthRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String description;
  @override
  final HealthRecommendationType type;
  @override
  final double confidenceScore;
  final List<String> _evidenceSources;
  @override
  List<String> get evidenceSources {
    if (_evidenceSources is EqualUnmodifiableListView) return _evidenceSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceSources);
  }

  @override
  final DateTime generatedAt;
  @override
  @JsonKey()
  final bool implemented;
  @override
  final DateTime? implementedAt;
  @override
  final String? userFeedback;

  @override
  String toString() {
    return 'HealthRecommendation(id: $id, userId: $userId, title: $title, description: $description, type: $type, confidenceScore: $confidenceScore, evidenceSources: $evidenceSources, generatedAt: $generatedAt, implemented: $implemented, implementedAt: $implementedAt, userFeedback: $userFeedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            const DeepCollectionEquality()
                .equals(other._evidenceSources, _evidenceSources) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.implemented, implemented) ||
                other.implemented == implemented) &&
            (identical(other.implementedAt, implementedAt) ||
                other.implementedAt == implementedAt) &&
            (identical(other.userFeedback, userFeedback) ||
                other.userFeedback == userFeedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      type,
      confidenceScore,
      const DeepCollectionEquality().hash(_evidenceSources),
      generatedAt,
      implemented,
      implementedAt,
      userFeedback);

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthRecommendationImplCopyWith<_$HealthRecommendationImpl>
      get copyWith =>
          __$$HealthRecommendationImplCopyWithImpl<_$HealthRecommendationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthRecommendationImplToJson(
      this,
    );
  }
}

abstract class _HealthRecommendation implements HealthRecommendation {
  const factory _HealthRecommendation(
      {required final String id,
      required final String userId,
      required final String title,
      required final String description,
      required final HealthRecommendationType type,
      required final double confidenceScore,
      required final List<String> evidenceSources,
      required final DateTime generatedAt,
      final bool implemented,
      final DateTime? implementedAt,
      final String? userFeedback}) = _$HealthRecommendationImpl;

  factory _HealthRecommendation.fromJson(Map<String, dynamic> json) =
      _$HealthRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get description;
  @override
  HealthRecommendationType get type;
  @override
  double get confidenceScore;
  @override
  List<String> get evidenceSources;
  @override
  DateTime get generatedAt;
  @override
  bool get implemented;
  @override
  DateTime? get implementedAt;
  @override
  String? get userFeedback;

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthRecommendationImplCopyWith<_$HealthRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
