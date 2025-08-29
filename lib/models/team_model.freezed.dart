// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sport => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get pendingRequests => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  int get maxMembers => throw _privateConstructorUsedError;
  Map<String, dynamic> get statistics => throw _privateConstructorUsedError;
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastActivity => throw _privateConstructorUsedError;

  /// Serializes this TeamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamModelCopyWith<TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamModelCopyWith<$Res> {
  factory $TeamModelCopyWith(TeamModel value, $Res Function(TeamModel) then) =
      _$TeamModelCopyWithImpl<$Res, TeamModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String sport,
    String createdBy,
    String? description,
    String? location,
    String? city,
    String? country,
    String? logoUrl,
    List<String> members,
    List<String> pendingRequests,
    int memberCount,
    int maxMembers,
    Map<String, dynamic> statistics,
    Map<String, dynamic> settings,
    bool isPublic,
    bool isActive,
    bool isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivity,
  });
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sport = null,
    Object? createdBy = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? logoUrl = freezed,
    Object? members = null,
    Object? pendingRequests = null,
    Object? memberCount = null,
    Object? maxMembers = null,
    Object? statistics = null,
    Object? settings = null,
    Object? isPublic = null,
    Object? isActive = null,
    Object? isVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastActivity = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            sport: null == sport
                ? _value.sport
                : sport // ignore: cast_nullable_to_non_nullable
                      as String,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            members: null == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pendingRequests: null == pendingRequests
                ? _value.pendingRequests
                : pendingRequests // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            memberCount: null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as int,
            maxMembers: null == maxMembers
                ? _value.maxMembers
                : maxMembers // ignore: cast_nullable_to_non_nullable
                      as int,
            statistics: null == statistics
                ? _value.statistics
                : statistics // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastActivity: freezed == lastActivity
                ? _value.lastActivity
                : lastActivity // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamModelImplCopyWith<$Res>
    implements $TeamModelCopyWith<$Res> {
  factory _$$TeamModelImplCopyWith(
    _$TeamModelImpl value,
    $Res Function(_$TeamModelImpl) then,
  ) = __$$TeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String sport,
    String createdBy,
    String? description,
    String? location,
    String? city,
    String? country,
    String? logoUrl,
    List<String> members,
    List<String> pendingRequests,
    int memberCount,
    int maxMembers,
    Map<String, dynamic> statistics,
    Map<String, dynamic> settings,
    bool isPublic,
    bool isActive,
    bool isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivity,
  });
}

