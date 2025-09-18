// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_cache_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MCPCacheEntry _$MCPCacheEntryFromJson(Map<String, dynamic> json) {
  return _MCPCacheEntry.fromJson(json);
}

/// @nodoc
mixin _$MCPCacheEntry {
  String get key => throw _privateConstructorUsedError;
  MCPResponse get response => throw _privateConstructorUsedError;
  DateTime get cachedAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  int get accessCount => throw _privateConstructorUsedError;
  DateTime get lastAccessed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MCPCacheEntryCopyWith<MCPCacheEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPCacheEntryCopyWith<$Res> {
  factory $MCPCacheEntryCopyWith(
          MCPCacheEntry value, $Res Function(MCPCacheEntry) then) =
      _$MCPCacheEntryCopyWithImpl<$Res, MCPCacheEntry>;
  @useResult
  $Res call(
      {String key,
      MCPResponse response,
      DateTime cachedAt,
      DateTime expiresAt,
      int priority,
      int accessCount,
      DateTime lastAccessed});

  $MCPResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$MCPCacheEntryCopyWithImpl<$Res, $Val extends MCPCacheEntry>
    implements $MCPCacheEntryCopyWith<$Res> {
  _$MCPCacheEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? response = null,
    Object? cachedAt = null,
    Object? expiresAt = null,
    Object? priority = null,
    Object? accessCount = null,
    Object? lastAccessed = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as MCPResponse,
      cachedAt: null == cachedAt
          ? _value.cachedAt
          : cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      accessCount: null == accessCount
          ? _value.accessCount
          : accessCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastAccessed: null == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MCPResponseCopyWith<$Res> get response {
    return $MCPResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MCPCacheEntryImplCopyWith<$Res>
    implements $MCPCacheEntryCopyWith<$Res> {
  factory _$$MCPCacheEntryImplCopyWith(
          _$MCPCacheEntryImpl value, $Res Function(_$MCPCacheEntryImpl) then) =
      __$$MCPCacheEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String key,
      MCPResponse response,
      DateTime cachedAt,
      DateTime expiresAt,
      int priority,
      int accessCount,
      DateTime lastAccessed});

  @override
  $MCPResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$MCPCacheEntryImplCopyWithImpl<$Res>
    extends _$MCPCacheEntryCopyWithImpl<$Res, _$MCPCacheEntryImpl>
    implements _$$MCPCacheEntryImplCopyWith<$Res> {
  __$$MCPCacheEntryImplCopyWithImpl(
      _$MCPCacheEntryImpl _value, $Res Function(_$MCPCacheEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? response = null,
    Object? cachedAt = null,
    Object? expiresAt = null,
    Object? priority = null,
    Object? accessCount = null,
    Object? lastAccessed = null,
  }) {
    return _then(_$MCPCacheEntryImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as MCPResponse,
      cachedAt: null == cachedAt
          ? _value.cachedAt
          : cachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      accessCount: null == accessCount
          ? _value.accessCount
          : accessCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastAccessed: null == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPCacheEntryImpl implements _MCPCacheEntry {
  const _$MCPCacheEntryImpl(
      {required this.key,
      required this.response,
      required this.cachedAt,
      required this.expiresAt,
      required this.priority,
      required this.accessCount,
      required this.lastAccessed});

  factory _$MCPCacheEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPCacheEntryImplFromJson(json);

  @override
  final String key;
  @override
  final MCPResponse response;
  @override
  final DateTime cachedAt;
  @override
  final DateTime expiresAt;
  @override
  final int priority;
  @override
  final int accessCount;
  @override
  final DateTime lastAccessed;

  @override
  String toString() {
    return 'MCPCacheEntry(key: $key, response: $response, cachedAt: $cachedAt, expiresAt: $expiresAt, priority: $priority, accessCount: $accessCount, lastAccessed: $lastAccessed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPCacheEntryImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.cachedAt, cachedAt) ||
                other.cachedAt == cachedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.accessCount, accessCount) ||
                other.accessCount == accessCount) &&
            (identical(other.lastAccessed, lastAccessed) ||
                other.lastAccessed == lastAccessed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, response, cachedAt,
      expiresAt, priority, accessCount, lastAccessed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPCacheEntryImplCopyWith<_$MCPCacheEntryImpl> get copyWith =>
      __$$MCPCacheEntryImplCopyWithImpl<_$MCPCacheEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPCacheEntryImplToJson(
      this,
    );
  }
}

abstract class _MCPCacheEntry implements MCPCacheEntry {
  const factory _MCPCacheEntry(
      {required final String key,
      required final MCPResponse response,
      required final DateTime cachedAt,
      required final DateTime expiresAt,
      required final int priority,
      required final int accessCount,
      required final DateTime lastAccessed}) = _$MCPCacheEntryImpl;

  factory _MCPCacheEntry.fromJson(Map<String, dynamic> json) =
      _$MCPCacheEntryImpl.fromJson;

  @override
  String get key;
  @override
  MCPResponse get response;
  @override
  DateTime get cachedAt;
  @override
  DateTime get expiresAt;
  @override
  int get priority;
  @override
  int get accessCount;
  @override
  DateTime get lastAccessed;
  @override
  @JsonKey(ignore: true)
  _$$MCPCacheEntryImplCopyWith<_$MCPCacheEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineFallbackContent _$OfflineFallbackContentFromJson(Map<String, dynamic> json) {
  return _OfflineFallbackContent.fromJson(json);
}

/// @nodoc
mixin _$OfflineFallbackContent {
  MCPResponseType get responseType => throw _privateConstructorUsedError;
  Map<String, dynamic> get content => throw _privateConstructorUsedError;
  String get context => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineFallbackContentCopyWith<OfflineFallbackContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineFallbackContentCopyWith<$Res> {
  factory $OfflineFallbackContentCopyWith(OfflineFallbackContent value,
          $Res Function(OfflineFallbackContent) then) =
      _$OfflineFallbackContentCopyWithImpl<$Res, OfflineFallbackContent>;
  @useResult
  $Res call(
      {MCPResponseType responseType,
      Map<String, dynamic> content,
      String context,
      DateTime createdAt});
}

/// @nodoc
class _$OfflineFallbackContentCopyWithImpl<$Res,
        $Val extends OfflineFallbackContent>
    implements $OfflineFallbackContentCopyWith<$Res> {
  _$OfflineFallbackContentCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseType = null,
    Object? content = null,
    Object? context = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      responseType: null == responseType
          ? _value.responseType
          : responseType as MCPResponseType,
      content: null == content
          ? _value.content
          : content as Map<String, dynamic>,
      context: null == context
          ? _value.context
          : context as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineFallbackContentImplCopyWith<$Res>
    implements $OfflineFallbackContentCopyWith<$Res> {
  factory _$$OfflineFallbackContentImplCopyWith(
          _$OfflineFallbackContentImpl value,
          $Res Function(_$OfflineFallbackContentImpl) then) =
      __$$OfflineFallbackContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MCPResponseType responseType,
      Map<String, dynamic> content,
      String context,
      DateTime createdAt});
}

/// @nodoc
class __$$OfflineFallbackContentImplCopyWithImpl<$Res>
    extends _$OfflineFallbackContentCopyWithImpl<$Res,
        _$OfflineFallbackContentImpl>
    implements _$$OfflineFallbackContentImplCopyWith<$Res> {
  __$$OfflineFallbackContentImplCopyWithImpl(
      _$OfflineFallbackContentImpl _value,
      $Res Function(_$OfflineFallbackContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseType = null,
    Object? content = null,
    Object? context = null,
    Object? createdAt = null,
  }) {
    return _then(_$OfflineFallbackContentImpl(
      responseType: null == responseType
          ? _value.responseType
          : responseType as MCPResponseType,
      content: null == content
          ? _value.content
          : content as Map<String, dynamic>,
      context: null == context
          ? _value.context
          : context as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineFallbackContentImpl implements _OfflineFallbackContent {
  const _$OfflineFallbackContentImpl(
      {required this.responseType,
      required this.content,
      required this.context,
      required this.createdAt});

  factory _$OfflineFallbackContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineFallbackContentImplFromJson(json);

  @override
  final MCPResponseType responseType;
  @override
  final Map<String, dynamic> content;
  @override
  final String context;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'OfflineFallbackContent(responseType: $responseType, content: $content, context: $context, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineFallbackContentImpl &&
            (identical(other.responseType, responseType) ||
                other.responseType == responseType) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, responseType,
      const DeepCollectionEquality().hash(content), context, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineFallbackContentImplCopyWith<_$OfflineFallbackContentImpl>
      get copyWith => __$$OfflineFallbackContentImplCopyWithImpl<
          _$OfflineFallbackContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineFallbackContentImplToJson(
      this,
    );
  }
}

abstract class _OfflineFallbackContent implements OfflineFallbackContent {
  const factory _OfflineFallbackContent(
      {required final MCPResponseType responseType,
      required final Map<String, dynamic> content,
      required final String context,
      required final DateTime createdAt}) = _$OfflineFallbackContentImpl;

  factory _OfflineFallbackContent.fromJson(Map<String, dynamic> json) =
      _$OfflineFallbackContentImpl.fromJson;

  @override
  MCPResponseType get responseType;
  @override
  Map<String, dynamic> get content;
  @override
  String get context;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$OfflineFallbackContentImplCopyWith<_$OfflineFallbackContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}