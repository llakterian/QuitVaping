// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  VapingHistoryModel get vapingHistory => throw _privateConstructorUsedError;
  List<String> get motivationFactors => throw _privateConstructorUsedError;
  DateTime? get quitDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      int age,
      String gender,
      String? email,
      DateTime createdAt,
      DateTime updatedAt,
      VapingHistoryModel vapingHistory,
      List<String> motivationFactors,
      DateTime? quitDate,
      Map<String, dynamic> preferences});

  $VapingHistoryModelCopyWith<$Res> get vapingHistory;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? email = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? vapingHistory = null,
    Object? motivationFactors = null,
    Object? quitDate = freezed,
    Object? preferences = null,
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
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      vapingHistory: null == vapingHistory
          ? _value.vapingHistory
          : vapingHistory // ignore: cast_nullable_to_non_nullable
              as VapingHistoryModel,
      motivationFactors: null == motivationFactors
          ? _value.motivationFactors
          : motivationFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quitDate: freezed == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VapingHistoryModelCopyWith<$Res> get vapingHistory {
    return $VapingHistoryModelCopyWith<$Res>(_value.vapingHistory, (value) {
      return _then(_value.copyWith(vapingHistory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int age,
      String gender,
      String? email,
      DateTime createdAt,
      DateTime updatedAt,
      VapingHistoryModel vapingHistory,
      List<String> motivationFactors,
      DateTime? quitDate,
      Map<String, dynamic> preferences});

  @override
  $VapingHistoryModelCopyWith<$Res> get vapingHistory;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? email = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? vapingHistory = null,
    Object? motivationFactors = null,
    Object? quitDate = freezed,
    Object? preferences = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      vapingHistory: null == vapingHistory
          ? _value.vapingHistory
          : vapingHistory // ignore: cast_nullable_to_non_nullable
              as VapingHistoryModel,
      motivationFactors: null == motivationFactors
          ? _value._motivationFactors
          : motivationFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quitDate: freezed == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.name,
      required this.age,
      required this.gender,
      this.email,
      required this.createdAt,
      required this.updatedAt,
      required this.vapingHistory,
      required final List<String> motivationFactors,
      this.quitDate,
      final Map<String, dynamic> preferences = const {}})
      : _motivationFactors = motivationFactors,
        _preferences = preferences;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String? email;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final VapingHistoryModel vapingHistory;
  final List<String> _motivationFactors;
  @override
  List<String> get motivationFactors {
    if (_motivationFactors is EqualUnmodifiableListView)
      return _motivationFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_motivationFactors);
  }

  @override
  final DateTime? quitDate;
  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, age: $age, gender: $gender, email: $email, createdAt: $createdAt, updatedAt: $updatedAt, vapingHistory: $vapingHistory, motivationFactors: $motivationFactors, quitDate: $quitDate, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.vapingHistory, vapingHistory) ||
                other.vapingHistory == vapingHistory) &&
            const DeepCollectionEquality()
                .equals(other._motivationFactors, _motivationFactors) &&
            (identical(other.quitDate, quitDate) ||
                other.quitDate == quitDate) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      age,
      gender,
      email,
      createdAt,
      updatedAt,
      vapingHistory,
      const DeepCollectionEquality().hash(_motivationFactors),
      quitDate,
      const DeepCollectionEquality().hash(_preferences));

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String name,
      required final int age,
      required final String gender,
      final String? email,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final VapingHistoryModel vapingHistory,
      required final List<String> motivationFactors,
      final DateTime? quitDate,
      final Map<String, dynamic> preferences}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String? get email;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  VapingHistoryModel get vapingHistory;
  @override
  List<String> get motivationFactors;
  @override
  DateTime? get quitDate;
  @override
  Map<String, dynamic> get preferences;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VapingHistoryModel _$VapingHistoryModelFromJson(Map<String, dynamic> json) {
  return _VapingHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$VapingHistoryModel {
  int get dailyFrequency => throw _privateConstructorUsedError;
  int get nicotineStrength => throw _privateConstructorUsedError; // in mg
  double get yearsVaping => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  List<String> get commonTriggers => throw _privateConstructorUsedError;
  List<String> get previousQuitAttempts => throw _privateConstructorUsedError;
  int? get longestQuitDuration => throw _privateConstructorUsedError;

  /// Serializes this VapingHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VapingHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VapingHistoryModelCopyWith<VapingHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VapingHistoryModelCopyWith<$Res> {
  factory $VapingHistoryModelCopyWith(
          VapingHistoryModel value, $Res Function(VapingHistoryModel) then) =
      _$VapingHistoryModelCopyWithImpl<$Res, VapingHistoryModel>;
  @useResult
  $Res call(
      {int dailyFrequency,
      int nicotineStrength,
      double yearsVaping,
      String deviceType,
      List<String> commonTriggers,
      List<String> previousQuitAttempts,
      int? longestQuitDuration});
}

/// @nodoc
class _$VapingHistoryModelCopyWithImpl<$Res, $Val extends VapingHistoryModel>
    implements $VapingHistoryModelCopyWith<$Res> {
  _$VapingHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VapingHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyFrequency = null,
    Object? nicotineStrength = null,
    Object? yearsVaping = null,
    Object? deviceType = null,
    Object? commonTriggers = null,
    Object? previousQuitAttempts = null,
    Object? longestQuitDuration = freezed,
  }) {
    return _then(_value.copyWith(
      dailyFrequency: null == dailyFrequency
          ? _value.dailyFrequency
          : dailyFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      nicotineStrength: null == nicotineStrength
          ? _value.nicotineStrength
          : nicotineStrength // ignore: cast_nullable_to_non_nullable
              as int,
      yearsVaping: null == yearsVaping
          ? _value.yearsVaping
          : yearsVaping // ignore: cast_nullable_to_non_nullable
              as double,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      commonTriggers: null == commonTriggers
          ? _value.commonTriggers
          : commonTriggers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      previousQuitAttempts: null == previousQuitAttempts
          ? _value.previousQuitAttempts
          : previousQuitAttempts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longestQuitDuration: freezed == longestQuitDuration
          ? _value.longestQuitDuration
          : longestQuitDuration // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VapingHistoryModelImplCopyWith<$Res>
    implements $VapingHistoryModelCopyWith<$Res> {
  factory _$$VapingHistoryModelImplCopyWith(_$VapingHistoryModelImpl value,
          $Res Function(_$VapingHistoryModelImpl) then) =
      __$$VapingHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int dailyFrequency,
      int nicotineStrength,
      double yearsVaping,
      String deviceType,
      List<String> commonTriggers,
      List<String> previousQuitAttempts,
      int? longestQuitDuration});
}

/// @nodoc
class __$$VapingHistoryModelImplCopyWithImpl<$Res>
    extends _$VapingHistoryModelCopyWithImpl<$Res, _$VapingHistoryModelImpl>
    implements _$$VapingHistoryModelImplCopyWith<$Res> {
  __$$VapingHistoryModelImplCopyWithImpl(_$VapingHistoryModelImpl _value,
      $Res Function(_$VapingHistoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VapingHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyFrequency = null,
    Object? nicotineStrength = null,
    Object? yearsVaping = null,
    Object? deviceType = null,
    Object? commonTriggers = null,
    Object? previousQuitAttempts = null,
    Object? longestQuitDuration = freezed,
  }) {
    return _then(_$VapingHistoryModelImpl(
      dailyFrequency: null == dailyFrequency
          ? _value.dailyFrequency
          : dailyFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      nicotineStrength: null == nicotineStrength
          ? _value.nicotineStrength
          : nicotineStrength // ignore: cast_nullable_to_non_nullable
              as int,
      yearsVaping: null == yearsVaping
          ? _value.yearsVaping
          : yearsVaping // ignore: cast_nullable_to_non_nullable
              as double,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      commonTriggers: null == commonTriggers
          ? _value._commonTriggers
          : commonTriggers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      previousQuitAttempts: null == previousQuitAttempts
          ? _value._previousQuitAttempts
          : previousQuitAttempts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longestQuitDuration: freezed == longestQuitDuration
          ? _value.longestQuitDuration
          : longestQuitDuration // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VapingHistoryModelImpl extends _VapingHistoryModel {
  const _$VapingHistoryModelImpl(
      {required this.dailyFrequency,
      required this.nicotineStrength,
      required this.yearsVaping,
      required this.deviceType,
      required final List<String> commonTriggers,
      required final List<String> previousQuitAttempts,
      this.longestQuitDuration})
      : _commonTriggers = commonTriggers,
        _previousQuitAttempts = previousQuitAttempts,
        super._();

  factory _$VapingHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VapingHistoryModelImplFromJson(json);

  @override
  final int dailyFrequency;
  @override
  final int nicotineStrength;
// in mg
  @override
  final double yearsVaping;
  @override
  final String deviceType;
  final List<String> _commonTriggers;
  @override
  List<String> get commonTriggers {
    if (_commonTriggers is EqualUnmodifiableListView) return _commonTriggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonTriggers);
  }

  final List<String> _previousQuitAttempts;
  @override
  List<String> get previousQuitAttempts {
    if (_previousQuitAttempts is EqualUnmodifiableListView)
      return _previousQuitAttempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousQuitAttempts);
  }

  @override
  final int? longestQuitDuration;

  @override
  String toString() {
    return 'VapingHistoryModel(dailyFrequency: $dailyFrequency, nicotineStrength: $nicotineStrength, yearsVaping: $yearsVaping, deviceType: $deviceType, commonTriggers: $commonTriggers, previousQuitAttempts: $previousQuitAttempts, longestQuitDuration: $longestQuitDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VapingHistoryModelImpl &&
            (identical(other.dailyFrequency, dailyFrequency) ||
                other.dailyFrequency == dailyFrequency) &&
            (identical(other.nicotineStrength, nicotineStrength) ||
                other.nicotineStrength == nicotineStrength) &&
            (identical(other.yearsVaping, yearsVaping) ||
                other.yearsVaping == yearsVaping) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            const DeepCollectionEquality()
                .equals(other._commonTriggers, _commonTriggers) &&
            const DeepCollectionEquality()
                .equals(other._previousQuitAttempts, _previousQuitAttempts) &&
            (identical(other.longestQuitDuration, longestQuitDuration) ||
                other.longestQuitDuration == longestQuitDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dailyFrequency,
      nicotineStrength,
      yearsVaping,
      deviceType,
      const DeepCollectionEquality().hash(_commonTriggers),
      const DeepCollectionEquality().hash(_previousQuitAttempts),
      longestQuitDuration);

  /// Create a copy of VapingHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VapingHistoryModelImplCopyWith<_$VapingHistoryModelImpl> get copyWith =>
      __$$VapingHistoryModelImplCopyWithImpl<_$VapingHistoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VapingHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _VapingHistoryModel extends VapingHistoryModel {
  const factory _VapingHistoryModel(
      {required final int dailyFrequency,
      required final int nicotineStrength,
      required final double yearsVaping,
      required final String deviceType,
      required final List<String> commonTriggers,
      required final List<String> previousQuitAttempts,
      final int? longestQuitDuration}) = _$VapingHistoryModelImpl;
  const _VapingHistoryModel._() : super._();

  factory _VapingHistoryModel.fromJson(Map<String, dynamic> json) =
      _$VapingHistoryModelImpl.fromJson;

  @override
  int get dailyFrequency;
  @override
  int get nicotineStrength; // in mg
  @override
  double get yearsVaping;
  @override
  String get deviceType;
  @override
  List<String> get commonTriggers;
  @override
  List<String> get previousQuitAttempts;
  @override
  int? get longestQuitDuration;

  /// Create a copy of VapingHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VapingHistoryModelImplCopyWith<_$VapingHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
