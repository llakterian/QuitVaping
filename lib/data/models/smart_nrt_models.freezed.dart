// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_nrt_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NRTIntelligentSchedule _$NRTIntelligentScheduleFromJson(
    Map<String, dynamic> json) {
  return _NRTIntelligentSchedule.fromJson(json);
}

/// @nodoc
mixin _$NRTIntelligentSchedule {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  NRTProtocol get protocol => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  List<AdaptiveReminder> get adaptiveReminders =>
      throw _privateConstructorUsedError;
  List<ProgressMilestone> get progressMilestones =>
      throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this NRTIntelligentSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTIntelligentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTIntelligentScheduleCopyWith<NRTIntelligentSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTIntelligentScheduleCopyWith<$Res> {
  factory $NRTIntelligentScheduleCopyWith(NRTIntelligentSchedule value,
          $Res Function(NRTIntelligentSchedule) then) =
      _$NRTIntelligentScheduleCopyWithImpl<$Res, NRTIntelligentSchedule>;
  @useResult
  $Res call(
      {String id,
      String userId,
      NRTProtocol protocol,
      DateTime generatedAt,
      List<AdaptiveReminder> adaptiveReminders,
      List<ProgressMilestone> progressMilestones,
      bool isActive,
      DateTime? lastUpdated});

  $NRTProtocolCopyWith<$Res> get protocol;
}

/// @nodoc
class _$NRTIntelligentScheduleCopyWithImpl<$Res,
        $Val extends NRTIntelligentSchedule>
    implements $NRTIntelligentScheduleCopyWith<$Res> {
  _$NRTIntelligentScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTIntelligentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? protocol = null,
    Object? generatedAt = null,
    Object? adaptiveReminders = null,
    Object? progressMilestones = null,
    Object? isActive = null,
    Object? lastUpdated = freezed,
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
      protocol: null == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as NRTProtocol,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      adaptiveReminders: null == adaptiveReminders
          ? _value.adaptiveReminders
          : adaptiveReminders // ignore: cast_nullable_to_non_nullable
              as List<AdaptiveReminder>,
      progressMilestones: null == progressMilestones
          ? _value.progressMilestones
          : progressMilestones // ignore: cast_nullable_to_non_nullable
              as List<ProgressMilestone>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of NRTIntelligentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NRTProtocolCopyWith<$Res> get protocol {
    return $NRTProtocolCopyWith<$Res>(_value.protocol, (value) {
      return _then(_value.copyWith(protocol: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NRTIntelligentScheduleImplCopyWith<$Res>
    implements $NRTIntelligentScheduleCopyWith<$Res> {
  factory _$$NRTIntelligentScheduleImplCopyWith(
          _$NRTIntelligentScheduleImpl value,
          $Res Function(_$NRTIntelligentScheduleImpl) then) =
      __$$NRTIntelligentScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NRTProtocol protocol,
      DateTime generatedAt,
      List<AdaptiveReminder> adaptiveReminders,
      List<ProgressMilestone> progressMilestones,
      bool isActive,
      DateTime? lastUpdated});

  @override
  $NRTProtocolCopyWith<$Res> get protocol;
}

/// @nodoc
class __$$NRTIntelligentScheduleImplCopyWithImpl<$Res>
    extends _$NRTIntelligentScheduleCopyWithImpl<$Res,
        _$NRTIntelligentScheduleImpl>
    implements _$$NRTIntelligentScheduleImplCopyWith<$Res> {
  __$$NRTIntelligentScheduleImplCopyWithImpl(
      _$NRTIntelligentScheduleImpl _value,
      $Res Function(_$NRTIntelligentScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTIntelligentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? protocol = null,
    Object? generatedAt = null,
    Object? adaptiveReminders = null,
    Object? progressMilestones = null,
    Object? isActive = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$NRTIntelligentScheduleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      protocol: null == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as NRTProtocol,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      adaptiveReminders: null == adaptiveReminders
          ? _value._adaptiveReminders
          : adaptiveReminders // ignore: cast_nullable_to_non_nullable
              as List<AdaptiveReminder>,
      progressMilestones: null == progressMilestones
          ? _value._progressMilestones
          : progressMilestones // ignore: cast_nullable_to_non_nullable
              as List<ProgressMilestone>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTIntelligentScheduleImpl implements _NRTIntelligentSchedule {
  const _$NRTIntelligentScheduleImpl(
      {required this.id,
      required this.userId,
      required this.protocol,
      required this.generatedAt,
      required final List<AdaptiveReminder> adaptiveReminders,
      required final List<ProgressMilestone> progressMilestones,
      this.isActive = false,
      this.lastUpdated})
      : _adaptiveReminders = adaptiveReminders,
        _progressMilestones = progressMilestones;

  factory _$NRTIntelligentScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTIntelligentScheduleImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final NRTProtocol protocol;
  @override
  final DateTime generatedAt;
  final List<AdaptiveReminder> _adaptiveReminders;
  @override
  List<AdaptiveReminder> get adaptiveReminders {
    if (_adaptiveReminders is EqualUnmodifiableListView)
      return _adaptiveReminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adaptiveReminders);
  }

  final List<ProgressMilestone> _progressMilestones;
  @override
  List<ProgressMilestone> get progressMilestones {
    if (_progressMilestones is EqualUnmodifiableListView)
      return _progressMilestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progressMilestones);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'NRTIntelligentSchedule(id: $id, userId: $userId, protocol: $protocol, generatedAt: $generatedAt, adaptiveReminders: $adaptiveReminders, progressMilestones: $progressMilestones, isActive: $isActive, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTIntelligentScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality()
                .equals(other._adaptiveReminders, _adaptiveReminders) &&
            const DeepCollectionEquality()
                .equals(other._progressMilestones, _progressMilestones) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      protocol,
      generatedAt,
      const DeepCollectionEquality().hash(_adaptiveReminders),
      const DeepCollectionEquality().hash(_progressMilestones),
      isActive,
      lastUpdated);

  /// Create a copy of NRTIntelligentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTIntelligentScheduleImplCopyWith<_$NRTIntelligentScheduleImpl>
      get copyWith => __$$NRTIntelligentScheduleImplCopyWithImpl<
          _$NRTIntelligentScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTIntelligentScheduleImplToJson(
      this,
    );
  }
}

abstract class _NRTIntelligentSchedule implements NRTIntelligentSchedule {
  const factory _NRTIntelligentSchedule(
      {required final String id,
      required final String userId,
      required final NRTProtocol protocol,
      required final DateTime generatedAt,
      required final List<AdaptiveReminder> adaptiveReminders,
      required final List<ProgressMilestone> progressMilestones,
      final bool isActive,
      final DateTime? lastUpdated}) = _$NRTIntelligentScheduleImpl;

  factory _NRTIntelligentSchedule.fromJson(Map<String, dynamic> json) =
      _$NRTIntelligentScheduleImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  NRTProtocol get protocol;
  @override
  DateTime get generatedAt;
  @override
  List<AdaptiveReminder> get adaptiveReminders;
  @override
  List<ProgressMilestone> get progressMilestones;
  @override
  bool get isActive;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of NRTIntelligentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTIntelligentScheduleImplCopyWith<_$NRTIntelligentScheduleImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AdaptiveReminder _$AdaptiveReminderFromJson(Map<String, dynamic> json) {
  return _AdaptiveReminder.fromJson(json);
}

/// @nodoc
mixin _$AdaptiveReminder {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AdaptiveReminderType get type => throw _privateConstructorUsedError;
  double get priority => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic>? get adaptationData =>
      throw _privateConstructorUsedError;

  /// Serializes this AdaptiveReminder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdaptiveReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdaptiveReminderCopyWith<AdaptiveReminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdaptiveReminderCopyWith<$Res> {
  factory $AdaptiveReminderCopyWith(
          AdaptiveReminder value, $Res Function(AdaptiveReminder) then) =
      _$AdaptiveReminderCopyWithImpl<$Res, AdaptiveReminder>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime scheduledTime,
      String message,
      AdaptiveReminderType type,
      double priority,
      bool isActive,
      Map<String, dynamic>? adaptationData});
}

/// @nodoc
class _$AdaptiveReminderCopyWithImpl<$Res, $Val extends AdaptiveReminder>
    implements $AdaptiveReminderCopyWith<$Res> {
  _$AdaptiveReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdaptiveReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? scheduledTime = null,
    Object? message = null,
    Object? type = null,
    Object? priority = null,
    Object? isActive = null,
    Object? adaptationData = freezed,
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
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AdaptiveReminderType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      adaptationData: freezed == adaptationData
          ? _value.adaptationData
          : adaptationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdaptiveReminderImplCopyWith<$Res>
    implements $AdaptiveReminderCopyWith<$Res> {
  factory _$$AdaptiveReminderImplCopyWith(_$AdaptiveReminderImpl value,
          $Res Function(_$AdaptiveReminderImpl) then) =
      __$$AdaptiveReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime scheduledTime,
      String message,
      AdaptiveReminderType type,
      double priority,
      bool isActive,
      Map<String, dynamic>? adaptationData});
}

/// @nodoc
class __$$AdaptiveReminderImplCopyWithImpl<$Res>
    extends _$AdaptiveReminderCopyWithImpl<$Res, _$AdaptiveReminderImpl>
    implements _$$AdaptiveReminderImplCopyWith<$Res> {
  __$$AdaptiveReminderImplCopyWithImpl(_$AdaptiveReminderImpl _value,
      $Res Function(_$AdaptiveReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdaptiveReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? scheduledTime = null,
    Object? message = null,
    Object? type = null,
    Object? priority = null,
    Object? isActive = null,
    Object? adaptationData = freezed,
  }) {
    return _then(_$AdaptiveReminderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AdaptiveReminderType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      adaptationData: freezed == adaptationData
          ? _value._adaptationData
          : adaptationData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdaptiveReminderImpl implements _AdaptiveReminder {
  const _$AdaptiveReminderImpl(
      {required this.id,
      required this.userId,
      required this.scheduledTime,
      required this.message,
      required this.type,
      this.priority = 1.0,
      this.isActive = true,
      final Map<String, dynamic>? adaptationData})
      : _adaptationData = adaptationData;

  factory _$AdaptiveReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdaptiveReminderImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime scheduledTime;
  @override
  final String message;
  @override
  final AdaptiveReminderType type;
  @override
  @JsonKey()
  final double priority;
  @override
  @JsonKey()
  final bool isActive;
  final Map<String, dynamic>? _adaptationData;
  @override
  Map<String, dynamic>? get adaptationData {
    final value = _adaptationData;
    if (value == null) return null;
    if (_adaptationData is EqualUnmodifiableMapView) return _adaptationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AdaptiveReminder(id: $id, userId: $userId, scheduledTime: $scheduledTime, message: $message, type: $type, priority: $priority, isActive: $isActive, adaptationData: $adaptationData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdaptiveReminderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other._adaptationData, _adaptationData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      scheduledTime,
      message,
      type,
      priority,
      isActive,
      const DeepCollectionEquality().hash(_adaptationData));

  /// Create a copy of AdaptiveReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdaptiveReminderImplCopyWith<_$AdaptiveReminderImpl> get copyWith =>
      __$$AdaptiveReminderImplCopyWithImpl<_$AdaptiveReminderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdaptiveReminderImplToJson(
      this,
    );
  }
}

abstract class _AdaptiveReminder implements AdaptiveReminder {
  const factory _AdaptiveReminder(
      {required final String id,
      required final String userId,
      required final DateTime scheduledTime,
      required final String message,
      required final AdaptiveReminderType type,
      final double priority,
      final bool isActive,
      final Map<String, dynamic>? adaptationData}) = _$AdaptiveReminderImpl;

  factory _AdaptiveReminder.fromJson(Map<String, dynamic> json) =
      _$AdaptiveReminderImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get scheduledTime;
  @override
  String get message;
  @override
  AdaptiveReminderType get type;
  @override
  double get priority;
  @override
  bool get isActive;
  @override
  Map<String, dynamic>? get adaptationData;

  /// Create a copy of AdaptiveReminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdaptiveReminderImplCopyWith<_$AdaptiveReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressMilestone _$ProgressMilestoneFromJson(Map<String, dynamic> json) {
  return _ProgressMilestone.fromJson(json);
}

/// @nodoc
mixin _$ProgressMilestone {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get targetDate => throw _privateConstructorUsedError;
  double get targetValue => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  bool get achieved => throw _privateConstructorUsedError;
  DateTime? get achievedDate => throw _privateConstructorUsedError;
  String? get celebrationMessage => throw _privateConstructorUsedError;

  /// Serializes this ProgressMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressMilestoneCopyWith<ProgressMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressMilestoneCopyWith<$Res> {
  factory $ProgressMilestoneCopyWith(
          ProgressMilestone value, $Res Function(ProgressMilestone) then) =
      _$ProgressMilestoneCopyWithImpl<$Res, ProgressMilestone>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime targetDate,
      double targetValue,
      String unit,
      bool achieved,
      DateTime? achievedDate,
      String? celebrationMessage});
}

/// @nodoc
class _$ProgressMilestoneCopyWithImpl<$Res, $Val extends ProgressMilestone>
    implements $ProgressMilestoneCopyWith<$Res> {
  _$ProgressMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? targetDate = null,
    Object? targetValue = null,
    Object? unit = null,
    Object? achieved = null,
    Object? achievedDate = freezed,
    Object? celebrationMessage = freezed,
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
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      achievedDate: freezed == achievedDate
          ? _value.achievedDate
          : achievedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      celebrationMessage: freezed == celebrationMessage
          ? _value.celebrationMessage
          : celebrationMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressMilestoneImplCopyWith<$Res>
    implements $ProgressMilestoneCopyWith<$Res> {
  factory _$$ProgressMilestoneImplCopyWith(_$ProgressMilestoneImpl value,
          $Res Function(_$ProgressMilestoneImpl) then) =
      __$$ProgressMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime targetDate,
      double targetValue,
      String unit,
      bool achieved,
      DateTime? achievedDate,
      String? celebrationMessage});
}

/// @nodoc
class __$$ProgressMilestoneImplCopyWithImpl<$Res>
    extends _$ProgressMilestoneCopyWithImpl<$Res, _$ProgressMilestoneImpl>
    implements _$$ProgressMilestoneImplCopyWith<$Res> {
  __$$ProgressMilestoneImplCopyWithImpl(_$ProgressMilestoneImpl _value,
      $Res Function(_$ProgressMilestoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? targetDate = null,
    Object? targetValue = null,
    Object? unit = null,
    Object? achieved = null,
    Object? achievedDate = freezed,
    Object? celebrationMessage = freezed,
  }) {
    return _then(_$ProgressMilestoneImpl(
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
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as bool,
      achievedDate: freezed == achievedDate
          ? _value.achievedDate
          : achievedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      celebrationMessage: freezed == celebrationMessage
          ? _value.celebrationMessage
          : celebrationMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressMilestoneImpl implements _ProgressMilestone {
  const _$ProgressMilestoneImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.targetDate,
      required this.targetValue,
      required this.unit,
      this.achieved = false,
      this.achievedDate,
      this.celebrationMessage});

  factory _$ProgressMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressMilestoneImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime targetDate;
  @override
  final double targetValue;
  @override
  final String unit;
  @override
  @JsonKey()
  final bool achieved;
  @override
  final DateTime? achievedDate;
  @override
  final String? celebrationMessage;

  @override
  String toString() {
    return 'ProgressMilestone(id: $id, title: $title, description: $description, targetDate: $targetDate, targetValue: $targetValue, unit: $unit, achieved: $achieved, achievedDate: $achievedDate, celebrationMessage: $celebrationMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressMilestoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.achievedDate, achievedDate) ||
                other.achievedDate == achievedDate) &&
            (identical(other.celebrationMessage, celebrationMessage) ||
                other.celebrationMessage == celebrationMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      targetDate,
      targetValue,
      unit,
      achieved,
      achievedDate,
      celebrationMessage);

  /// Create a copy of ProgressMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressMilestoneImplCopyWith<_$ProgressMilestoneImpl> get copyWith =>
      __$$ProgressMilestoneImplCopyWithImpl<_$ProgressMilestoneImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressMilestoneImplToJson(
      this,
    );
  }
}

abstract class _ProgressMilestone implements ProgressMilestone {
  const factory _ProgressMilestone(
      {required final String id,
      required final String title,
      required final String description,
      required final DateTime targetDate,
      required final double targetValue,
      required final String unit,
      final bool achieved,
      final DateTime? achievedDate,
      final String? celebrationMessage}) = _$ProgressMilestoneImpl;

  factory _ProgressMilestone.fromJson(Map<String, dynamic> json) =
      _$ProgressMilestoneImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get targetDate;
  @override
  double get targetValue;
  @override
  String get unit;
  @override
  bool get achieved;
  @override
  DateTime? get achievedDate;
  @override
  String? get celebrationMessage;

  /// Create a copy of ProgressMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressMilestoneImplCopyWith<_$ProgressMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTReminder _$NRTReminderFromJson(Map<String, dynamic> json) {
  return _NRTReminder.fromJson(json);
}

/// @nodoc
mixin _$NRTReminder {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  NRTReminderType get type => throw _privateConstructorUsedError;
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get userResponse => throw _privateConstructorUsedError;

  /// Serializes this NRTReminder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTReminderCopyWith<NRTReminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTReminderCopyWith<$Res> {
  factory $NRTReminderCopyWith(
          NRTReminder value, $Res Function(NRTReminder) then) =
      _$NRTReminderCopyWithImpl<$Res, NRTReminder>;
  @useResult
  $Res call(
      {String id,
      String userId,
      NRTReminderType type,
      DateTime scheduledTime,
      String message,
      bool isActive,
      bool isCompleted,
      DateTime? completedAt,
      String? userResponse});
}

/// @nodoc
class _$NRTReminderCopyWithImpl<$Res, $Val extends NRTReminder>
    implements $NRTReminderCopyWith<$Res> {
  _$NRTReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? scheduledTime = null,
    Object? message = null,
    Object? isActive = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? userResponse = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NRTReminderType,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userResponse: freezed == userResponse
          ? _value.userResponse
          : userResponse // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTReminderImplCopyWith<$Res>
    implements $NRTReminderCopyWith<$Res> {
  factory _$$NRTReminderImplCopyWith(
          _$NRTReminderImpl value, $Res Function(_$NRTReminderImpl) then) =
      __$$NRTReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NRTReminderType type,
      DateTime scheduledTime,
      String message,
      bool isActive,
      bool isCompleted,
      DateTime? completedAt,
      String? userResponse});
}

/// @nodoc
class __$$NRTReminderImplCopyWithImpl<$Res>
    extends _$NRTReminderCopyWithImpl<$Res, _$NRTReminderImpl>
    implements _$$NRTReminderImplCopyWith<$Res> {
  __$$NRTReminderImplCopyWithImpl(
      _$NRTReminderImpl _value, $Res Function(_$NRTReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? scheduledTime = null,
    Object? message = null,
    Object? isActive = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? userResponse = freezed,
  }) {
    return _then(_$NRTReminderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NRTReminderType,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userResponse: freezed == userResponse
          ? _value.userResponse
          : userResponse // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTReminderImpl implements _NRTReminder {
  const _$NRTReminderImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.scheduledTime,
      required this.message,
      this.isActive = true,
      this.isCompleted = false,
      this.completedAt,
      this.userResponse});

  factory _$NRTReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTReminderImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final NRTReminderType type;
  @override
  final DateTime scheduledTime;
  @override
  final String message;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final String? userResponse;

  @override
  String toString() {
    return 'NRTReminder(id: $id, userId: $userId, type: $type, scheduledTime: $scheduledTime, message: $message, isActive: $isActive, isCompleted: $isCompleted, completedAt: $completedAt, userResponse: $userResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTReminderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.userResponse, userResponse) ||
                other.userResponse == userResponse));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, type, scheduledTime,
      message, isActive, isCompleted, completedAt, userResponse);

  /// Create a copy of NRTReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTReminderImplCopyWith<_$NRTReminderImpl> get copyWith =>
      __$$NRTReminderImplCopyWithImpl<_$NRTReminderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTReminderImplToJson(
      this,
    );
  }
}

