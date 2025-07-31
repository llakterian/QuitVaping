// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) {
  return _ProgressModel.fromJson(json);
}

/// @nodoc
mixin _$ProgressModel {
  String get userId => throw _privateConstructorUsedError;
  DateTime get quitDate => throw _privateConstructorUsedError;
  double get dailySavings =>
      throw _privateConstructorUsedError; // Money saved per day
  Map<String, bool> get achievedMilestones =>
      throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError; // Days
  int get longestStreak => throw _privateConstructorUsedError; // Days
  List<DateTime>? get relapses => throw _privateConstructorUsedError;
  Map<String, dynamic>? get withdrawalSymptoms =>
      throw _privateConstructorUsedError;
  List<AchievementModel> get achievements => throw _privateConstructorUsedError;
  Map<String, dynamic>? get aiRecommendations =>
      throw _privateConstructorUsedError;

  /// Serializes this ProgressModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressModelCopyWith<ProgressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressModelCopyWith<$Res> {
  factory $ProgressModelCopyWith(
          ProgressModel value, $Res Function(ProgressModel) then) =
      _$ProgressModelCopyWithImpl<$Res, ProgressModel>;
  @useResult
  $Res call(
      {String userId,
      DateTime quitDate,
      double dailySavings,
      Map<String, bool> achievedMilestones,
      int currentStreak,
      int longestStreak,
      List<DateTime>? relapses,
      Map<String, dynamic>? withdrawalSymptoms,
      List<AchievementModel> achievements,
      Map<String, dynamic>? aiRecommendations});
}

/// @nodoc
class _$ProgressModelCopyWithImpl<$Res, $Val extends ProgressModel>
    implements $ProgressModelCopyWith<$Res> {
  _$ProgressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? quitDate = null,
    Object? dailySavings = null,
    Object? achievedMilestones = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? relapses = freezed,
    Object? withdrawalSymptoms = freezed,
    Object? achievements = null,
    Object? aiRecommendations = freezed,
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
      dailySavings: null == dailySavings
          ? _value.dailySavings
          : dailySavings // ignore: cast_nullable_to_non_nullable
              as double,
      achievedMilestones: null == achievedMilestones
          ? _value.achievedMilestones
          : achievedMilestones // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      relapses: freezed == relapses
          ? _value.relapses
          : relapses // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      withdrawalSymptoms: freezed == withdrawalSymptoms
          ? _value.withdrawalSymptoms
          : withdrawalSymptoms // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<AchievementModel>,
      aiRecommendations: freezed == aiRecommendations
          ? _value.aiRecommendations
          : aiRecommendations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressModelImplCopyWith<$Res>
    implements $ProgressModelCopyWith<$Res> {
  factory _$$ProgressModelImplCopyWith(
          _$ProgressModelImpl value, $Res Function(_$ProgressModelImpl) then) =
      __$$ProgressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime quitDate,
      double dailySavings,
      Map<String, bool> achievedMilestones,
      int currentStreak,
      int longestStreak,
      List<DateTime>? relapses,
      Map<String, dynamic>? withdrawalSymptoms,
      List<AchievementModel> achievements,
      Map<String, dynamic>? aiRecommendations});
}