/// @nodoc
class __$$TeamModelImplCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$TeamModelImpl>
    implements _$$TeamModelImplCopyWith<$Res> {
  __$$TeamModelImplCopyWithImpl(
    _$TeamModelImpl _value,
    $Res Function(_$TeamModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sport = null,
    Object? createdBy = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? logoUrl = freezed,
    Object? members = null,
    Object? pendingRequests = null,
    Object? memberCount = null,
    Object? maxMembers = null,
    Object? statistics = null,
    Object? settings = null,
    Object? isPublic = null,
    Object? isActive = null,
    Object? isVerified = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastActivity = freezed,
  }) {
    return _then(
      _$TeamModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sport: null == sport
            ? _value.sport
            : sport // ignore: cast_nullable_to_non_nullable
                  as String,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        members: null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pendingRequests: null == pendingRequests
            ? _value._pendingRequests
            : pendingRequests // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        memberCount: null == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        maxMembers: null == maxMembers
            ? _value.maxMembers
            : maxMembers // ignore: cast_nullable_to_non_nullable
                  as int,
        statistics: null == statistics
            ? _value._statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        settings: null == settings
            ? _value._settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastActivity: freezed == lastActivity
            ? _value.lastActivity
            : lastActivity // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamModelImpl implements _TeamModel {
  const _$TeamModelImpl({
    required this.id,
    required this.name,
    required this.sport,
    required this.createdBy,
    this.description,
    this.location,
    this.city,
    this.country,
    this.logoUrl,
    final List<String> members = const [],
    final List<String> pendingRequests = const [],
    this.memberCount = 0,
    this.maxMembers = 0,
    final Map<String, dynamic> statistics = const {},
    final Map<String, dynamic> settings = const {},
    this.isPublic = false,
    this.isActive = false,
    this.isVerified = false,
    this.createdAt,
    this.updatedAt,
    this.lastActivity,
  }) : _members = members,
       _pendingRequests = pendingRequests,
       _statistics = statistics,
       _settings = settings;

  factory _$TeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sport;
  @override
  final String createdBy;
  @override
  final String? description;
  @override
  final String? location;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final String? logoUrl;
  final List<String> _members;
  @override
  @JsonKey()
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<String> _pendingRequests;
  @override
  @JsonKey()
  List<String> get pendingRequests {
    if (_pendingRequests is EqualUnmodifiableListView) return _pendingRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingRequests);
  }

  @override
  @JsonKey()
  final int memberCount;
  @override
  @JsonKey()
  final int maxMembers;
  final Map<String, dynamic> _statistics;
  @override
  @JsonKey()
  Map<String, dynamic> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  final Map<String, dynamic> _settings;
  @override
  @JsonKey()
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  @JsonKey()
  final bool isPublic;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastActivity;

  @override
  String toString() {
    return 'TeamModel(id: $id, name: $name, sport: $sport, createdBy: $createdBy, description: $description, location: $location, city: $city, country: $country, logoUrl: $logoUrl, members: $members, pendingRequests: $pendingRequests, memberCount: $memberCount, maxMembers: $maxMembers, statistics: $statistics, settings: $settings, isPublic: $isPublic, isActive: $isActive, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt, lastActivity: $lastActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(
              other._pendingRequests,
              _pendingRequests,
            ) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.maxMembers, maxMembers) ||
                other.maxMembers == maxMembers) &&
            const DeepCollectionEquality().equals(
              other._statistics,
              _statistics,
            ) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    sport,
    createdBy,
    description,
    location,
    city,
    country,
    logoUrl,
    const DeepCollectionEquality().hash(_members),
    const DeepCollectionEquality().hash(_pendingRequests),
    memberCount,
    maxMembers,
    const DeepCollectionEquality().hash(_statistics),
    const DeepCollectionEquality().hash(_settings),
    isPublic,
    isActive,
    isVerified,
    createdAt,
    updatedAt,
    lastActivity,
  ]);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      __$$TeamModelImplCopyWithImpl<_$TeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamModelImplToJson(this);
  }
}