abstract class _NRTReminder implements NRTReminder {
  const factory _NRTReminder(
      {required final String id,
      required final String userId,
      required final NRTReminderType type,
      required final DateTime scheduledTime,
      required final String message,
      final bool isActive,
      final bool isCompleted,
      final DateTime? completedAt,
      final String? userResponse}) = _$NRTReminderImpl;

  factory _NRTReminder.fromJson(Map<String, dynamic> json) =
      _$NRTReminderImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  NRTReminderType get type;
  @override
  DateTime get scheduledTime;
  @override
  String get message;
  @override
  bool get isActive;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  String? get userResponse;

  /// Create a copy of NRTReminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTReminderImplCopyWith<_$NRTReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawalSymptom _$WithdrawalSymptomFromJson(Map<String, dynamic> json) {
  return _WithdrawalSymptom.fromJson(json);
}

/// @nodoc
mixin _$WithdrawalSymptom {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  WithdrawalSymptomType get type => throw _privateConstructorUsedError;
  int get severity => throw _privateConstructorUsedError; // 1-10 scale
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get triggers => throw _privateConstructorUsedError;
  String? get copingStrategy => throw _privateConstructorUsedError;

  /// Serializes this WithdrawalSymptom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WithdrawalSymptom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawalSymptomCopyWith<WithdrawalSymptom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawalSymptomCopyWith<$Res> {
  factory $WithdrawalSymptomCopyWith(
          WithdrawalSymptom value, $Res Function(WithdrawalSymptom) then) =
      _$WithdrawalSymptomCopyWithImpl<$Res, WithdrawalSymptom>;
  @useResult
  $Res call(
      {String id,
      String userId,
      WithdrawalSymptomType type,
      int severity,
      DateTime timestamp,
      String? notes,
      String? triggers,
      String? copingStrategy});
}