/// @nodoc
class __$$ProgressModelImplCopyWithImpl<$Res>
    extends _$ProgressModelCopyWithImpl<$Res, _$ProgressModelImpl>
    implements _$$ProgressModelImplCopyWith<$Res> {
  __$$ProgressModelImplCopyWithImpl(
      _$ProgressModelImpl _value, $Res Function(_$ProgressModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? quitDate = null,
    Object? dailySavings = null,
    Object? achievedMilestones = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? relapses = freezed,
    Object? withdrawalSymptoms = freezed,
    Object? achievements = null,
    Object? aiRecommendations = freezed,
  }) {
    return _then(_$ProgressModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      quitDate: null == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dailySavings: null == dailySavings
          ? _value.dailySavings
          : dailySavings // ignore: cast_nullable_to_non_nullable
              as double,
      achievedMilestones: null == achievedMilestones
          ? _value._achievedMilestones
          : achievedMilestones // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      relapses: freezed == relapses
          ? _value._relapses
          : relapses // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      withdrawalSymptoms: freezed == withdrawalSymptoms
          ? _value._withdrawalSymptoms
          : withdrawalSymptoms // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<AchievementModel>,
      aiRecommendations: freezed == aiRecommendations
          ? _value._aiRecommendations
          : aiRecommendations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressModelImpl extends _ProgressModel {
  const _$ProgressModelImpl(
      {required this.userId,
      required this.quitDate,
      required this.dailySavings,
      required final Map<String, bool> achievedMilestones,
      required this.currentStreak,
      required this.longestStreak,
      final List<DateTime>? relapses,
      final Map<String, dynamic>? withdrawalSymptoms,
      required final List<AchievementModel> achievements,
      final Map<String, dynamic>? aiRecommendations})
      : _achievedMilestones = achievedMilestones,
        _relapses = relapses,
        _withdrawalSymptoms = withdrawalSymptoms,
        _achievements = achievements,
        _aiRecommendations = aiRecommendations,
        super._();

  factory _$ProgressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressModelImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime quitDate;
  @override
  final double dailySavings;
// Money saved per day
  final Map<String, bool> _achievedMilestones;
// Money saved per day
  @override
  Map<String, bool> get achievedMilestones {
    if (_achievedMilestones is EqualUnmodifiableMapView)
      return _achievedMilestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_achievedMilestones);
  }

  @override
  final int currentStreak;
// Days
  @override
  final int longestStreak;
// Days
  final List<DateTime>? _relapses;
// Days
  @override
  List<DateTime>? get relapses {
    final value = _relapses;
    if (value == null) return null;
    if (_relapses is EqualUnmodifiableListView) return _relapses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _withdrawalSymptoms;
  @override
  Map<String, dynamic>? get withdrawalSymptoms {
    final value = _withdrawalSymptoms;
    if (value == null) return null;
    if (_withdrawalSymptoms is EqualUnmodifiableMapView)
      return _withdrawalSymptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<AchievementModel> _achievements;
  @override
  List<AchievementModel> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  final Map<String, dynamic>? _aiRecommendations;
  @override
  Map<String, dynamic>? get aiRecommendations {
    final value = _aiRecommendations;
    if (value == null) return null;
    if (_aiRecommendations is EqualUnmodifiableMapView)
      return _aiRecommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ProgressModel(userId: $userId, quitDate: $quitDate, dailySavings: $dailySavings, achievedMilestones: $achievedMilestones, currentStreak: $currentStreak, longestStreak: $longestStreak, relapses: $relapses, withdrawalSymptoms: $withdrawalSymptoms, achievements: $achievements, aiRecommendations: $aiRecommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.quitDate, quitDate) ||
                other.quitDate == quitDate) &&
            (identical(other.dailySavings, dailySavings) ||
                other.dailySavings == dailySavings) &&
            const DeepCollectionEquality()
                .equals(other._achievedMilestones, _achievedMilestones) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            const DeepCollectionEquality().equals(other._relapses, _relapses) &&
            const DeepCollectionEquality()
                .equals(other._withdrawalSymptoms, _withdrawalSymptoms) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            const DeepCollectionEquality()
                .equals(other._aiRecommendations, _aiRecommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      quitDate,
      dailySavings,
      const DeepCollectionEquality().hash(_achievedMilestones),
      currentStreak,
      longestStreak,
      const DeepCollectionEquality().hash(_relapses),
      const DeepCollectionEquality().hash(_withdrawalSymptoms),
      const DeepCollectionEquality().hash(_achievements),
      const DeepCollectionEquality().hash(_aiRecommendations));

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressModelImplCopyWith<_$ProgressModelImpl> get copyWith =>
      __$$ProgressModelImplCopyWithImpl<_$ProgressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressModelImplToJson(
      this,
    );
  }
}

abstract class _ProgressModel extends ProgressModel {
  const factory _ProgressModel(
      {required final String userId,
      required final DateTime quitDate,
      required final double dailySavings,
      required final Map<String, bool> achievedMilestones,
      required final int currentStreak,
      required final int longestStreak,
      final List<DateTime>? relapses,
      final Map<String, dynamic>? withdrawalSymptoms,
      required final List<AchievementModel> achievements,
      final Map<String, dynamic>? aiRecommendations}) = _$ProgressModelImpl;
  const _ProgressModel._() : super._();

  factory _ProgressModel.fromJson(Map<String, dynamic> json) =
      _$ProgressModelImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get quitDate;
  @override
  double get dailySavings; // Money saved per day
  @override
  Map<String, bool> get achievedMilestones;
  @override
  int get currentStreak; // Days
  @override
  int get longestStreak; // Days
  @override
  List<DateTime>? get relapses;
  @override
  Map<String, dynamic>? get withdrawalSymptoms;
  @override
  List<AchievementModel> get achievements;
  @override
  Map<String, dynamic>? get aiRecommendations;

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressModelImplCopyWith<_$ProgressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) {
  return _AchievementModel.fromJson(json);
}

/// @nodoc
mixin _$AchievementModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // health, streak, financial, etc.
  DateTime get unlockedAt => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  int get pointValue => throw _privateConstructorUsedError;

  /// Serializes this AchievementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementModelCopyWith<AchievementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementModelCopyWith<$Res> {
  factory $AchievementModelCopyWith(
          AchievementModel value, $Res Function(AchievementModel) then) =
      _$AchievementModelCopyWithImpl<$Res, AchievementModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String category,
      DateTime unlockedAt,
      String iconPath,
      int pointValue});
}

