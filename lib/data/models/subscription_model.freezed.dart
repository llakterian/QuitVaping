// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubscriptionFeature _$SubscriptionFeatureFromJson(Map<String, dynamic> json) {
  return _SubscriptionFeature.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionFeature {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isPremiumOnly => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionFeature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionFeatureCopyWith<SubscriptionFeature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionFeatureCopyWith<$Res> {
  factory $SubscriptionFeatureCopyWith(
          SubscriptionFeature value, $Res Function(SubscriptionFeature) then) =
      _$SubscriptionFeatureCopyWithImpl<$Res, SubscriptionFeature>;
  @useResult
  $Res call({String id, String name, String description, bool isPremiumOnly});
}

/// @nodoc
class _$SubscriptionFeatureCopyWithImpl<$Res, $Val extends SubscriptionFeature>
    implements $SubscriptionFeatureCopyWith<$Res> {
  _$SubscriptionFeatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isPremiumOnly = null,
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
      isPremiumOnly: null == isPremiumOnly
          ? _value.isPremiumOnly
          : isPremiumOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionFeatureImplCopyWith<$Res>
    implements $SubscriptionFeatureCopyWith<$Res> {
  factory _$$SubscriptionFeatureImplCopyWith(_$SubscriptionFeatureImpl value,
          $Res Function(_$SubscriptionFeatureImpl) then) =
      __$$SubscriptionFeatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String description, bool isPremiumOnly});
}

/// @nodoc
class __$$SubscriptionFeatureImplCopyWithImpl<$Res>
    extends _$SubscriptionFeatureCopyWithImpl<$Res, _$SubscriptionFeatureImpl>
    implements _$$SubscriptionFeatureImplCopyWith<$Res> {
  __$$SubscriptionFeatureImplCopyWithImpl(_$SubscriptionFeatureImpl _value,
      $Res Function(_$SubscriptionFeatureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isPremiumOnly = null,
  }) {
    return _then(_$SubscriptionFeatureImpl(
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
      isPremiumOnly: null == isPremiumOnly
          ? _value.isPremiumOnly
          : isPremiumOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionFeatureImpl implements _SubscriptionFeature {
  _$SubscriptionFeatureImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.isPremiumOnly});

  factory _$SubscriptionFeatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionFeatureImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final bool isPremiumOnly;

  @override
  String toString() {
    return 'SubscriptionFeature(id: $id, name: $name, description: $description, isPremiumOnly: $isPremiumOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionFeatureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isPremiumOnly, isPremiumOnly) ||
                other.isPremiumOnly == isPremiumOnly));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, isPremiumOnly);

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionFeatureImplCopyWith<_$SubscriptionFeatureImpl> get copyWith =>
      __$$SubscriptionFeatureImplCopyWithImpl<_$SubscriptionFeatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionFeatureImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionFeature implements SubscriptionFeature {
  factory _SubscriptionFeature(
      {required final String id,
      required final String name,
      required final String description,
      required final bool isPremiumOnly}) = _$SubscriptionFeatureImpl;

  factory _SubscriptionFeature.fromJson(Map<String, dynamic> json) =
      _$SubscriptionFeatureImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  bool get isPremiumOnly;

  /// Create a copy of SubscriptionFeature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionFeatureImplCopyWith<_$SubscriptionFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) {
  return _SubscriptionPlan.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPlan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get monthlyPrice => throw _privateConstructorUsedError;
  double get yearlyPrice => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  bool get isMostPopular => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPlanCopyWith<SubscriptionPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPlanCopyWith<$Res> {
  factory $SubscriptionPlanCopyWith(
          SubscriptionPlan value, $Res Function(SubscriptionPlan) then) =
      _$SubscriptionPlanCopyWithImpl<$Res, SubscriptionPlan>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double monthlyPrice,
      double yearlyPrice,
      List<String> features,
      bool isMostPopular});
}

/// @nodoc
class _$SubscriptionPlanCopyWithImpl<$Res, $Val extends SubscriptionPlan>
    implements $SubscriptionPlanCopyWith<$Res> {
  _$SubscriptionPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? monthlyPrice = null,
    Object? yearlyPrice = null,
    Object? features = null,
    Object? isMostPopular = null,
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
      monthlyPrice: null == monthlyPrice
          ? _value.monthlyPrice
          : monthlyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      yearlyPrice: null == yearlyPrice
          ? _value.yearlyPrice
          : yearlyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isMostPopular: null == isMostPopular
          ? _value.isMostPopular
          : isMostPopular // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionPlanImplCopyWith<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  factory _$$SubscriptionPlanImplCopyWith(_$SubscriptionPlanImpl value,
          $Res Function(_$SubscriptionPlanImpl) then) =
      __$$SubscriptionPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double monthlyPrice,
      double yearlyPrice,
      List<String> features,
      bool isMostPopular});
}

/// @nodoc
class __$$SubscriptionPlanImplCopyWithImpl<$Res>
    extends _$SubscriptionPlanCopyWithImpl<$Res, _$SubscriptionPlanImpl>
    implements _$$SubscriptionPlanImplCopyWith<$Res> {
  __$$SubscriptionPlanImplCopyWithImpl(_$SubscriptionPlanImpl _value,
      $Res Function(_$SubscriptionPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? monthlyPrice = null,
    Object? yearlyPrice = null,
    Object? features = null,
    Object? isMostPopular = null,
  }) {
    return _then(_$SubscriptionPlanImpl(
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
      monthlyPrice: null == monthlyPrice
          ? _value.monthlyPrice
          : monthlyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      yearlyPrice: null == yearlyPrice
          ? _value.yearlyPrice
          : yearlyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isMostPopular: null == isMostPopular
          ? _value.isMostPopular
          : isMostPopular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionPlanImpl implements _SubscriptionPlan {
  _$SubscriptionPlanImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.monthlyPrice,
      required this.yearlyPrice,
      required final List<String> features,
      this.isMostPopular = false})
      : _features = features;

  factory _$SubscriptionPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double monthlyPrice;
  @override
  final double yearlyPrice;
  final List<String> _features;
  @override
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  @JsonKey()
  final bool isMostPopular;

  @override
  String toString() {
    return 'SubscriptionPlan(id: $id, name: $name, description: $description, monthlyPrice: $monthlyPrice, yearlyPrice: $yearlyPrice, features: $features, isMostPopular: $isMostPopular)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.monthlyPrice, monthlyPrice) ||
                other.monthlyPrice == monthlyPrice) &&
            (identical(other.yearlyPrice, yearlyPrice) ||
                other.yearlyPrice == yearlyPrice) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.isMostPopular, isMostPopular) ||
                other.isMostPopular == isMostPopular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      monthlyPrice,
      yearlyPrice,
      const DeepCollectionEquality().hash(_features),
      isMostPopular);

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      __$$SubscriptionPlanImplCopyWithImpl<_$SubscriptionPlanImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPlanImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionPlan implements SubscriptionPlan {
  factory _SubscriptionPlan(
      {required final String id,
      required final String name,
      required final String description,
      required final double monthlyPrice,
      required final double yearlyPrice,
      required final List<String> features,
      final bool isMostPopular}) = _$SubscriptionPlanImpl;

  factory _SubscriptionPlan.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get monthlyPrice;
  @override
  double get yearlyPrice;
  @override
  List<String> get features;
  @override
  bool get isMostPopular;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