/// @nodoc
class _$WithdrawalSymptomCopyWithImpl<$Res, $Val extends WithdrawalSymptom>
    implements $WithdrawalSymptomCopyWith<$Res> {
  _$WithdrawalSymptomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WithdrawalSymptom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? severity = null,
    Object? timestamp = null,
    Object? notes = freezed,
    Object? triggers = freezed,
    Object? copingStrategy = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WithdrawalSymptomType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      triggers: freezed == triggers
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as String?,
      copingStrategy: freezed == copingStrategy
          ? _value.copingStrategy
          : copingStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawalSymptomImplCopyWith<$Res>
    implements $WithdrawalSymptomCopyWith<$Res> {
  factory _$$WithdrawalSymptomImplCopyWith(_$WithdrawalSymptomImpl value,
          $Res Function(_$WithdrawalSymptomImpl) then) =
      __$$WithdrawalSymptomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      WithdrawalSymptomType type,
      int severity,
      DateTime timestamp,
      String? notes,
      String? triggers,
      String? copingStrategy});
}

/// @nodoc
class __$$WithdrawalSymptomImplCopyWithImpl<$Res>
    extends _$WithdrawalSymptomCopyWithImpl<$Res, _$WithdrawalSymptomImpl>
    implements _$$WithdrawalSymptomImplCopyWith<$Res> {
  __$$WithdrawalSymptomImplCopyWithImpl(_$WithdrawalSymptomImpl _value,
      $Res Function(_$WithdrawalSymptomImpl) _then)
      : super(_value, _then);

  /// Create a copy of WithdrawalSymptom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? severity = null,
    Object? timestamp = null,
    Object? notes = freezed,
    Object? triggers = freezed,
    Object? copingStrategy = freezed,
  }) {
    return _then(_$WithdrawalSymptomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WithdrawalSymptomType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      triggers: freezed == triggers
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as String?,
      copingStrategy: freezed == copingStrategy
          ? _value.copingStrategy
          : copingStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawalSymptomImpl implements _WithdrawalSymptom {
  const _$WithdrawalSymptomImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.severity,
      required this.timestamp,
      this.notes,
      this.triggers,
      this.copingStrategy});

  factory _$WithdrawalSymptomImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawalSymptomImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final WithdrawalSymptomType type;
  @override
  final int severity;
// 1-10 scale
  @override
  final DateTime timestamp;
  @override
  final String? notes;
  @override
  final String? triggers;
  @override
  final String? copingStrategy;

  @override
  String toString() {
    return 'WithdrawalSymptom(id: $id, userId: $userId, type: $type, severity: $severity, timestamp: $timestamp, notes: $notes, triggers: $triggers, copingStrategy: $copingStrategy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawalSymptomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.triggers, triggers) ||
                other.triggers == triggers) &&
            (identical(other.copingStrategy, copingStrategy) ||
                other.copingStrategy == copingStrategy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, type, severity,
      timestamp, notes, triggers, copingStrategy);

  /// Create a copy of WithdrawalSymptom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawalSymptomImplCopyWith<_$WithdrawalSymptomImpl> get copyWith =>
      __$$WithdrawalSymptomImplCopyWithImpl<_$WithdrawalSymptomImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawalSymptomImplToJson(
      this,
    );
  }
}

abstract class _WithdrawalSymptom implements WithdrawalSymptom {
  const factory _WithdrawalSymptom(
      {required final String id,
      required final String userId,
      required final WithdrawalSymptomType type,
      required final int severity,
      required final DateTime timestamp,
      final String? notes,
      final String? triggers,
      final String? copingStrategy}) = _$WithdrawalSymptomImpl;

  factory _WithdrawalSymptom.fromJson(Map<String, dynamic> json) =
      _$WithdrawalSymptomImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  WithdrawalSymptomType get type;
  @override
  int get severity; // 1-10 scale
  @override
  DateTime get timestamp;
  @override
  String? get notes;
  @override
  String? get triggers;
  @override
  String? get copingStrategy;

  /// Create a copy of WithdrawalSymptom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawalSymptomImplCopyWith<_$WithdrawalSymptomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SymptomResponse _$SymptomResponseFromJson(Map<String, dynamic> json) {
  return _SymptomResponse.fromJson(json);
}

/// @nodoc
mixin _$SymptomResponse {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  WithdrawalSymptom get symptom => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<String> get copingStrategies => throw _privateConstructorUsedError;
  List<String> get evidenceSources => throw _privateConstructorUsedError;
  bool get requiresImmediateAction => throw _privateConstructorUsedError;
  bool get requiresMedicalAttention => throw _privateConstructorUsedError;
  DateTime? get followUpDate => throw _privateConstructorUsedError;

  /// Serializes this SymptomResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SymptomResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SymptomResponseCopyWith<SymptomResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymptomResponseCopyWith<$Res> {
  factory $SymptomResponseCopyWith(
          SymptomResponse value, $Res Function(SymptomResponse) then) =
      _$SymptomResponseCopyWithImpl<$Res, SymptomResponse>;
  @useResult
  $Res call(
      {String id,
      String userId,
      WithdrawalSymptom symptom,
      String message,
      List<String> copingStrategies,
      List<String> evidenceSources,
      bool requiresImmediateAction,
      bool requiresMedicalAttention,
      DateTime? followUpDate});

  $WithdrawalSymptomCopyWith<$Res> get symptom;
}