/// @nodoc
class _$AchievementModelCopyWithImpl<$Res, $Val extends AchievementModel>
    implements $AchievementModelCopyWith<$Res> {
  _$AchievementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? unlockedAt = null,
    Object? iconPath = null,
    Object? pointValue = null,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      unlockedAt: null == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      pointValue: null == pointValue
          ? _value.pointValue
          : pointValue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementModelImplCopyWith<$Res>
    implements $AchievementModelCopyWith<$Res> {
  factory _$$AchievementModelImplCopyWith(_$AchievementModelImpl value,
          $Res Function(_$AchievementModelImpl) then) =
      __$$AchievementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String category,
      DateTime unlockedAt,
      String iconPath,
      int pointValue});
}

/// @nodoc
class __$$AchievementModelImplCopyWithImpl<$Res>
    extends _$AchievementModelCopyWithImpl<$Res, _$AchievementModelImpl>
    implements _$$AchievementModelImplCopyWith<$Res> {
  __$$AchievementModelImplCopyWithImpl(_$AchievementModelImpl _value,
      $Res Function(_$AchievementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? unlockedAt = null,
    Object? iconPath = null,
    Object? pointValue = null,
  }) {
    return _then(_$AchievementModelImpl(
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      unlockedAt: null == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      pointValue: null == pointValue
          ? _value.pointValue
          : pointValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementModelImpl implements _AchievementModel {
  const _$AchievementModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.unlockedAt,
      required this.iconPath,
      required this.pointValue});

  factory _$AchievementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
// health, streak, financial, etc.
  @override
  final DateTime unlockedAt;
  @override
  final String iconPath;
  @override
  final int pointValue;

  @override
  String toString() {
    return 'AchievementModel(id: $id, title: $title, description: $description, category: $category, unlockedAt: $unlockedAt, iconPath: $iconPath, pointValue: $pointValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.pointValue, pointValue) ||
                other.pointValue == pointValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, category,
      unlockedAt, iconPath, pointValue);

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementModelImplCopyWith<_$AchievementModelImpl> get copyWith =>
      __$$AchievementModelImplCopyWithImpl<_$AchievementModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementModelImplToJson(
      this,
    );
  }
}

abstract class _AchievementModel implements AchievementModel {
  const factory _AchievementModel(
      {required final String id,
      required final String title,
      required final String description,
      required final String category,
      required final DateTime unlockedAt,
      required final String iconPath,
      required final int pointValue}) = _$AchievementModelImpl;

  factory _AchievementModel.fromJson(Map<String, dynamic> json) =
      _$AchievementModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get category; // health, streak, financial, etc.
  @override
  DateTime get unlockedAt;
  @override
  String get iconPath;
  @override
  int get pointValue;

  /// Create a copy of AchievementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementModelImplCopyWith<_$AchievementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