abstract class _TeamModel implements TeamModel {
  const factory _TeamModel({
    required final String id,
    required final String name,
    required final String sport,
    required final String createdBy,
    final String? description,
    final String? location,
    final String? city,
    final String? country,
    final String? logoUrl,
    final List<String> members,
    final List<String> pendingRequests,
    final int memberCount,
    final int maxMembers,
    final Map<String, dynamic> statistics,
    final Map<String, dynamic> settings,
    final bool isPublic,
    final bool isActive,
    final bool isVerified,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? lastActivity,
  }) = _$TeamModelImpl;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get sport;
  @override
  String get createdBy;
  @override
  String? get description;
  @override
  String? get location;
  @override
  String? get city;
  @override
  String? get country;
  @override
  String? get logoUrl;
  @override
  List<String> get members;
  @override
  List<String> get pendingRequests;
  @override
  int get memberCount;
  @override
  int get maxMembers;
  @override
  Map<String, dynamic> get statistics;
  @override
  Map<String, dynamic> get settings;
  @override
  bool get isPublic;
  @override
  bool get isActive;
  @override
  bool get isVerified;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastActivity;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamStats _$TeamStatsFromJson(Map<String, dynamic> json) {
  return _TeamStats.fromJson(json);
}

/// @nodoc
mixin _$TeamStats {
  int get gamesPlayed => throw _privateConstructorUsedError;
  int get gamesWon => throw _privateConstructorUsedError;
  int get gamesLost => throw _privateConstructorUsedError;
  int get tournamentsWon => throw _privateConstructorUsedError;
  int get tournamentsParticipated => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalRating => throw _privateConstructorUsedError;
  int get ratingCount => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  int get totalAssists => throw _privateConstructorUsedError;
  int get totalRebounds => throw _privateConstructorUsedError;

  /// Serializes this TeamStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamStatsCopyWith<TeamStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatsCopyWith<$Res> {
  factory $TeamStatsCopyWith(TeamStats value, $Res Function(TeamStats) then) =
      _$TeamStatsCopyWithImpl<$Res, TeamStats>;
  @useResult
  $Res call({
    int gamesPlayed,
    int gamesWon,
    int gamesLost,
    int tournamentsWon,
    int tournamentsParticipated,
    double winRate,
    double averageRating,
    int totalRating,
    int ratingCount,
    int totalPoints,
    int totalAssists,
    int totalRebounds,
  });
}

/// @nodoc
class _$TeamStatsCopyWithImpl<$Res, $Val extends TeamStats>
    implements $TeamStatsCopyWith<$Res> {
  _$TeamStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? gamesLost = null,
    Object? tournamentsWon = null,
    Object? tournamentsParticipated = null,
    Object? winRate = null,
    Object? averageRating = null,
    Object? totalRating = null,
    Object? ratingCount = null,
    Object? totalPoints = null,
    Object? totalAssists = null,
    Object? totalRebounds = null,
  }) {
    return _then(
      _value.copyWith(
            gamesPlayed: null == gamesPlayed
                ? _value.gamesPlayed
                : gamesPlayed // ignore: cast_nullable_to_non_nullable
                      as int,
            gamesWon: null == gamesWon
                ? _value.gamesWon
                : gamesWon // ignore: cast_nullable_to_non_nullable
                      as int,
            gamesLost: null == gamesLost
                ? _value.gamesLost
                : gamesLost // ignore: cast_nullable_to_non_nullable
                      as int,
            tournamentsWon: null == tournamentsWon
                ? _value.tournamentsWon
                : tournamentsWon // ignore: cast_nullable_to_non_nullable
                      as int,
            tournamentsParticipated: null == tournamentsParticipated
                ? _value.tournamentsParticipated
                : tournamentsParticipated // ignore: cast_nullable_to_non_nullable
                      as int,
            winRate: null == winRate
                ? _value.winRate
                : winRate // ignore: cast_nullable_to_non_nullable
                      as double,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRating: null == totalRating
                ? _value.totalRating
                : totalRating // ignore: cast_nullable_to_non_nullable
                      as int,
            ratingCount: null == ratingCount
                ? _value.ratingCount
                : ratingCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPoints: null == totalPoints
                ? _value.totalPoints
                : totalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAssists: null == totalAssists
                ? _value.totalAssists
                : totalAssists // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRebounds: null == totalRebounds
                ? _value.totalRebounds
                : totalRebounds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamStatsImplCopyWith<$Res>
    implements $TeamStatsCopyWith<$Res> {
  factory _$$TeamStatsImplCopyWith(
    _$TeamStatsImpl value,
    $Res Function(_$TeamStatsImpl) then,
  ) = __$$TeamStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int gamesPlayed,
    int gamesWon,
    int gamesLost,
    int tournamentsWon,
    int tournamentsParticipated,
    double winRate,
    double averageRating,
    int totalRating,
    int ratingCount,
    int totalPoints,
    int totalAssists,
    int totalRebounds,
  });
}

/// @nodoc
class __$$TeamStatsImplCopyWithImpl<$Res>
    extends _$TeamStatsCopyWithImpl<$Res, _$TeamStatsImpl>
    implements _$$TeamStatsImplCopyWith<$Res> {
  __$$TeamStatsImplCopyWithImpl(
    _$TeamStatsImpl _value,
    $Res Function(_$TeamStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? gamesLost = null,
    Object? tournamentsWon = null,
    Object? tournamentsParticipated = null,
    Object? winRate = null,
    Object? averageRating = null,
    Object? totalRating = null,
    Object? ratingCount = null,
    Object? totalPoints = null,
    Object? totalAssists = null,
    Object? totalRebounds = null,
  }) {
    return _then(
      _$TeamStatsImpl(
        gamesPlayed: null == gamesPlayed
            ? _value.gamesPlayed
            : gamesPlayed // ignore: cast_nullable_to_non_nullable
                  as int,
        gamesWon: null == gamesWon
            ? _value.gamesWon
            : gamesWon // ignore: cast_nullable_to_non_nullable
                  as int,
        gamesLost: null == gamesLost
            ? _value.gamesLost
            : gamesLost // ignore: cast_nullable_to_non_nullable
                  as int,
        tournamentsWon: null == tournamentsWon
            ? _value.tournamentsWon
            : tournamentsWon // ignore: cast_nullable_to_non_nullable
                  as int,
        tournamentsParticipated: null == tournamentsParticipated
            ? _value.tournamentsParticipated
            : tournamentsParticipated // ignore: cast_nullable_to_non_nullable
                  as int,
        winRate: null == winRate
            ? _value.winRate
            : winRate // ignore: cast_nullable_to_non_nullable
                  as double,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRating: null == totalRating
            ? _value.totalRating
            : totalRating // ignore: cast_nullable_to_non_nullable
                  as int,
        ratingCount: null == ratingCount
            ? _value.ratingCount
            : ratingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPoints: null == totalPoints
            ? _value.totalPoints
            : totalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAssists: null == totalAssists
            ? _value.totalAssists
            : totalAssists // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRebounds: null == totalRebounds
            ? _value.totalRebounds
            : totalRebounds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamStatsImpl implements _TeamStats {
  const _$TeamStatsImpl({
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.gamesLost = 0,
    this.tournamentsWon = 0,
    this.tournamentsParticipated = 0,
    this.winRate = 0.0,
    this.averageRating = 0.0,
    this.totalRating = 0,
    this.ratingCount = 0,
    this.totalPoints = 0,
    this.totalAssists = 0,
    this.totalRebounds = 0,
  });

  factory _$TeamStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamStatsImplFromJson(json);

  @override
  @JsonKey()
  final int gamesPlayed;
  @override
  @JsonKey()
  final int gamesWon;
  @override
  @JsonKey()
  final int gamesLost;
  @override
  @JsonKey()
  final int tournamentsWon;
  @override
  @JsonKey()
  final int tournamentsParticipated;
  @override
  @JsonKey()
  final double winRate;
  @override
  @JsonKey()
  final double averageRating;
  @override
  @JsonKey()
  final int totalRating;
  @override
  @JsonKey()
  final int ratingCount;
  @override
  @JsonKey()
  final int totalPoints;
  @override
  @JsonKey()
  final int totalAssists;
  @override
  @JsonKey()
  final int totalRebounds;

  @override
  String toString() {
    return 'TeamStats(gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, tournamentsWon: $tournamentsWon, tournamentsParticipated: $tournamentsParticipated, winRate: $winRate, averageRating: $averageRating, totalRating: $totalRating, ratingCount: $ratingCount, totalPoints: $totalPoints, totalAssists: $totalAssists, totalRebounds: $totalRebounds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStatsImpl &&
            (identical(other.gamesPlayed, gamesPlayed) ||
                other.gamesPlayed == gamesPlayed) &&
            (identical(other.gamesWon, gamesWon) ||
                other.gamesWon == gamesWon) &&
            (identical(other.gamesLost, gamesLost) ||
                other.gamesLost == gamesLost) &&
            (identical(other.tournamentsWon, tournamentsWon) ||
                other.tournamentsWon == tournamentsWon) &&
            (identical(
                  other.tournamentsParticipated,
                  tournamentsParticipated,
                ) ||
                other.tournamentsParticipated == tournamentsParticipated) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRating, totalRating) ||
                other.totalRating == totalRating) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.totalAssists, totalAssists) ||
                other.totalAssists == totalAssists) &&
            (identical(other.totalRebounds, totalRebounds) ||
                other.totalRebounds == totalRebounds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    gamesPlayed,
    gamesWon,
    gamesLost,
    tournamentsWon,
    tournamentsParticipated,
    winRate,
    averageRating,
    totalRating,
    ratingCount,
    totalPoints,
    totalAssists,
    totalRebounds,
  );

  /// Create a copy of TeamStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStatsImplCopyWith<_$TeamStatsImpl> get copyWith =>
      __$$TeamStatsImplCopyWithImpl<_$TeamStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamStatsImplToJson(this);
  }
}

abstract class _TeamStats implements TeamStats {
  const factory _TeamStats({
    final int gamesPlayed,
    final int gamesWon,
    final int gamesLost,
    final int tournamentsWon,
    final int tournamentsParticipated,
    final double winRate,
    final double averageRating,
    final int totalRating,
    final int ratingCount,
    final int totalPoints,
    final int totalAssists,
    final int totalRebounds,
  }) = _$TeamStatsImpl;

  factory _TeamStats.fromJson(Map<String, dynamic> json) =
      _$TeamStatsImpl.fromJson;

  @override
  int get gamesPlayed;
  @override
  int get gamesWon;
  @override
  int get gamesLost;
  @override
  int get tournamentsWon;
  @override
  int get tournamentsParticipated;
  @override
  double get winRate;
  @override
  double get averageRating;
  @override
  int get totalRating;
  @override
  int get ratingCount;
  @override
  int get totalPoints;
  @override
  int get totalAssists;
  @override
  int get totalRebounds;

  /// Create a copy of TeamStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamStatsImplCopyWith<_$TeamStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamSettings _$TeamSettingsFromJson(Map<String, dynamic> json) {
  return _TeamSettings.fromJson(json);
}

/// @nodoc
mixin _$TeamSettings {
  bool get allowJoinRequests => throw _privateConstructorUsedError;
  bool get allowMemberInvites => throw _privateConstructorUsedError;
  bool get requireApproval => throw _privateConstructorUsedError;
  bool get allowMemberChat => throw _privateConstructorUsedError;
  bool get allowMemberGames => throw _privateConstructorUsedError;
  int get maxMembers => throw _privateConstructorUsedError;
  List<String> get allowedSports => throw _privateConstructorUsedError;
  List<String> get blockedUsers => throw _privateConstructorUsedError;

  /// Serializes this TeamSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamSettingsCopyWith<TeamSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamSettingsCopyWith<$Res> {
  factory $TeamSettingsCopyWith(
    TeamSettings value,
    $Res Function(TeamSettings) then,
  ) = _$TeamSettingsCopyWithImpl<$Res, TeamSettings>;
  @useResult
  $Res call({
    bool allowJoinRequests,
    bool allowMemberInvites,
    bool requireApproval,
    bool allowMemberChat,
    bool allowMemberGames,
    int maxMembers,
    List<String> allowedSports,
    List<String> blockedUsers,
  });
}

/// @nodoc
class _$TeamSettingsCopyWithImpl<$Res, $Val extends TeamSettings>
    implements $TeamSettingsCopyWith<$Res> {
  _$TeamSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowJoinRequests = null,
    Object? allowMemberInvites = null,
    Object? requireApproval = null,
    Object? allowMemberChat = null,
    Object? allowMemberGames = null,
    Object? maxMembers = null,
    Object? allowedSports = null,
    Object? blockedUsers = null,
  }) {
    return _then(
      _value.copyWith(
            allowJoinRequests: null == allowJoinRequests
                ? _value.allowJoinRequests
                : allowJoinRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowMemberInvites: null == allowMemberInvites
                ? _value.allowMemberInvites
                : allowMemberInvites // ignore: cast_nullable_to_non_nullable
                      as bool,
            requireApproval: null == requireApproval
                ? _value.requireApproval
                : requireApproval // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowMemberChat: null == allowMemberChat
                ? _value.allowMemberChat
                : allowMemberChat // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowMemberGames: null == allowMemberGames
                ? _value.allowMemberGames
                : allowMemberGames // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxMembers: null == maxMembers
                ? _value.maxMembers
                : maxMembers // ignore: cast_nullable_to_non_nullable
                      as int,
            allowedSports: null == allowedSports
                ? _value.allowedSports
                : allowedSports // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            blockedUsers: null == blockedUsers
                ? _value.blockedUsers
                : blockedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamSettingsImplCopyWith<$Res>
    implements $TeamSettingsCopyWith<$Res> {
  factory _$$TeamSettingsImplCopyWith(
    _$TeamSettingsImpl value,
    $Res Function(_$TeamSettingsImpl) then,
  ) = __$$TeamSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool allowJoinRequests,
    bool allowMemberInvites,
    bool requireApproval,
    bool allowMemberChat,
    bool allowMemberGames,
    int maxMembers,
    List<String> allowedSports,
    List<String> blockedUsers,
  });
}

/// @nodoc
class __$$TeamSettingsImplCopyWithImpl<$Res>
    extends _$TeamSettingsCopyWithImpl<$Res, _$TeamSettingsImpl>
    implements _$$TeamSettingsImplCopyWith<$Res> {
  __$$TeamSettingsImplCopyWithImpl(
    _$TeamSettingsImpl _value,
    $Res Function(_$TeamSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowJoinRequests = null,
    Object? allowMemberInvites = null,
    Object? requireApproval = null,
    Object? allowMemberChat = null,
    Object? allowMemberGames = null,
    Object? maxMembers = null,
    Object? allowedSports = null,
    Object? blockedUsers = null,
  }) {
    return _then(
      _$TeamSettingsImpl(
        allowJoinRequests: null == allowJoinRequests
            ? _value.allowJoinRequests
            : allowJoinRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowMemberInvites: null == allowMemberInvites
            ? _value.allowMemberInvites
            : allowMemberInvites // ignore: cast_nullable_to_non_nullable
                  as bool,
        requireApproval: null == requireApproval
            ? _value.requireApproval
            : requireApproval // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowMemberChat: null == allowMemberChat
            ? _value.allowMemberChat
            : allowMemberChat // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowMemberGames: null == allowMemberGames
            ? _value.allowMemberGames
            : allowMemberGames // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxMembers: null == maxMembers
            ? _value.maxMembers
            : maxMembers // ignore: cast_nullable_to_non_nullable
                  as int,
        allowedSports: null == allowedSports
            ? _value._allowedSports
            : allowedSports // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        blockedUsers: null == blockedUsers
            ? _value._blockedUsers
            : blockedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamSettingsImpl implements _TeamSettings {
  const _$TeamSettingsImpl({
    this.allowJoinRequests = true,
    this.allowMemberInvites = true,
    this.requireApproval = false,
    this.allowMemberChat = false,
    this.allowMemberGames = false,
    this.maxMembers = 10,
    final List<String> allowedSports = const [],
    final List<String> blockedUsers = const [],
  }) : _allowedSports = allowedSports,
       _blockedUsers = blockedUsers;

  factory _$TeamSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool allowJoinRequests;
  @override
  @JsonKey()
  final bool allowMemberInvites;
  @override
  @JsonKey()
  final bool requireApproval;
  @override
  @JsonKey()
  final bool allowMemberChat;
  @override
  @JsonKey()
  final bool allowMemberGames;
  @override
  @JsonKey()
  final int maxMembers;
  final List<String> _allowedSports;
  @override
  @JsonKey()
  List<String> get allowedSports {
    if (_allowedSports is EqualUnmodifiableListView) return _allowedSports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedSports);
  }

  final List<String> _blockedUsers;
  @override
  @JsonKey()
  List<String> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  @override
  String toString() {
    return 'TeamSettings(allowJoinRequests: $allowJoinRequests, allowMemberInvites: $allowMemberInvites, requireApproval: $requireApproval, allowMemberChat: $allowMemberChat, allowMemberGames: $allowMemberGames, maxMembers: $maxMembers, allowedSports: $allowedSports, blockedUsers: $blockedUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamSettingsImpl &&
            (identical(other.allowJoinRequests, allowJoinRequests) ||
                other.allowJoinRequests == allowJoinRequests) &&
            (identical(other.allowMemberInvites, allowMemberInvites) ||
                other.allowMemberInvites == allowMemberInvites) &&
            (identical(other.requireApproval, requireApproval) ||
                other.requireApproval == requireApproval) &&
            (identical(other.allowMemberChat, allowMemberChat) ||
                other.allowMemberChat == allowMemberChat) &&
            (identical(other.allowMemberGames, allowMemberGames) ||
                other.allowMemberGames == allowMemberGames) &&
            (identical(other.maxMembers, maxMembers) ||
                other.maxMembers == maxMembers) &&
            const DeepCollectionEquality().equals(
              other._allowedSports,
              _allowedSports,
            ) &&
            const DeepCollectionEquality().equals(
              other._blockedUsers,
              _blockedUsers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    allowJoinRequests,
    allowMemberInvites,
    requireApproval,
    allowMemberChat,
    allowMemberGames,
    maxMembers,
    const DeepCollectionEquality().hash(_allowedSports),
    const DeepCollectionEquality().hash(_blockedUsers),
  );

  /// Create a copy of TeamSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamSettingsImplCopyWith<_$TeamSettingsImpl> get copyWith =>
      __$$TeamSettingsImplCopyWithImpl<_$TeamSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamSettingsImplToJson(this);
  }
}

abstract class _TeamSettings implements TeamSettings {
  const factory _TeamSettings({
    final bool allowJoinRequests,
    final bool allowMemberInvites,
    final bool requireApproval,
    final bool allowMemberChat,
    final bool allowMemberGames,
    final int maxMembers,
    final List<String> allowedSports,
    final List<String> blockedUsers,
  }) = _$TeamSettingsImpl;

  factory _TeamSettings.fromJson(Map<String, dynamic> json) =
      _$TeamSettingsImpl.fromJson;

  @override
  bool get allowJoinRequests;
  @override
  bool get allowMemberInvites;
  @override
  bool get requireApproval;
  @override
  bool get allowMemberChat;
  @override
  bool get allowMemberGames;
  @override
  int get maxMembers;
  @override
  List<String> get allowedSports;
  @override
  List<String> get blockedUsers;

  /// Create a copy of TeamSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamSettingsImplCopyWith<_$TeamSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
