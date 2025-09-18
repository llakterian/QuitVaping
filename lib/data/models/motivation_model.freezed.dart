// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'motivation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MotivationalContent _$MotivationalContentFromJson(Map<String, dynamic> json) {
  return _MotivationalContent.fromJson(json);
}

/// @nodoc
mixin _$MotivationalContent {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'daily', 'mood_based', 'milestone', 'intervention'
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  double get relevanceScore => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MotivationalContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MotivationalContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MotivationalContentCopyWith<MotivationalContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MotivationalContentCopyWith<$Res> {
  factory $MotivationalContentCopyWith(
          MotivationalContent value, $Res Function(MotivationalContent) then) =
      _$MotivationalContentCopyWithImpl<$Res, MotivationalContent>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String type,
      String title,
      String content,
      String? imageUrl,
      List<String> tags,
      double relevanceScore,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MotivationalContentCopyWithImpl<$Res, $Val extends MotivationalContent>
    implements $MotivationalContentCopyWith<$Res> {
  _$MotivationalContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MotivationalContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? tags = null,
    Object? relevanceScore = null,
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MotivationalContentImplCopyWith<$Res>
    implements $MotivationalContentCopyWith<$Res> {
  factory _$$MotivationalContentImplCopyWith(_$MotivationalContentImpl value,
          $Res Function(_$MotivationalContentImpl) then) =
      __$$MotivationalContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String type,
      String title,
      String content,
      String? imageUrl,
      List<String> tags,
      double relevanceScore,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MotivationalContentImplCopyWithImpl<$Res>
    extends _$MotivationalContentCopyWithImpl<$Res, _$MotivationalContentImpl>
    implements _$$MotivationalContentImplCopyWith<$Res> {
  __$$MotivationalContentImplCopyWithImpl(_$MotivationalContentImpl _value,
      $Res Function(_$MotivationalContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MotivationalContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? tags = null,
    Object? relevanceScore = null,
    Object? metadata = freezed,
  }) {
    return _then(_$MotivationalContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MotivationalContentImpl implements _MotivationalContent {
  const _$MotivationalContentImpl(
      {required this.id,
      required this.timestamp,
      required this.type,
      required this.title,
      required this.content,
      this.imageUrl,
      final List<String> tags = const [],
      this.relevanceScore = 1.0,
      final Map<String, dynamic>? metadata})
      : _tags = tags,
        _metadata = metadata;

  factory _$MotivationalContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MotivationalContentImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final String type;
// 'daily', 'mood_based', 'milestone', 'intervention'
  @override
  final String title;
  @override
  final String content;
  @override
  final String? imageUrl;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final double relevanceScore;
  final Map<String, dynamic>? _metadata;
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
    return 'MotivationalContent(id: $id, timestamp: $timestamp, type: $type, title: $title, content: $content, imageUrl: $imageUrl, tags: $tags, relevanceScore: $relevanceScore, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MotivationalContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      type,
      title,
      content,
      imageUrl,
      const DeepCollectionEquality().hash(_tags),
      relevanceScore,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MotivationalContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MotivationalContentImplCopyWith<_$MotivationalContentImpl> get copyWith =>
      __$$MotivationalContentImplCopyWithImpl<_$MotivationalContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MotivationalContentImplToJson(
      this,
    );
  }
}

abstract class _MotivationalContent implements MotivationalContent {
  const factory _MotivationalContent(
      {required final String id,
      required final DateTime timestamp,
      required final String type,
      required final String title,
      required final String content,
      final String? imageUrl,
      final List<String> tags,
      final double relevanceScore,
      final Map<String, dynamic>? metadata}) = _$MotivationalContentImpl;

  factory _MotivationalContent.fromJson(Map<String, dynamic> json) =
      _$MotivationalContentImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  String get type; // 'daily', 'mood_based', 'milestone', 'intervention'
  @override
  String get title;
  @override
  String get content;
  @override
  String? get imageUrl;
  @override
  List<String> get tags;
  @override
  double get relevanceScore;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MotivationalContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MotivationalContentImplCopyWith<_$MotivationalContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MilestoneEvent _$MilestoneEventFromJson(Map<String, dynamic> json) {
  return _MilestoneEvent.fromJson(json);
}

/// @nodoc
mixin _$MilestoneEvent {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get milestoneKey => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get celebrationImageUrl => throw _privateConstructorUsedError;
  Map<String, dynamic> get milestone => throw _privateConstructorUsedError;

  /// Serializes this MilestoneEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MilestoneEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MilestoneEventCopyWith<MilestoneEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MilestoneEventCopyWith<$Res> {
  factory $MilestoneEventCopyWith(
          MilestoneEvent value, $Res Function(MilestoneEvent) then) =
      _$MilestoneEventCopyWithImpl<$Res, MilestoneEvent>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String milestoneKey,
      String title,
      String message,
      String? celebrationImageUrl,
      Map<String, dynamic> milestone});
}

/// @nodoc
class _$MilestoneEventCopyWithImpl<$Res, $Val extends MilestoneEvent>
    implements $MilestoneEventCopyWith<$Res> {
  _$MilestoneEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MilestoneEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? milestoneKey = null,
    Object? title = null,
    Object? message = null,
    Object? celebrationImageUrl = freezed,
    Object? milestone = null,
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
      milestoneKey: null == milestoneKey
          ? _value.milestoneKey
          : milestoneKey // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      celebrationImageUrl: freezed == celebrationImageUrl
          ? _value.celebrationImageUrl
          : celebrationImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      milestone: null == milestone
          ? _value.milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MilestoneEventImplCopyWith<$Res>
    implements $MilestoneEventCopyWith<$Res> {
  factory _$$MilestoneEventImplCopyWith(_$MilestoneEventImpl value,
          $Res Function(_$MilestoneEventImpl) then) =
      __$$MilestoneEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      String milestoneKey,
      String title,
      String message,
      String? celebrationImageUrl,
      Map<String, dynamic> milestone});
}

/// @nodoc
class __$$MilestoneEventImplCopyWithImpl<$Res>
    extends _$MilestoneEventCopyWithImpl<$Res, _$MilestoneEventImpl>
    implements _$$MilestoneEventImplCopyWith<$Res> {
  __$$MilestoneEventImplCopyWithImpl(
      _$MilestoneEventImpl _value, $Res Function(_$MilestoneEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of MilestoneEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? milestoneKey = null,
    Object? title = null,
    Object? message = null,
    Object? celebrationImageUrl = freezed,
    Object? milestone = null,
  }) {
    return _then(_$MilestoneEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      milestoneKey: null == milestoneKey
          ? _value.milestoneKey
          : milestoneKey // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      celebrationImageUrl: freezed == celebrationImageUrl
          ? _value.celebrationImageUrl
          : celebrationImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      milestone: null == milestone
          ? _value._milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MilestoneEventImpl implements _MilestoneEvent {
  const _$MilestoneEventImpl(
      {required this.id,
      required this.timestamp,
      required this.milestoneKey,
      required this.title,
      required this.message,
      this.celebrationImageUrl,
      final Map<String, dynamic> milestone = const {}})
      : _milestone = milestone;

  factory _$MilestoneEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$MilestoneEventImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final String milestoneKey;
  @override
  final String title;
  @override
  final String message;
  @override
  final String? celebrationImageUrl;
  final Map<String, dynamic> _milestone;
  @override
  @JsonKey()
  Map<String, dynamic> get milestone {
    if (_milestone is EqualUnmodifiableMapView) return _milestone;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_milestone);
  }

  @override
  String toString() {
    return 'MilestoneEvent(id: $id, timestamp: $timestamp, milestoneKey: $milestoneKey, title: $title, message: $message, celebrationImageUrl: $celebrationImageUrl, milestone: $milestone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MilestoneEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.milestoneKey, milestoneKey) ||
                other.milestoneKey == milestoneKey) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.celebrationImageUrl, celebrationImageUrl) ||
                other.celebrationImageUrl == celebrationImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._milestone, _milestone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      milestoneKey,
      title,
      message,
      celebrationImageUrl,
      const DeepCollectionEquality().hash(_milestone));

  /// Create a copy of MilestoneEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MilestoneEventImplCopyWith<_$MilestoneEventImpl> get copyWith =>
      __$$MilestoneEventImplCopyWithImpl<_$MilestoneEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MilestoneEventImplToJson(
      this,
    );
  }
}

abstract class _MilestoneEvent implements MilestoneEvent {
  const factory _MilestoneEvent(
      {required final String id,
      required final DateTime timestamp,
      required final String milestoneKey,
      required final String title,
      required final String message,
      final String? celebrationImageUrl,
      final Map<String, dynamic> milestone}) = _$MilestoneEventImpl;

  factory _MilestoneEvent.fromJson(Map<String, dynamic> json) =
      _$MilestoneEventImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  String get milestoneKey;
  @override
  String get title;
  @override
  String get message;
  @override
  String? get celebrationImageUrl;
  @override
  Map<String, dynamic> get milestone;

  /// Create a copy of MilestoneEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MilestoneEventImplCopyWith<_$MilestoneEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