/// @nodoc
class _$SymptomResponseCopyWithImpl<$Res, $Val extends SymptomResponse>
    implements $SymptomResponseCopyWith<$Res> {
  _$SymptomResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SymptomResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? symptom = null,
    Object? message = null,
    Object? copingStrategies = null,
    Object? evidenceSources = null,
    Object? requiresImmediateAction = null,
    Object? requiresMedicalAttention = null,
    Object? followUpDate = freezed,
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
      symptom: null == symptom
          ? _value.symptom
          : symptom // ignore: cast_nullable_to_non_nullable
              as WithdrawalSymptom,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      copingStrategies: null == copingStrategies
          ? _value.copingStrategies
          : copingStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      evidenceSources: null == evidenceSources
          ? _value.evidenceSources
          : evidenceSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiresImmediateAction: null == requiresImmediateAction
          ? _value.requiresImmediateAction
          : requiresImmediateAction // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresMedicalAttention: null == requiresMedicalAttention
          ? _value.requiresMedicalAttention
          : requiresMedicalAttention // ignore: cast_nullable_to_non_nullable
              as bool,
      followUpDate: freezed == followUpDate
          ? _value.followUpDate
          : followUpDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of SymptomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WithdrawalSymptomCopyWith<$Res> get symptom {
    return $WithdrawalSymptomCopyWith<$Res>(_value.symptom, (value) {
      return _then(_value.copyWith(symptom: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SymptomResponseImplCopyWith<$Res>
    implements $SymptomResponseCopyWith<$Res> {
  factory _$$SymptomResponseImplCopyWith(_$SymptomResponseImpl value,
          $Res Function(_$SymptomResponseImpl) then) =
      __$$SymptomResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      WithdrawalSymptom symptom,
      String message,
      List<String> copingStrategies,
      List<String> evidenceSources,
      bool requiresImmediateAction,
      bool requiresMedicalAttention,
      DateTime? followUpDate});

  @override
  $WithdrawalSymptomCopyWith<$Res> get symptom;
}

/// @nodoc
class __$$SymptomResponseImplCopyWithImpl<$Res>
    extends _$SymptomResponseCopyWithImpl<$Res, _$SymptomResponseImpl>
    implements _$$SymptomResponseImplCopyWith<$Res> {
  __$$SymptomResponseImplCopyWithImpl(
      _$SymptomResponseImpl _value, $Res Function(_$SymptomResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SymptomResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? symptom = null,
    Object? message = null,
    Object? copingStrategies = null,
    Object? evidenceSources = null,
    Object? requiresImmediateAction = null,
    Object? requiresMedicalAttention = null,
    Object? followUpDate = freezed,
  }) {
    return _then(_$SymptomResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      symptom: null == symptom
          ? _value.symptom
          : symptom // ignore: cast_nullable_to_non_nullable
              as WithdrawalSymptom,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      copingStrategies: null == copingStrategies
          ? _value._copingStrategies
          : copingStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      evidenceSources: null == evidenceSources
          ? _value._evidenceSources
          : evidenceSources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiresImmediateAction: null == requiresImmediateAction
          ? _value.requiresImmediateAction
          : requiresImmediateAction // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresMedicalAttention: null == requiresMedicalAttention
          ? _value.requiresMedicalAttention
          : requiresMedicalAttention // ignore: cast_nullable_to_non_nullable
              as bool,
      followUpDate: freezed == followUpDate
          ? _value.followUpDate
          : followUpDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SymptomResponseImpl implements _SymptomResponse {
  const _$SymptomResponseImpl(
      {required this.id,
      required this.userId,
      required this.symptom,
      required this.message,
      required final List<String> copingStrategies,
      required final List<String> evidenceSources,
      this.requiresImmediateAction = false,
      this.requiresMedicalAttention = false,
      this.followUpDate})
      : _copingStrategies = copingStrategies,
        _evidenceSources = evidenceSources;

  factory _$SymptomResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SymptomResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final WithdrawalSymptom symptom;
  @override
  final String message;
  final List<String> _copingStrategies;
  @override
  List<String> get copingStrategies {
    if (_copingStrategies is EqualUnmodifiableListView)
      return _copingStrategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_copingStrategies);
  }

  final List<String> _evidenceSources;
  @override
  List<String> get evidenceSources {
    if (_evidenceSources is EqualUnmodifiableListView) return _evidenceSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceSources);
  }

  @override
  @JsonKey()
  final bool requiresImmediateAction;
  @override
  @JsonKey()
  final bool requiresMedicalAttention;
  @override
  final DateTime? followUpDate;

  @override
  String toString() {
    return 'SymptomResponse(id: $id, userId: $userId, symptom: $symptom, message: $message, copingStrategies: $copingStrategies, evidenceSources: $evidenceSources, requiresImmediateAction: $requiresImmediateAction, requiresMedicalAttention: $requiresMedicalAttention, followUpDate: $followUpDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.symptom, symptom) || other.symptom == symptom) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._copingStrategies, _copingStrategies) &&
            const DeepCollectionEquality()
                .equals(other._evidenceSources, _evidenceSources) &&
            (identical(
                    other.requiresImmediateAction, requiresImmediateAction) ||
                other.requiresImmediateAction == requiresImmediateAction) &&
            (identical(
                    other.requiresMedicalAttention, requiresMedicalAttention) ||
                other.requiresMedicalAttention == requiresMedicalAttention) &&
            (identical(other.followUpDate, followUpDate) ||
                other.followUpDate == followUpDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      symptom,
      message,
      const DeepCollectionEquality().hash(_copingStrategies),
      const DeepCollectionEquality().hash(_evidenceSources),
      requiresImmediateAction,
      requiresMedicalAttention,
      followUpDate);

  /// Create a copy of SymptomResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SymptomResponseImplCopyWith<_$SymptomResponseImpl> get copyWith =>
      __$$SymptomResponseImplCopyWithImpl<_$SymptomResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SymptomResponseImplToJson(
      this,
    );
  }
}

abstract class _SymptomResponse implements SymptomResponse {
  const factory _SymptomResponse(
      {required final String id,
      required final String userId,
      required final WithdrawalSymptom symptom,
      required final String message,
      required final List<String> copingStrategies,
      required final List<String> evidenceSources,
      final bool requiresImmediateAction,
      final bool requiresMedicalAttention,
      final DateTime? followUpDate}) = _$SymptomResponseImpl;

  factory _SymptomResponse.fromJson(Map<String, dynamic> json) =
      _$SymptomResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  WithdrawalSymptom get symptom;
  @override
  String get message;
  @override
  List<String> get copingStrategies;
  @override
  List<String> get evidenceSources;
  @override
  bool get requiresImmediateAction;
  @override
  bool get requiresMedicalAttention;
  @override
  DateTime? get followUpDate;

  /// Create a copy of SymptomResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SymptomResponseImplCopyWith<_$SymptomResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTDosageRecommendation _$NRTDosageRecommendationFromJson(
    Map<String, dynamic> json) {
  return _NRTDosageRecommendation.fromJson(json);
}

/// @nodoc
mixin _$NRTDosageRecommendation {
  String get recommendedDosage => throw _privateConstructorUsedError;
  String get adjustment =>
      throw _privateConstructorUsedError; // increase, decrease, maintain
  double get confidence => throw _privateConstructorUsedError; // 0.0 to 1.0
  String get reasoning => throw _privateConstructorUsedError;
  DateTime get nextReviewDate => throw _privateConstructorUsedError;
  List<String>? get warnings => throw _privateConstructorUsedError;
  List<String>? get supportingEvidence => throw _privateConstructorUsedError;

  /// Serializes this NRTDosageRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTDosageRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTDosageRecommendationCopyWith<NRTDosageRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTDosageRecommendationCopyWith<$Res> {
  factory $NRTDosageRecommendationCopyWith(NRTDosageRecommendation value,
          $Res Function(NRTDosageRecommendation) then) =
      _$NRTDosageRecommendationCopyWithImpl<$Res, NRTDosageRecommendation>;
  @useResult
  $Res call(
      {String recommendedDosage,
      String adjustment,
      double confidence,
      String reasoning,
      DateTime nextReviewDate,
      List<String>? warnings,
      List<String>? supportingEvidence});
}

/// @nodoc
class _$NRTDosageRecommendationCopyWithImpl<$Res,
        $Val extends NRTDosageRecommendation>
    implements $NRTDosageRecommendationCopyWith<$Res> {
  _$NRTDosageRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTDosageRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendedDosage = null,
    Object? adjustment = null,
    Object? confidence = null,
    Object? reasoning = null,
    Object? nextReviewDate = null,
    Object? warnings = freezed,
    Object? supportingEvidence = freezed,
  }) {
    return _then(_value.copyWith(
      recommendedDosage: null == recommendedDosage
          ? _value.recommendedDosage
          : recommendedDosage // ignore: cast_nullable_to_non_nullable
              as String,
      adjustment: null == adjustment
          ? _value.adjustment
          : adjustment // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
      nextReviewDate: null == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      warnings: freezed == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      supportingEvidence: freezed == supportingEvidence
          ? _value.supportingEvidence
          : supportingEvidence // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTDosageRecommendationImplCopyWith<$Res>
    implements $NRTDosageRecommendationCopyWith<$Res> {
  factory _$$NRTDosageRecommendationImplCopyWith(
          _$NRTDosageRecommendationImpl value,
          $Res Function(_$NRTDosageRecommendationImpl) then) =
      __$$NRTDosageRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String recommendedDosage,
      String adjustment,
      double confidence,
      String reasoning,
      DateTime nextReviewDate,
      List<String>? warnings,
      List<String>? supportingEvidence});
}

/// @nodoc
class __$$NRTDosageRecommendationImplCopyWithImpl<$Res>
    extends _$NRTDosageRecommendationCopyWithImpl<$Res,
        _$NRTDosageRecommendationImpl>
    implements _$$NRTDosageRecommendationImplCopyWith<$Res> {
  __$$NRTDosageRecommendationImplCopyWithImpl(
      _$NRTDosageRecommendationImpl _value,
      $Res Function(_$NRTDosageRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTDosageRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendedDosage = null,
    Object? adjustment = null,
    Object? confidence = null,
    Object? reasoning = null,
    Object? nextReviewDate = null,
    Object? warnings = freezed,
    Object? supportingEvidence = freezed,
  }) {
    return _then(_$NRTDosageRecommendationImpl(
      recommendedDosage: null == recommendedDosage
          ? _value.recommendedDosage
          : recommendedDosage // ignore: cast_nullable_to_non_nullable
              as String,
      adjustment: null == adjustment
          ? _value.adjustment
          : adjustment // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
      nextReviewDate: null == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      warnings: freezed == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      supportingEvidence: freezed == supportingEvidence
          ? _value._supportingEvidence
          : supportingEvidence // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTDosageRecommendationImpl implements _NRTDosageRecommendation {
  const _$NRTDosageRecommendationImpl(
      {required this.recommendedDosage,
      required this.adjustment,
      required this.confidence,
      required this.reasoning,
      required this.nextReviewDate,
      final List<String>? warnings,
      final List<String>? supportingEvidence})
      : _warnings = warnings,
        _supportingEvidence = supportingEvidence;

  factory _$NRTDosageRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTDosageRecommendationImplFromJson(json);

  @override
  final String recommendedDosage;
  @override
  final String adjustment;
// increase, decrease, maintain
  @override
  final double confidence;
// 0.0 to 1.0
  @override
  final String reasoning;
  @override
  final DateTime nextReviewDate;
  final List<String>? _warnings;
  @override
  List<String>? get warnings {
    final value = _warnings;
    if (value == null) return null;
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _supportingEvidence;
  @override
  List<String>? get supportingEvidence {
    final value = _supportingEvidence;
    if (value == null) return null;
    if (_supportingEvidence is EqualUnmodifiableListView)
      return _supportingEvidence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NRTDosageRecommendation(recommendedDosage: $recommendedDosage, adjustment: $adjustment, confidence: $confidence, reasoning: $reasoning, nextReviewDate: $nextReviewDate, warnings: $warnings, supportingEvidence: $supportingEvidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTDosageRecommendationImpl &&
            (identical(other.recommendedDosage, recommendedDosage) ||
                other.recommendedDosage == recommendedDosage) &&
            (identical(other.adjustment, adjustment) ||
                other.adjustment == adjustment) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning) &&
            (identical(other.nextReviewDate, nextReviewDate) ||
                other.nextReviewDate == nextReviewDate) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            const DeepCollectionEquality()
                .equals(other._supportingEvidence, _supportingEvidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      recommendedDosage,
      adjustment,
      confidence,
      reasoning,
      nextReviewDate,
      const DeepCollectionEquality().hash(_warnings),
      const DeepCollectionEquality().hash(_supportingEvidence));

  /// Create a copy of NRTDosageRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTDosageRecommendationImplCopyWith<_$NRTDosageRecommendationImpl>
      get copyWith => __$$NRTDosageRecommendationImplCopyWithImpl<
          _$NRTDosageRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTDosageRecommendationImplToJson(
      this,
    );
  }
}

abstract class _NRTDosageRecommendation implements NRTDosageRecommendation {
  const factory _NRTDosageRecommendation(
      {required final String recommendedDosage,
      required final String adjustment,
      required final double confidence,
      required final String reasoning,
      required final DateTime nextReviewDate,
      final List<String>? warnings,
      final List<String>? supportingEvidence}) = _$NRTDosageRecommendationImpl;

  factory _NRTDosageRecommendation.fromJson(Map<String, dynamic> json) =
      _$NRTDosageRecommendationImpl.fromJson;

  @override
  String get recommendedDosage;
  @override
  String get adjustment; // increase, decrease, maintain
  @override
  double get confidence; // 0.0 to 1.0
  @override
  String get reasoning;
  @override
  DateTime get nextReviewDate;
  @override
  List<String>? get warnings;
  @override
  List<String>? get supportingEvidence;

  /// Create a copy of NRTDosageRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTDosageRecommendationImplCopyWith<_$NRTDosageRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NRTReadinessAssessment _$NRTReadinessAssessmentFromJson(
    Map<String, dynamic> json) {
  return _NRTReadinessAssessment.fromJson(json);
}

/// @nodoc
mixin _$NRTReadinessAssessment {
  bool get isReady => throw _privateConstructorUsedError;
  double get readinessScore => throw _privateConstructorUsedError; // 0.0 to 1.0
  List<String> get reasons => throw _privateConstructorUsedError;
  int get recommendedWaitDays => throw _privateConstructorUsedError;
  List<String>? get preparationSteps => throw _privateConstructorUsedError;
  DateTime? get nextAssessmentDate => throw _privateConstructorUsedError;

  /// Serializes this NRTReadinessAssessment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTReadinessAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTReadinessAssessmentCopyWith<NRTReadinessAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTReadinessAssessmentCopyWith<$Res> {
  factory $NRTReadinessAssessmentCopyWith(NRTReadinessAssessment value,
          $Res Function(NRTReadinessAssessment) then) =
      _$NRTReadinessAssessmentCopyWithImpl<$Res, NRTReadinessAssessment>;
  @useResult
  $Res call(
      {bool isReady,
      double readinessScore,
      List<String> reasons,
      int recommendedWaitDays,
      List<String>? preparationSteps,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class _$NRTReadinessAssessmentCopyWithImpl<$Res,
        $Val extends NRTReadinessAssessment>
    implements $NRTReadinessAssessmentCopyWith<$Res> {
  _$NRTReadinessAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTReadinessAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReady = null,
    Object? readinessScore = null,
    Object? reasons = null,
    Object? recommendedWaitDays = null,
    Object? preparationSteps = freezed,
    Object? nextAssessmentDate = freezed,
  }) {
    return _then(_value.copyWith(
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      readinessScore: null == readinessScore
          ? _value.readinessScore
          : readinessScore // ignore: cast_nullable_to_non_nullable
              as double,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendedWaitDays: null == recommendedWaitDays
          ? _value.recommendedWaitDays
          : recommendedWaitDays // ignore: cast_nullable_to_non_nullable
              as int,
      preparationSteps: freezed == preparationSteps
          ? _value.preparationSteps
          : preparationSteps // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nextAssessmentDate: freezed == nextAssessmentDate
          ? _value.nextAssessmentDate
          : nextAssessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTReadinessAssessmentImplCopyWith<$Res>
    implements $NRTReadinessAssessmentCopyWith<$Res> {
  factory _$$NRTReadinessAssessmentImplCopyWith(
          _$NRTReadinessAssessmentImpl value,
          $Res Function(_$NRTReadinessAssessmentImpl) then) =
      __$$NRTReadinessAssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isReady,
      double readinessScore,
      List<String> reasons,
      int recommendedWaitDays,
      List<String>? preparationSteps,
      DateTime? nextAssessmentDate});
}

/// @nodoc
class __$$NRTReadinessAssessmentImplCopyWithImpl<$Res>
    extends _$NRTReadinessAssessmentCopyWithImpl<$Res,
        _$NRTReadinessAssessmentImpl>
    implements _$$NRTReadinessAssessmentImplCopyWith<$Res> {
  __$$NRTReadinessAssessmentImplCopyWithImpl(
      _$NRTReadinessAssessmentImpl _value,
      $Res Function(_$NRTReadinessAssessmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTReadinessAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReady = null,
    Object? readinessScore = null,
    Object? reasons = null,
    Object? recommendedWaitDays = null,
    Object? preparationSteps = freezed,
    Object? nextAssessmentDate = freezed,
  }) {
    return _then(_$NRTReadinessAssessmentImpl(
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      readinessScore: null == readinessScore
          ? _value.readinessScore
          : readinessScore // ignore: cast_nullable_to_non_nullable
              as double,
      reasons: null == reasons
          ? _value._reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendedWaitDays: null == recommendedWaitDays
          ? _value.recommendedWaitDays
          : recommendedWaitDays // ignore: cast_nullable_to_non_nullable
              as int,
      preparationSteps: freezed == preparationSteps
          ? _value._preparationSteps
          : preparationSteps // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nextAssessmentDate: freezed == nextAssessmentDate
          ? _value.nextAssessmentDate
          : nextAssessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTReadinessAssessmentImpl implements _NRTReadinessAssessment {
  const _$NRTReadinessAssessmentImpl(
      {required this.isReady,
      required this.readinessScore,
      required final List<String> reasons,
      required this.recommendedWaitDays,
      final List<String>? preparationSteps,
      this.nextAssessmentDate})
      : _reasons = reasons,
        _preparationSteps = preparationSteps;

  factory _$NRTReadinessAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTReadinessAssessmentImplFromJson(json);

  @override
  final bool isReady;
  @override
  final double readinessScore;
// 0.0 to 1.0
  final List<String> _reasons;
// 0.0 to 1.0
  @override
  List<String> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

  @override
  final int recommendedWaitDays;
  final List<String>? _preparationSteps;
  @override
  List<String>? get preparationSteps {
    final value = _preparationSteps;
    if (value == null) return null;
    if (_preparationSteps is EqualUnmodifiableListView)
      return _preparationSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? nextAssessmentDate;

  @override
  String toString() {
    return 'NRTReadinessAssessment(isReady: $isReady, readinessScore: $readinessScore, reasons: $reasons, recommendedWaitDays: $recommendedWaitDays, preparationSteps: $preparationSteps, nextAssessmentDate: $nextAssessmentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTReadinessAssessmentImpl &&
            (identical(other.isReady, isReady) || other.isReady == isReady) &&
            (identical(other.readinessScore, readinessScore) ||
                other.readinessScore == readinessScore) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons) &&
            (identical(other.recommendedWaitDays, recommendedWaitDays) ||
                other.recommendedWaitDays == recommendedWaitDays) &&
            const DeepCollectionEquality()
                .equals(other._preparationSteps, _preparationSteps) &&
            (identical(other.nextAssessmentDate, nextAssessmentDate) ||
                other.nextAssessmentDate == nextAssessmentDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isReady,
      readinessScore,
      const DeepCollectionEquality().hash(_reasons),
      recommendedWaitDays,
      const DeepCollectionEquality().hash(_preparationSteps),
      nextAssessmentDate);

  /// Create a copy of NRTReadinessAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTReadinessAssessmentImplCopyWith<_$NRTReadinessAssessmentImpl>
      get copyWith => __$$NRTReadinessAssessmentImplCopyWithImpl<
          _$NRTReadinessAssessmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTReadinessAssessmentImplToJson(
      this,
    );
  }
}

abstract class _NRTReadinessAssessment implements NRTReadinessAssessment {
  const factory _NRTReadinessAssessment(
      {required final bool isReady,
      required final double readinessScore,
      required final List<String> reasons,
      required final int recommendedWaitDays,
      final List<String>? preparationSteps,
      final DateTime? nextAssessmentDate}) = _$NRTReadinessAssessmentImpl;

  factory _NRTReadinessAssessment.fromJson(Map<String, dynamic> json) =
      _$NRTReadinessAssessmentImpl.fromJson;

  @override
  bool get isReady;
  @override
  double get readinessScore; // 0.0 to 1.0
  @override
  List<String> get reasons;
  @override
  int get recommendedWaitDays;
  @override
  List<String>? get preparationSteps;
  @override
  DateTime? get nextAssessmentDate;

  /// Create a copy of NRTReadinessAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTReadinessAssessmentImplCopyWith<_$NRTReadinessAssessmentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UsagePatterns _$UsagePatternsFromJson(Map<String, dynamic> json) {
  return _UsagePatterns.fromJson(json);
}

/// @nodoc
mixin _$UsagePatterns {
  List<int> get preferredTimes =>
      throw _privateConstructorUsedError; // Hours of day (0-23)
  double get averageDaily => throw _privateConstructorUsedError;
  double get consistency => throw _privateConstructorUsedError; // 0.0 to 1.0
  List<String> get triggers => throw _privateConstructorUsedError;
  List<String> get patterns => throw _privateConstructorUsedError;

  /// Serializes this UsagePatterns to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsagePatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsagePatternsCopyWith<UsagePatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsagePatternsCopyWith<$Res> {
  factory $UsagePatternsCopyWith(
          UsagePatterns value, $Res Function(UsagePatterns) then) =
      _$UsagePatternsCopyWithImpl<$Res, UsagePatterns>;
  @useResult
  $Res call(
      {List<int> preferredTimes,
      double averageDaily,
      double consistency,
      List<String> triggers,
      List<String> patterns});
}

/// @nodoc
class _$UsagePatternsCopyWithImpl<$Res, $Val extends UsagePatterns>
    implements $UsagePatternsCopyWith<$Res> {
  _$UsagePatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsagePatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredTimes = null,
    Object? averageDaily = null,
    Object? consistency = null,
    Object? triggers = null,
    Object? patterns = null,
  }) {
    return _then(_value.copyWith(
      preferredTimes: null == preferredTimes
          ? _value.preferredTimes
          : preferredTimes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      averageDaily: null == averageDaily
          ? _value.averageDaily
          : averageDaily // ignore: cast_nullable_to_non_nullable
              as double,
      consistency: null == consistency
          ? _value.consistency
          : consistency // ignore: cast_nullable_to_non_nullable
              as double,
      triggers: null == triggers
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      patterns: null == patterns
          ? _value.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsagePatternsImplCopyWith<$Res>
    implements $UsagePatternsCopyWith<$Res> {
  factory _$$UsagePatternsImplCopyWith(
          _$UsagePatternsImpl value, $Res Function(_$UsagePatternsImpl) then) =
      __$$UsagePatternsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> preferredTimes,
      double averageDaily,
      double consistency,
      List<String> triggers,
      List<String> patterns});
}

/// @nodoc
class __$$UsagePatternsImplCopyWithImpl<$Res>
    extends _$UsagePatternsCopyWithImpl<$Res, _$UsagePatternsImpl>
    implements _$$UsagePatternsImplCopyWith<$Res> {
  __$$UsagePatternsImplCopyWithImpl(
      _$UsagePatternsImpl _value, $Res Function(_$UsagePatternsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsagePatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredTimes = null,
    Object? averageDaily = null,
    Object? consistency = null,
    Object? triggers = null,
    Object? patterns = null,
  }) {
    return _then(_$UsagePatternsImpl(
      preferredTimes: null == preferredTimes
          ? _value._preferredTimes
          : preferredTimes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      averageDaily: null == averageDaily
          ? _value.averageDaily
          : averageDaily // ignore: cast_nullable_to_non_nullable
              as double,
      consistency: null == consistency
          ? _value.consistency
          : consistency // ignore: cast_nullable_to_non_nullable
              as double,
      triggers: null == triggers
          ? _value._triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      patterns: null == patterns
          ? _value._patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsagePatternsImpl implements _UsagePatterns {
  const _$UsagePatternsImpl(
      {required final List<int> preferredTimes,
      required this.averageDaily,
      required this.consistency,
      final List<String> triggers = const [],
      final List<String> patterns = const []})
      : _preferredTimes = preferredTimes,
        _triggers = triggers,
        _patterns = patterns;

  factory _$UsagePatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsagePatternsImplFromJson(json);

  final List<int> _preferredTimes;
  @override
  List<int> get preferredTimes {
    if (_preferredTimes is EqualUnmodifiableListView) return _preferredTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredTimes);
  }

// Hours of day (0-23)
  @override
  final double averageDaily;
  @override
  final double consistency;
// 0.0 to 1.0
  final List<String> _triggers;
// 0.0 to 1.0
  @override
  @JsonKey()
  List<String> get triggers {
    if (_triggers is EqualUnmodifiableListView) return _triggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triggers);
  }

  final List<String> _patterns;
  @override
  @JsonKey()
  List<String> get patterns {
    if (_patterns is EqualUnmodifiableListView) return _patterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_patterns);
  }

  @override
  String toString() {
    return 'UsagePatterns(preferredTimes: $preferredTimes, averageDaily: $averageDaily, consistency: $consistency, triggers: $triggers, patterns: $patterns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsagePatternsImpl &&
            const DeepCollectionEquality()
                .equals(other._preferredTimes, _preferredTimes) &&
            (identical(other.averageDaily, averageDaily) ||
                other.averageDaily == averageDaily) &&
            (identical(other.consistency, consistency) ||
                other.consistency == consistency) &&
            const DeepCollectionEquality().equals(other._triggers, _triggers) &&
            const DeepCollectionEquality().equals(other._patterns, _patterns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_preferredTimes),
      averageDaily,
      consistency,
      const DeepCollectionEquality().hash(_triggers),
      const DeepCollectionEquality().hash(_patterns));

  /// Create a copy of UsagePatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsagePatternsImplCopyWith<_$UsagePatternsImpl> get copyWith =>
      __$$UsagePatternsImplCopyWithImpl<_$UsagePatternsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsagePatternsImplToJson(
      this,
    );
  }
}

abstract class _UsagePatterns implements UsagePatterns {
  const factory _UsagePatterns(
      {required final List<int> preferredTimes,
      required final double averageDaily,
      required final double consistency,
      final List<String> triggers,
      final List<String> patterns}) = _$UsagePatternsImpl;

  factory _UsagePatterns.fromJson(Map<String, dynamic> json) =
      _$UsagePatternsImpl.fromJson;

  @override
  List<int> get preferredTimes; // Hours of day (0-23)
  @override
  double get averageDaily;
  @override
  double get consistency; // 0.0 to 1.0
  @override
  List<String> get triggers;
  @override
  List<String> get patterns;

  /// Create a copy of UsagePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsagePatternsImplCopyWith<_$UsagePatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MedicalEvidence _$MedicalEvidenceFromJson(Map<String, dynamic> json) {
  return _MedicalEvidence.fromJson(json);
}

/// @nodoc
mixin _$MedicalEvidence {
  String get title => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  double get relevanceScore => throw _privateConstructorUsedError; // 0.0 to 1.0
  DateTime get publishedDate => throw _privateConstructorUsedError;
  String? get doi => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this MedicalEvidence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalEvidenceCopyWith<MedicalEvidence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalEvidenceCopyWith<$Res> {
  factory $MedicalEvidenceCopyWith(
          MedicalEvidence value, $Res Function(MedicalEvidence) then) =
      _$MedicalEvidenceCopyWithImpl<$Res, MedicalEvidence>;
  @useResult
  $Res call(
      {String title,
      String source,
      String summary,
      double relevanceScore,
      DateTime publishedDate,
      String? doi,
      String? url});
}

/// @nodoc
class _$MedicalEvidenceCopyWithImpl<$Res, $Val extends MedicalEvidence>
    implements $MedicalEvidenceCopyWith<$Res> {
  _$MedicalEvidenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? source = null,
    Object? summary = null,
    Object? relevanceScore = null,
    Object? publishedDate = null,
    Object? doi = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      publishedDate: null == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      doi: freezed == doi
          ? _value.doi
          : doi // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicalEvidenceImplCopyWith<$Res>
    implements $MedicalEvidenceCopyWith<$Res> {
  factory _$$MedicalEvidenceImplCopyWith(_$MedicalEvidenceImpl value,
          $Res Function(_$MedicalEvidenceImpl) then) =
      __$$MedicalEvidenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String source,
      String summary,
      double relevanceScore,
      DateTime publishedDate,
      String? doi,
      String? url});
}

/// @nodoc
class __$$MedicalEvidenceImplCopyWithImpl<$Res>
    extends _$MedicalEvidenceCopyWithImpl<$Res, _$MedicalEvidenceImpl>
    implements _$$MedicalEvidenceImplCopyWith<$Res> {
  __$$MedicalEvidenceImplCopyWithImpl(
      _$MedicalEvidenceImpl _value, $Res Function(_$MedicalEvidenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicalEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? source = null,
    Object? summary = null,
    Object? relevanceScore = null,
    Object? publishedDate = null,
    Object? doi = freezed,
    Object? url = freezed,
  }) {
    return _then(_$MedicalEvidenceImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      publishedDate: null == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      doi: freezed == doi
          ? _value.doi
          : doi // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicalEvidenceImpl implements _MedicalEvidence {
  const _$MedicalEvidenceImpl(
      {required this.title,
      required this.source,
      required this.summary,
      required this.relevanceScore,
      required this.publishedDate,
      this.doi,
      this.url});

  factory _$MedicalEvidenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalEvidenceImplFromJson(json);

  @override
  final String title;
  @override
  final String source;
  @override
  final String summary;
  @override
  final double relevanceScore;
// 0.0 to 1.0
  @override
  final DateTime publishedDate;
  @override
  final String? doi;
  @override
  final String? url;

  @override
  String toString() {
    return 'MedicalEvidence(title: $title, source: $source, summary: $summary, relevanceScore: $relevanceScore, publishedDate: $publishedDate, doi: $doi, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalEvidenceImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore) &&
            (identical(other.publishedDate, publishedDate) ||
                other.publishedDate == publishedDate) &&
            (identical(other.doi, doi) || other.doi == doi) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, source, summary,
      relevanceScore, publishedDate, doi, url);

  /// Create a copy of MedicalEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalEvidenceImplCopyWith<_$MedicalEvidenceImpl> get copyWith =>
      __$$MedicalEvidenceImplCopyWithImpl<_$MedicalEvidenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalEvidenceImplToJson(
      this,
    );
  }
}

abstract class _MedicalEvidence implements MedicalEvidence {
  const factory _MedicalEvidence(
      {required final String title,
      required final String source,
      required final String summary,
      required final double relevanceScore,
      required final DateTime publishedDate,
      final String? doi,
      final String? url}) = _$MedicalEvidenceImpl;

  factory _MedicalEvidence.fromJson(Map<String, dynamic> json) =
      _$MedicalEvidenceImpl.fromJson;

  @override
  String get title;
  @override
  String get source;
  @override
  String get summary;
  @override
  double get relevanceScore; // 0.0 to 1.0
  @override
  DateTime get publishedDate;
  @override
  String? get doi;
  @override
  String? get url;

  /// Create a copy of MedicalEvidence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalEvidenceImplCopyWith<_$MedicalEvidenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTSafetyAlert _$NRTSafetyAlertFromJson(Map<String, dynamic> json) {
  return _NRTSafetyAlert.fromJson(json);
}

/// @nodoc
mixin _$NRTSafetyAlert {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  NRTSafetyAlertType get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  NRTSafetyAlertSeverity get severity => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get acknowledged => throw _privateConstructorUsedError;
  DateTime? get acknowledgedAt => throw _privateConstructorUsedError;
  String? get userResponse => throw _privateConstructorUsedError;

  /// Serializes this NRTSafetyAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTSafetyAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTSafetyAlertCopyWith<NRTSafetyAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTSafetyAlertCopyWith<$Res> {
  factory $NRTSafetyAlertCopyWith(
          NRTSafetyAlert value, $Res Function(NRTSafetyAlert) then) =
      _$NRTSafetyAlertCopyWithImpl<$Res, NRTSafetyAlert>;
  @useResult
  $Res call(
      {String id,
      String userId,
      NRTSafetyAlertType type,
      String message,
      NRTSafetyAlertSeverity severity,
      DateTime createdAt,
      bool acknowledged,
      DateTime? acknowledgedAt,
      String? userResponse});
}

/// @nodoc
class _$NRTSafetyAlertCopyWithImpl<$Res, $Val extends NRTSafetyAlert>
    implements $NRTSafetyAlertCopyWith<$Res> {
  _$NRTSafetyAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTSafetyAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = null,
    Object? acknowledged = null,
    Object? acknowledgedAt = freezed,
    Object? userResponse = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NRTSafetyAlertType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as NRTSafetyAlertSeverity,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userResponse: freezed == userResponse
          ? _value.userResponse
          : userResponse // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTSafetyAlertImplCopyWith<$Res>
    implements $NRTSafetyAlertCopyWith<$Res> {
  factory _$$NRTSafetyAlertImplCopyWith(_$NRTSafetyAlertImpl value,
          $Res Function(_$NRTSafetyAlertImpl) then) =
      __$$NRTSafetyAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NRTSafetyAlertType type,
      String message,
      NRTSafetyAlertSeverity severity,
      DateTime createdAt,
      bool acknowledged,
      DateTime? acknowledgedAt,
      String? userResponse});
}

/// @nodoc
class __$$NRTSafetyAlertImplCopyWithImpl<$Res>
    extends _$NRTSafetyAlertCopyWithImpl<$Res, _$NRTSafetyAlertImpl>
    implements _$$NRTSafetyAlertImplCopyWith<$Res> {
  __$$NRTSafetyAlertImplCopyWithImpl(
      _$NRTSafetyAlertImpl _value, $Res Function(_$NRTSafetyAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTSafetyAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = null,
    Object? acknowledged = null,
    Object? acknowledgedAt = freezed,
    Object? userResponse = freezed,
  }) {
    return _then(_$NRTSafetyAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NRTSafetyAlertType,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as NRTSafetyAlertSeverity,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userResponse: freezed == userResponse
          ? _value.userResponse
          : userResponse // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTSafetyAlertImpl implements _NRTSafetyAlert {
  const _$NRTSafetyAlertImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.message,
      required this.severity,
      required this.createdAt,
      this.acknowledged = false,
      this.acknowledgedAt,
      this.userResponse});

  factory _$NRTSafetyAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTSafetyAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final NRTSafetyAlertType type;
  @override
  final String message;
  @override
  final NRTSafetyAlertSeverity severity;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool acknowledged;
  @override
  final DateTime? acknowledgedAt;
  @override
  final String? userResponse;

  @override
  String toString() {
    return 'NRTSafetyAlert(id: $id, userId: $userId, type: $type, message: $message, severity: $severity, createdAt: $createdAt, acknowledged: $acknowledged, acknowledgedAt: $acknowledgedAt, userResponse: $userResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTSafetyAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.acknowledgedAt, acknowledgedAt) ||
                other.acknowledgedAt == acknowledgedAt) &&
            (identical(other.userResponse, userResponse) ||
                other.userResponse == userResponse));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, type, message,
      severity, createdAt, acknowledged, acknowledgedAt, userResponse);

  /// Create a copy of NRTSafetyAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTSafetyAlertImplCopyWith<_$NRTSafetyAlertImpl> get copyWith =>
      __$$NRTSafetyAlertImplCopyWithImpl<_$NRTSafetyAlertImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTSafetyAlertImplToJson(
      this,
    );
  }
}

abstract class _NRTSafetyAlert implements NRTSafetyAlert {
  const factory _NRTSafetyAlert(
      {required final String id,
      required final String userId,
      required final NRTSafetyAlertType type,
      required final String message,
      required final NRTSafetyAlertSeverity severity,
      required final DateTime createdAt,
      final bool acknowledged,
      final DateTime? acknowledgedAt,
      final String? userResponse}) = _$NRTSafetyAlertImpl;

  factory _NRTSafetyAlert.fromJson(Map<String, dynamic> json) =
      _$NRTSafetyAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  NRTSafetyAlertType get type;
  @override
  String get message;
  @override
  NRTSafetyAlertSeverity get severity;
  @override
  DateTime get createdAt;
  @override
  bool get acknowledged;
  @override
  DateTime? get acknowledgedAt;
  @override
  String? get userResponse;

  /// Create a copy of NRTSafetyAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTSafetyAlertImplCopyWith<_$NRTSafetyAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTProgressReport _$NRTProgressReportFromJson(Map<String, dynamic> json) {
  return _NRTProgressReport.fromJson(json);
}

/// @nodoc
mixin _$NRTProgressReport {
  String get userId => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  NRTProgressSummary get summary => throw _privateConstructorUsedError;
  List<NRTProgressMetric> get metrics => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  double get overallScore => throw _privateConstructorUsedError; // 0.0 to 1.0
  DateTime? get nextReviewDate => throw _privateConstructorUsedError;

  /// Serializes this NRTProgressReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTProgressReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTProgressReportCopyWith<NRTProgressReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTProgressReportCopyWith<$Res> {
  factory $NRTProgressReportCopyWith(
          NRTProgressReport value, $Res Function(NRTProgressReport) then) =
      _$NRTProgressReportCopyWithImpl<$Res, NRTProgressReport>;
  @useResult
  $Res call(
      {String userId,
      DateTime generatedAt,
      NRTProgressSummary summary,
      List<NRTProgressMetric> metrics,
      List<String> achievements,
      List<String> recommendations,
      double overallScore,
      DateTime? nextReviewDate});

  $NRTProgressSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$NRTProgressReportCopyWithImpl<$Res, $Val extends NRTProgressReport>
    implements $NRTProgressReportCopyWith<$Res> {
  _$NRTProgressReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTProgressReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? generatedAt = null,
    Object? summary = null,
    Object? metrics = null,
    Object? achievements = null,
    Object? recommendations = null,
    Object? overallScore = null,
    Object? nextReviewDate = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as NRTProgressSummary,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as List<NRTProgressMetric>,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of NRTProgressReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NRTProgressSummaryCopyWith<$Res> get summary {
    return $NRTProgressSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NRTProgressReportImplCopyWith<$Res>
    implements $NRTProgressReportCopyWith<$Res> {
  factory _$$NRTProgressReportImplCopyWith(_$NRTProgressReportImpl value,
          $Res Function(_$NRTProgressReportImpl) then) =
      __$$NRTProgressReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime generatedAt,
      NRTProgressSummary summary,
      List<NRTProgressMetric> metrics,
      List<String> achievements,
      List<String> recommendations,
      double overallScore,
      DateTime? nextReviewDate});

  @override
  $NRTProgressSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$NRTProgressReportImplCopyWithImpl<$Res>
    extends _$NRTProgressReportCopyWithImpl<$Res, _$NRTProgressReportImpl>
    implements _$$NRTProgressReportImplCopyWith<$Res> {
  __$$NRTProgressReportImplCopyWithImpl(_$NRTProgressReportImpl _value,
      $Res Function(_$NRTProgressReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTProgressReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? generatedAt = null,
    Object? summary = null,
    Object? metrics = null,
    Object? achievements = null,
    Object? recommendations = null,
    Object? overallScore = null,
    Object? nextReviewDate = freezed,
  }) {
    return _then(_$NRTProgressReportImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as NRTProgressSummary,
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as List<NRTProgressMetric>,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTProgressReportImpl implements _NRTProgressReport {
  const _$NRTProgressReportImpl(
      {required this.userId,
      required this.generatedAt,
      required this.summary,
      required final List<NRTProgressMetric> metrics,
      required final List<String> achievements,
      required final List<String> recommendations,
      required this.overallScore,
      this.nextReviewDate})
      : _metrics = metrics,
        _achievements = achievements,
        _recommendations = recommendations;

  factory _$NRTProgressReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTProgressReportImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime generatedAt;
  @override
  final NRTProgressSummary summary;
  final List<NRTProgressMetric> _metrics;
  @override
  List<NRTProgressMetric> get metrics {
    if (_metrics is EqualUnmodifiableListView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metrics);
  }

  final List<String> _achievements;
  @override
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final double overallScore;
// 0.0 to 1.0
  @override
  final DateTime? nextReviewDate;

  @override
  String toString() {
    return 'NRTProgressReport(userId: $userId, generatedAt: $generatedAt, summary: $summary, metrics: $metrics, achievements: $achievements, recommendations: $recommendations, overallScore: $overallScore, nextReviewDate: $nextReviewDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTProgressReportImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.nextReviewDate, nextReviewDate) ||
                other.nextReviewDate == nextReviewDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      generatedAt,
      summary,
      const DeepCollectionEquality().hash(_metrics),
      const DeepCollectionEquality().hash(_achievements),
      const DeepCollectionEquality().hash(_recommendations),
      overallScore,
      nextReviewDate);

  /// Create a copy of NRTProgressReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTProgressReportImplCopyWith<_$NRTProgressReportImpl> get copyWith =>
      __$$NRTProgressReportImplCopyWithImpl<_$NRTProgressReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTProgressReportImplToJson(
      this,
    );
  }
}

abstract class _NRTProgressReport implements NRTProgressReport {
  const factory _NRTProgressReport(
      {required final String userId,
      required final DateTime generatedAt,
      required final NRTProgressSummary summary,
      required final List<NRTProgressMetric> metrics,
      required final List<String> achievements,
      required final List<String> recommendations,
      required final double overallScore,
      final DateTime? nextReviewDate}) = _$NRTProgressReportImpl;

  factory _NRTProgressReport.fromJson(Map<String, dynamic> json) =
      _$NRTProgressReportImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get generatedAt;
  @override
  NRTProgressSummary get summary;
  @override
  List<NRTProgressMetric> get metrics;
  @override
  List<String> get achievements;
  @override
  List<String> get recommendations;
  @override
  double get overallScore; // 0.0 to 1.0
  @override
  DateTime? get nextReviewDate;

  /// Create a copy of NRTProgressReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTProgressReportImplCopyWith<_$NRTProgressReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTProgressSummary _$NRTProgressSummaryFromJson(Map<String, dynamic> json) {
  return _NRTProgressSummary.fromJson(json);
}

/// @nodoc
mixin _$NRTProgressSummary {
  int get daysOnNRT => throw _privateConstructorUsedError;
  double get initialDosage => throw _privateConstructorUsedError;
  double get currentDosage => throw _privateConstructorUsedError;
  double get reductionPercentage => throw _privateConstructorUsedError;
  int get symptomsReported => throw _privateConstructorUsedError;
  double get averageSymptomSeverity => throw _privateConstructorUsedError;
  int get milestonesAchieved => throw _privateConstructorUsedError;

  /// Serializes this NRTProgressSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTProgressSummaryCopyWith<NRTProgressSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTProgressSummaryCopyWith<$Res> {
  factory $NRTProgressSummaryCopyWith(
          NRTProgressSummary value, $Res Function(NRTProgressSummary) then) =
      _$NRTProgressSummaryCopyWithImpl<$Res, NRTProgressSummary>;
  @useResult
  $Res call(
      {int daysOnNRT,
      double initialDosage,
      double currentDosage,
      double reductionPercentage,
      int symptomsReported,
      double averageSymptomSeverity,
      int milestonesAchieved});
}

/// @nodoc
class _$NRTProgressSummaryCopyWithImpl<$Res, $Val extends NRTProgressSummary>
    implements $NRTProgressSummaryCopyWith<$Res> {
  _$NRTProgressSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysOnNRT = null,
    Object? initialDosage = null,
    Object? currentDosage = null,
    Object? reductionPercentage = null,
    Object? symptomsReported = null,
    Object? averageSymptomSeverity = null,
    Object? milestonesAchieved = null,
  }) {
    return _then(_value.copyWith(
      daysOnNRT: null == daysOnNRT
          ? _value.daysOnNRT
          : daysOnNRT // ignore: cast_nullable_to_non_nullable
              as int,
      initialDosage: null == initialDosage
          ? _value.initialDosage
          : initialDosage // ignore: cast_nullable_to_non_nullable
              as double,
      currentDosage: null == currentDosage
          ? _value.currentDosage
          : currentDosage // ignore: cast_nullable_to_non_nullable
              as double,
      reductionPercentage: null == reductionPercentage
          ? _value.reductionPercentage
          : reductionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      symptomsReported: null == symptomsReported
          ? _value.symptomsReported
          : symptomsReported // ignore: cast_nullable_to_non_nullable
              as int,
      averageSymptomSeverity: null == averageSymptomSeverity
          ? _value.averageSymptomSeverity
          : averageSymptomSeverity // ignore: cast_nullable_to_non_nullable
              as double,
      milestonesAchieved: null == milestonesAchieved
          ? _value.milestonesAchieved
          : milestonesAchieved // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTProgressSummaryImplCopyWith<$Res>
    implements $NRTProgressSummaryCopyWith<$Res> {
  factory _$$NRTProgressSummaryImplCopyWith(_$NRTProgressSummaryImpl value,
          $Res Function(_$NRTProgressSummaryImpl) then) =
      __$$NRTProgressSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int daysOnNRT,
      double initialDosage,
      double currentDosage,
      double reductionPercentage,
      int symptomsReported,
      double averageSymptomSeverity,
      int milestonesAchieved});
}

/// @nodoc
class __$$NRTProgressSummaryImplCopyWithImpl<$Res>
    extends _$NRTProgressSummaryCopyWithImpl<$Res, _$NRTProgressSummaryImpl>
    implements _$$NRTProgressSummaryImplCopyWith<$Res> {
  __$$NRTProgressSummaryImplCopyWithImpl(_$NRTProgressSummaryImpl _value,
      $Res Function(_$NRTProgressSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysOnNRT = null,
    Object? initialDosage = null,
    Object? currentDosage = null,
    Object? reductionPercentage = null,
    Object? symptomsReported = null,
    Object? averageSymptomSeverity = null,
    Object? milestonesAchieved = null,
  }) {
    return _then(_$NRTProgressSummaryImpl(
      daysOnNRT: null == daysOnNRT
          ? _value.daysOnNRT
          : daysOnNRT // ignore: cast_nullable_to_non_nullable
              as int,
      initialDosage: null == initialDosage
          ? _value.initialDosage
          : initialDosage // ignore: cast_nullable_to_non_nullable
              as double,
      currentDosage: null == currentDosage
          ? _value.currentDosage
          : currentDosage // ignore: cast_nullable_to_non_nullable
              as double,
      reductionPercentage: null == reductionPercentage
          ? _value.reductionPercentage
          : reductionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      symptomsReported: null == symptomsReported
          ? _value.symptomsReported
          : symptomsReported // ignore: cast_nullable_to_non_nullable
              as int,
      averageSymptomSeverity: null == averageSymptomSeverity
          ? _value.averageSymptomSeverity
          : averageSymptomSeverity // ignore: cast_nullable_to_non_nullable
              as double,
      milestonesAchieved: null == milestonesAchieved
          ? _value.milestonesAchieved
          : milestonesAchieved // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTProgressSummaryImpl implements _NRTProgressSummary {
  const _$NRTProgressSummaryImpl(
      {required this.daysOnNRT,
      required this.initialDosage,
      required this.currentDosage,
      required this.reductionPercentage,
      required this.symptomsReported,
      required this.averageSymptomSeverity,
      required this.milestonesAchieved});

  factory _$NRTProgressSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTProgressSummaryImplFromJson(json);

  @override
  final int daysOnNRT;
  @override
  final double initialDosage;
  @override
  final double currentDosage;
  @override
  final double reductionPercentage;
  @override
  final int symptomsReported;
  @override
  final double averageSymptomSeverity;
  @override
  final int milestonesAchieved;

  @override
  String toString() {
    return 'NRTProgressSummary(daysOnNRT: $daysOnNRT, initialDosage: $initialDosage, currentDosage: $currentDosage, reductionPercentage: $reductionPercentage, symptomsReported: $symptomsReported, averageSymptomSeverity: $averageSymptomSeverity, milestonesAchieved: $milestonesAchieved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTProgressSummaryImpl &&
            (identical(other.daysOnNRT, daysOnNRT) ||
                other.daysOnNRT == daysOnNRT) &&
            (identical(other.initialDosage, initialDosage) ||
                other.initialDosage == initialDosage) &&
            (identical(other.currentDosage, currentDosage) ||
                other.currentDosage == currentDosage) &&
            (identical(other.reductionPercentage, reductionPercentage) ||
                other.reductionPercentage == reductionPercentage) &&
            (identical(other.symptomsReported, symptomsReported) ||
                other.symptomsReported == symptomsReported) &&
            (identical(other.averageSymptomSeverity, averageSymptomSeverity) ||
                other.averageSymptomSeverity == averageSymptomSeverity) &&
            (identical(other.milestonesAchieved, milestonesAchieved) ||
                other.milestonesAchieved == milestonesAchieved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      daysOnNRT,
      initialDosage,
      currentDosage,
      reductionPercentage,
      symptomsReported,
      averageSymptomSeverity,
      milestonesAchieved);

  /// Create a copy of NRTProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTProgressSummaryImplCopyWith<_$NRTProgressSummaryImpl> get copyWith =>
      __$$NRTProgressSummaryImplCopyWithImpl<_$NRTProgressSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTProgressSummaryImplToJson(
      this,
    );
  }
}

abstract class _NRTProgressSummary implements NRTProgressSummary {
  const factory _NRTProgressSummary(
      {required final int daysOnNRT,
      required final double initialDosage,
      required final double currentDosage,
      required final double reductionPercentage,
      required final int symptomsReported,
      required final double averageSymptomSeverity,
      required final int milestonesAchieved}) = _$NRTProgressSummaryImpl;

  factory _NRTProgressSummary.fromJson(Map<String, dynamic> json) =
      _$NRTProgressSummaryImpl.fromJson;

  @override
  int get daysOnNRT;
  @override
  double get initialDosage;
  @override
  double get currentDosage;
  @override
  double get reductionPercentage;
  @override
  int get symptomsReported;
  @override
  double get averageSymptomSeverity;
  @override
  int get milestonesAchieved;

  /// Create a copy of NRTProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTProgressSummaryImplCopyWith<_$NRTProgressSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTProgressMetric _$NRTProgressMetricFromJson(Map<String, dynamic> json) {
  return _NRTProgressMetric.fromJson(json);
}

/// @nodoc
mixin _$NRTProgressMetric {
  String get name => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get trend =>
      throw _privateConstructorUsedError; // improving, stable, declining
  String get description => throw _privateConstructorUsedError;

  /// Serializes this NRTProgressMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTProgressMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTProgressMetricCopyWith<NRTProgressMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTProgressMetricCopyWith<$Res> {
  factory $NRTProgressMetricCopyWith(
          NRTProgressMetric value, $Res Function(NRTProgressMetric) then) =
      _$NRTProgressMetricCopyWithImpl<$Res, NRTProgressMetric>;
  @useResult
  $Res call(
      {String name,
      double value,
      String unit,
      String trend,
      String description});
}

/// @nodoc
class _$NRTProgressMetricCopyWithImpl<$Res, $Val extends NRTProgressMetric>
    implements $NRTProgressMetricCopyWith<$Res> {
  _$NRTProgressMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTProgressMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? unit = null,
    Object? trend = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTProgressMetricImplCopyWith<$Res>
    implements $NRTProgressMetricCopyWith<$Res> {
  factory _$$NRTProgressMetricImplCopyWith(_$NRTProgressMetricImpl value,
          $Res Function(_$NRTProgressMetricImpl) then) =
      __$$NRTProgressMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double value,
      String unit,
      String trend,
      String description});
}

/// @nodoc
class __$$NRTProgressMetricImplCopyWithImpl<$Res>
    extends _$NRTProgressMetricCopyWithImpl<$Res, _$NRTProgressMetricImpl>
    implements _$$NRTProgressMetricImplCopyWith<$Res> {
  __$$NRTProgressMetricImplCopyWithImpl(_$NRTProgressMetricImpl _value,
      $Res Function(_$NRTProgressMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTProgressMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? unit = null,
    Object? trend = null,
    Object? description = null,
  }) {
    return _then(_$NRTProgressMetricImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTProgressMetricImpl implements _NRTProgressMetric {
  const _$NRTProgressMetricImpl(
      {required this.name,
      required this.value,
      required this.unit,
      required this.trend,
      required this.description});

  factory _$NRTProgressMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTProgressMetricImplFromJson(json);

  @override
  final String name;
  @override
  final double value;
  @override
  final String unit;
  @override
  final String trend;
// improving, stable, declining
  @override
  final String description;

  @override
  String toString() {
    return 'NRTProgressMetric(name: $name, value: $value, unit: $unit, trend: $trend, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTProgressMetricImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, value, unit, trend, description);

  /// Create a copy of NRTProgressMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTProgressMetricImplCopyWith<_$NRTProgressMetricImpl> get copyWith =>
      __$$NRTProgressMetricImplCopyWithImpl<_$NRTProgressMetricImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTProgressMetricImplToJson(
      this,
    );
  }
}

abstract class _NRTProgressMetric implements NRTProgressMetric {
  const factory _NRTProgressMetric(
      {required final String name,
      required final double value,
      required final String unit,
      required final String trend,
      required final String description}) = _$NRTProgressMetricImpl;

  factory _NRTProgressMetric.fromJson(Map<String, dynamic> json) =
      _$NRTProgressMetricImpl.fromJson;

  @override
  String get name;
  @override
  double get value;
  @override
  String get unit;
  @override
  String get trend; // improving, stable, declining
  @override
  String get description;

  /// Create a copy of NRTProgressMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTProgressMetricImplCopyWith<_$NRTProgressMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NRTSuccessPrediction _$NRTSuccessPredictionFromJson(Map<String, dynamic> json) {
  return _NRTSuccessPrediction.fromJson(json);
}

/// @nodoc
mixin _$NRTSuccessPrediction {
  String get userId => throw _privateConstructorUsedError;
  double get successProbability =>
      throw _privateConstructorUsedError; // 0.0 to 1.0
  List<String> get positiveFactors => throw _privateConstructorUsedError;
  List<String> get riskFactors => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  DateTime get predictionDate => throw _privateConstructorUsedError;
  int get predictionHorizonDays => throw _privateConstructorUsedError;

  /// Serializes this NRTSuccessPrediction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NRTSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NRTSuccessPredictionCopyWith<NRTSuccessPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NRTSuccessPredictionCopyWith<$Res> {
  factory $NRTSuccessPredictionCopyWith(NRTSuccessPrediction value,
          $Res Function(NRTSuccessPrediction) then) =
      _$NRTSuccessPredictionCopyWithImpl<$Res, NRTSuccessPrediction>;
  @useResult
  $Res call(
      {String userId,
      double successProbability,
      List<String> positiveFactors,
      List<String> riskFactors,
      List<String> recommendations,
      DateTime predictionDate,
      int predictionHorizonDays});
}

/// @nodoc
class _$NRTSuccessPredictionCopyWithImpl<$Res,
        $Val extends NRTSuccessPrediction>
    implements $NRTSuccessPredictionCopyWith<$Res> {
  _$NRTSuccessPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NRTSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? successProbability = null,
    Object? positiveFactors = null,
    Object? riskFactors = null,
    Object? recommendations = null,
    Object? predictionDate = null,
    Object? predictionHorizonDays = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _value.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
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
      predictionDate: null == predictionDate
          ? _value.predictionDate
          : predictionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predictionHorizonDays: null == predictionHorizonDays
          ? _value.predictionHorizonDays
          : predictionHorizonDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NRTSuccessPredictionImplCopyWith<$Res>
    implements $NRTSuccessPredictionCopyWith<$Res> {
  factory _$$NRTSuccessPredictionImplCopyWith(_$NRTSuccessPredictionImpl value,
          $Res Function(_$NRTSuccessPredictionImpl) then) =
      __$$NRTSuccessPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      double successProbability,
      List<String> positiveFactors,
      List<String> riskFactors,
      List<String> recommendations,
      DateTime predictionDate,
      int predictionHorizonDays});
}

/// @nodoc
class __$$NRTSuccessPredictionImplCopyWithImpl<$Res>
    extends _$NRTSuccessPredictionCopyWithImpl<$Res, _$NRTSuccessPredictionImpl>
    implements _$$NRTSuccessPredictionImplCopyWith<$Res> {
  __$$NRTSuccessPredictionImplCopyWithImpl(_$NRTSuccessPredictionImpl _value,
      $Res Function(_$NRTSuccessPredictionImpl) _then)
      : super(_value, _then);

  /// Create a copy of NRTSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? successProbability = null,
    Object? positiveFactors = null,
    Object? riskFactors = null,
    Object? recommendations = null,
    Object? predictionDate = null,
    Object? predictionHorizonDays = null,
  }) {
    return _then(_$NRTSuccessPredictionImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _value.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
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
      predictionDate: null == predictionDate
          ? _value.predictionDate
          : predictionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predictionHorizonDays: null == predictionHorizonDays
          ? _value.predictionHorizonDays
          : predictionHorizonDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NRTSuccessPredictionImpl implements _NRTSuccessPrediction {
  const _$NRTSuccessPredictionImpl(
      {required this.userId,
      required this.successProbability,
      required final List<String> positiveFactors,
      required final List<String> riskFactors,
      required final List<String> recommendations,
      required this.predictionDate,
      required this.predictionHorizonDays})
      : _positiveFactors = positiveFactors,
        _riskFactors = riskFactors,
        _recommendations = recommendations;

  factory _$NRTSuccessPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NRTSuccessPredictionImplFromJson(json);

  @override
  final String userId;
  @override
  final double successProbability;
// 0.0 to 1.0
  final List<String> _positiveFactors;
// 0.0 to 1.0
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

  @override
  final DateTime predictionDate;
  @override
  final int predictionHorizonDays;

  @override
  String toString() {
    return 'NRTSuccessPrediction(userId: $userId, successProbability: $successProbability, positiveFactors: $positiveFactors, riskFactors: $riskFactors, recommendations: $recommendations, predictionDate: $predictionDate, predictionHorizonDays: $predictionHorizonDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NRTSuccessPredictionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            const DeepCollectionEquality()
                .equals(other._positiveFactors, _positiveFactors) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.predictionDate, predictionDate) ||
                other.predictionDate == predictionDate) &&
            (identical(other.predictionHorizonDays, predictionHorizonDays) ||
                other.predictionHorizonDays == predictionHorizonDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      successProbability,
      const DeepCollectionEquality().hash(_positiveFactors),
      const DeepCollectionEquality().hash(_riskFactors),
      const DeepCollectionEquality().hash(_recommendations),
      predictionDate,
      predictionHorizonDays);

  /// Create a copy of NRTSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NRTSuccessPredictionImplCopyWith<_$NRTSuccessPredictionImpl>
      get copyWith =>
          __$$NRTSuccessPredictionImplCopyWithImpl<_$NRTSuccessPredictionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NRTSuccessPredictionImplToJson(
      this,
    );
  }
}

abstract class _NRTSuccessPrediction implements NRTSuccessPrediction {
  const factory _NRTSuccessPrediction(
      {required final String userId,
      required final double successProbability,
      required final List<String> positiveFactors,
      required final List<String> riskFactors,
      required final List<String> recommendations,
      required final DateTime predictionDate,
      required final int predictionHorizonDays}) = _$NRTSuccessPredictionImpl;

  factory _NRTSuccessPrediction.fromJson(Map<String, dynamic> json) =
      _$NRTSuccessPredictionImpl.fromJson;

  @override
  String get userId;
  @override
  double get successProbability; // 0.0 to 1.0
  @override
  List<String> get positiveFactors;
  @override
  List<String> get riskFactors;
  @override
  List<String> get recommendations;
  @override
  DateTime get predictionDate;
  @override
  int get predictionHorizonDays;

  /// Create a copy of NRTSuccessPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NRTSuccessPredictionImplCopyWith<_$NRTSuccessPredictionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
