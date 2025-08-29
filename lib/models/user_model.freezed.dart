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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  Map<String, String> get sports => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;
  Map<String, int> get statistics => throw _privateConstructorUsedError;
  List<String> get teams => throw _privateConstructorUsedError;
  List<String> get games => throw _privateConstructorUsedError;
  List<String> get friends => throw _privateConstructorUsedError;
  List<String> get blockedUsers => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
  $Res call({
    String id,
    String email,
    String displayName,
    String? username,
    String? bio,
    String? city,
    String? country,
    String? profileImageUrl,
    Map<String, String> sports,
    Map<String, dynamic> preferences,
    Map<String, int> statistics,
    List<String> teams,
    List<String> games,
    List<String> friends,
    List<String> blockedUsers,
    bool isVerified,
    bool isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
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
    Object? email = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? bio = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? profileImageUrl = freezed,
    Object? sports = null,
    Object? preferences = null,
    Object? statistics = null,
    Object? teams = null,
    Object? games = null,
    Object? friends = null,
    Object? blockedUsers = null,
    Object? isVerified = null,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            sports: null == sports
                ? _value.sports
                : sports // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            preferences: null == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            statistics: null == statistics
                ? _value.statistics
                : statistics // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            teams: null == teams
                ? _value.teams
                : teams // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            games: null == games
                ? _value.games
                : games // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            friends: null == friends
                ? _value.friends
                : friends // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            blockedUsers: null == blockedUsers
                ? _value.blockedUsers
                : blockedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOnline: null == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSeen: freezed == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String displayName,
    String? username,
    String? bio,
    String? city,
    String? country,
    String? profileImageUrl,
    Map<String, String> sports,
    Map<String, dynamic> preferences,
    Map<String, int> statistics,
    List<String> teams,
    List<String> games,
    List<String> friends,
    List<String> blockedUsers,
    bool isVerified,
    bool isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? bio = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? profileImageUrl = freezed,
    Object? sports = null,
    Object? preferences = null,
    Object? statistics = null,
    Object? teams = null,
    Object? games = null,
    Object? friends = null,
    Object? blockedUsers = null,
    Object? isVerified = null,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        sports: null == sports
            ? _value._sports
            : sports // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        preferences: null == preferences
            ? _value._preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        statistics: null == statistics
            ? _value._statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        teams: null == teams
            ? _value._teams
            : teams // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        games: null == games
            ? _value._games
            : games // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        friends: null == friends
            ? _value._friends
            : friends // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        blockedUsers: null == blockedUsers
            ? _value._blockedUsers
            : blockedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOnline: null == isOnline
            ? _value.isOnline
            : isOnline // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSeen: freezed == lastSeen
            ? _value.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.email,
    required this.displayName,
    this.username,
    this.bio,
    this.city,
    this.country,
    this.profileImageUrl,
    final Map<String, String> sports = const {},
    final Map<String, dynamic> preferences = const {},
    final Map<String, int> statistics = const {},
    final List<String> teams = const [],
    final List<String> games = const [],
    final List<String> friends = const [],
    final List<String> blockedUsers = const [],
    this.isVerified = false,
    this.isOnline = false,
    this.lastSeen,
    this.createdAt,
    this.updatedAt,
  }) : _sports = sports,
       _preferences = preferences,
       _statistics = statistics,
       _teams = teams,
       _games = games,
       _friends = friends,
       _blockedUsers = blockedUsers;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final String? bio;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final String? profileImageUrl;
  final Map<String, String> _sports;
  @override
  @JsonKey()
  Map<String, String> get sports {
    if (_sports is EqualUnmodifiableMapView) return _sports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sports);
  }

  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  final Map<String, int> _statistics;
  @override
  @JsonKey()
  Map<String, int> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  final List<String> _teams;
  @override
  @JsonKey()
  List<String> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  final List<String> _games;
  @override
  @JsonKey()
  List<String> get games {
    if (_games is EqualUnmodifiableListView) return _games;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_games);
  }

  final List<String> _friends;
  @override
  @JsonKey()
  List<String> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
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
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  final DateTime? lastSeen;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, username: $username, bio: $bio, city: $city, country: $country, profileImageUrl: $profileImageUrl, sports: $sports, preferences: $preferences, statistics: $statistics, teams: $teams, games: $games, friends: $friends, blockedUsers: $blockedUsers, isVerified: $isVerified, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality().equals(other._sports, _sports) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ) &&
            const DeepCollectionEquality().equals(
              other._statistics,
              _statistics,
            ) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._games, _games) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality().equals(
              other._blockedUsers,
              _blockedUsers,
            ) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    email,
    displayName,
    username,
    bio,
    city,
    country,
    profileImageUrl,
    const DeepCollectionEquality().hash(_sports),
    const DeepCollectionEquality().hash(_preferences),
    const DeepCollectionEquality().hash(_statistics),
    const DeepCollectionEquality().hash(_teams),
    const DeepCollectionEquality().hash(_games),
    const DeepCollectionEquality().hash(_friends),
    const DeepCollectionEquality().hash(_blockedUsers),
    isVerified,
    isOnline,
    lastSeen,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String id,
    required final String email,
    required final String displayName,
    final String? username,
    final String? bio,
    final String? city,
    final String? country,
    final String? profileImageUrl,
    final Map<String, String> sports,
    final Map<String, dynamic> preferences,
    final Map<String, int> statistics,
    final List<String> teams,
    final List<String> games,
    final List<String> friends,
    final List<String> blockedUsers,
    final bool isVerified,
    final bool isOnline,
    final DateTime? lastSeen,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  String? get bio;
  @override
  String? get city;
  @override
  String? get country;
  @override
  String? get profileImageUrl;
  @override
  Map<String, String> get sports;
  @override
  Map<String, dynamic> get preferences;
  @override
  Map<String, int> get statistics;
  @override
  List<String> get teams;
  @override
  List<String> get games;
  @override
  List<String> get friends;
  @override
  List<String> get blockedUsers;
  @override
  bool get isVerified;
  @override
  bool get isOnline;
  @override
  DateTime? get lastSeen;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  int get gamesPlayed => throw _privateConstructorUsedError;
  int get gamesWon => throw _privateConstructorUsedError;
  int get gamesLost => throw _privateConstructorUsedError;
  int get mvps => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  int get totalAssists => throw _privateConstructorUsedError;
  int get totalRebounds => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalRating => throw _privateConstructorUsedError;
  int get ratingCount => throw _privateConstructorUsedError;

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call({
    int gamesPlayed,
    int gamesWon,
    int gamesLost,
    int mvps,
    int totalPoints,
    int totalAssists,
    int totalRebounds,
    double winRate,
    double averageRating,
    int totalRating,
    int ratingCount,
  });
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? gamesLost = null,
    Object? mvps = null,
    Object? totalPoints = null,
    Object? totalAssists = null,
    Object? totalRebounds = null,
    Object? winRate = null,
    Object? averageRating = null,
    Object? totalRating = null,
    Object? ratingCount = null,
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
            mvps: null == mvps
                ? _value.mvps
                : mvps // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
    _$UserStatsImpl value,
    $Res Function(_$UserStatsImpl) then,
  ) = __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int gamesPlayed,
    int gamesWon,
    int gamesLost,
    int mvps,
    int totalPoints,
    int totalAssists,
    int totalRebounds,
    double winRate,
    double averageRating,
    int totalRating,
    int ratingCount,
  });
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
    _$UserStatsImpl _value,
    $Res Function(_$UserStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? gamesLost = null,
    Object? mvps = null,
    Object? totalPoints = null,
    Object? totalAssists = null,
    Object? totalRebounds = null,
    Object? winRate = null,
    Object? averageRating = null,
    Object? totalRating = null,
    Object? ratingCount = null,
  }) {
    return _then(
      _$UserStatsImpl(
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
        mvps: null == mvps
            ? _value.mvps
            : mvps // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl({
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.gamesLost = 0,
    this.mvps = 0,
    this.totalPoints = 0,
    this.totalAssists = 0,
    this.totalRebounds = 0,
    this.winRate = 0.0,
    this.averageRating = 0.0,
    this.totalRating = 0,
    this.ratingCount = 0,
  });

  factory _$UserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsImplFromJson(json);

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
  final int mvps;
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
  String toString() {
    return 'UserStats(gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, mvps: $mvps, totalPoints: $totalPoints, totalAssists: $totalAssists, totalRebounds: $totalRebounds, winRate: $winRate, averageRating: $averageRating, totalRating: $totalRating, ratingCount: $ratingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.gamesPlayed, gamesPlayed) ||
                other.gamesPlayed == gamesPlayed) &&
            (identical(other.gamesWon, gamesWon) ||
                other.gamesWon == gamesWon) &&
            (identical(other.gamesLost, gamesLost) ||
                other.gamesLost == gamesLost) &&
            (identical(other.mvps, mvps) || other.mvps == mvps) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.totalAssists, totalAssists) ||
                other.totalAssists == totalAssists) &&
            (identical(other.totalRebounds, totalRebounds) ||
                other.totalRebounds == totalRebounds) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRating, totalRating) ||
                other.totalRating == totalRating) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    gamesPlayed,
    gamesWon,
    gamesLost,
    mvps,
    totalPoints,
    totalAssists,
    totalRebounds,
    winRate,
    averageRating,
    totalRating,
    ratingCount,
  );

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsImplToJson(this);
  }
}

abstract class _UserStats implements UserStats {
  const factory _UserStats({
    final int gamesPlayed,
    final int gamesWon,
    final int gamesLost,
    final int mvps,
    final int totalPoints,
    final int totalAssists,
    final int totalRebounds,
    final double winRate,
    final double averageRating,
    final int totalRating,
    final int ratingCount,
  }) = _$UserStatsImpl;

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$UserStatsImpl.fromJson;

  @override
  int get gamesPlayed;
  @override
  int get gamesWon;
  @override
  int get gamesLost;
  @override
  int get mvps;
  @override
  int get totalPoints;
  @override
  int get totalAssists;
  @override
  int get totalRebounds;
  @override
  double get winRate;
  @override
  double get averageRating;
  @override
  int get totalRating;
  @override
  int get ratingCount;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  String get language => throw _privateConstructorUsedError;
  String get theme => throw _privateConstructorUsedError;
  bool get notifications => throw _privateConstructorUsedError;
  bool get emailNotifications => throw _privateConstructorUsedError;
  bool get pushNotifications => throw _privateConstructorUsedError;
  bool get locationSharing => throw _privateConstructorUsedError;
  bool get profileVisibility => throw _privateConstructorUsedError;
  int get maxDistance => throw _privateConstructorUsedError;
  List<String> get favoriteSports => throw _privateConstructorUsedError;
  List<String> get blockedSports => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
    UserPreferences value,
    $Res Function(UserPreferences) then,
  ) = _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call({
    String language,
    String theme,
    bool notifications,
    bool emailNotifications,
    bool pushNotifications,
    bool locationSharing,
    bool profileVisibility,
    int maxDistance,
    List<String> favoriteSports,
    List<String> blockedSports,
  });
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? theme = null,
    Object? notifications = null,
    Object? emailNotifications = null,
    Object? pushNotifications = null,
    Object? locationSharing = null,
    Object? profileVisibility = null,
    Object? maxDistance = null,
    Object? favoriteSports = null,
    Object? blockedSports = null,
  }) {
    return _then(
      _value.copyWith(
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            theme: null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as String,
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            emailNotifications: null == emailNotifications
                ? _value.emailNotifications
                : emailNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            pushNotifications: null == pushNotifications
                ? _value.pushNotifications
                : pushNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            locationSharing: null == locationSharing
                ? _value.locationSharing
                : locationSharing // ignore: cast_nullable_to_non_nullable
                      as bool,
            profileVisibility: null == profileVisibility
                ? _value.profileVisibility
                : profileVisibility // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxDistance: null == maxDistance
                ? _value.maxDistance
                : maxDistance // ignore: cast_nullable_to_non_nullable
                      as int,
            favoriteSports: null == favoriteSports
                ? _value.favoriteSports
                : favoriteSports // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            blockedSports: null == blockedSports
                ? _value.blockedSports
                : blockedSports // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(
    _$UserPreferencesImpl value,
    $Res Function(_$UserPreferencesImpl) then,
  ) = __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String language,
    String theme,
    bool notifications,
    bool emailNotifications,
    bool pushNotifications,
    bool locationSharing,
    bool profileVisibility,
    int maxDistance,
    List<String> favoriteSports,
    List<String> blockedSports,
  });
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
    _$UserPreferencesImpl _value,
    $Res Function(_$UserPreferencesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? theme = null,
    Object? notifications = null,
    Object? emailNotifications = null,
    Object? pushNotifications = null,
    Object? locationSharing = null,
    Object? profileVisibility = null,
    Object? maxDistance = null,
    Object? favoriteSports = null,
    Object? blockedSports = null,
  }) {
    return _then(
      _$UserPreferencesImpl(
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        theme: null == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as String,
        notifications: null == notifications
            ? _value.notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        emailNotifications: null == emailNotifications
            ? _value.emailNotifications
            : emailNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        pushNotifications: null == pushNotifications
            ? _value.pushNotifications
            : pushNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        locationSharing: null == locationSharing
            ? _value.locationSharing
            : locationSharing // ignore: cast_nullable_to_non_nullable
                  as bool,
        profileVisibility: null == profileVisibility
            ? _value.profileVisibility
            : profileVisibility // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxDistance: null == maxDistance
            ? _value.maxDistance
            : maxDistance // ignore: cast_nullable_to_non_nullable
                  as int,
        favoriteSports: null == favoriteSports
            ? _value._favoriteSports
            : favoriteSports // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        blockedSports: null == blockedSports
            ? _value._blockedSports
            : blockedSports // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl({
    this.language = 'en',
    this.theme = 'system',
    this.notifications = true,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.locationSharing = false,
    this.profileVisibility = false,
    this.maxDistance = 10,
    final List<String> favoriteSports = const [],
    final List<String> blockedSports = const [],
  }) : _favoriteSports = favoriteSports,
       _blockedSports = blockedSports;

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String theme;
  @override
  @JsonKey()
  final bool notifications;
  @override
  @JsonKey()
  final bool emailNotifications;
  @override
  @JsonKey()
  final bool pushNotifications;
  @override
  @JsonKey()
  final bool locationSharing;
  @override
  @JsonKey()
  final bool profileVisibility;
  @override
  @JsonKey()
  final int maxDistance;
  final List<String> _favoriteSports;
  @override
  @JsonKey()
  List<String> get favoriteSports {
    if (_favoriteSports is EqualUnmodifiableListView) return _favoriteSports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteSports);
  }

  final List<String> _blockedSports;
  @override
  @JsonKey()
  List<String> get blockedSports {
    if (_blockedSports is EqualUnmodifiableListView) return _blockedSports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedSports);
  }

  @override
  String toString() {
    return 'UserPreferences(language: $language, theme: $theme, notifications: $notifications, emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, locationSharing: $locationSharing, profileVisibility: $profileVisibility, maxDistance: $maxDistance, favoriteSports: $favoriteSports, blockedSports: $blockedSports)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.emailNotifications, emailNotifications) ||
                other.emailNotifications == emailNotifications) &&
            (identical(other.pushNotifications, pushNotifications) ||
                other.pushNotifications == pushNotifications) &&
            (identical(other.locationSharing, locationSharing) ||
                other.locationSharing == locationSharing) &&
            (identical(other.profileVisibility, profileVisibility) ||
                other.profileVisibility == profileVisibility) &&
            (identical(other.maxDistance, maxDistance) ||
                other.maxDistance == maxDistance) &&
            const DeepCollectionEquality().equals(
              other._favoriteSports,
              _favoriteSports,
            ) &&
            const DeepCollectionEquality().equals(
              other._blockedSports,
              _blockedSports,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    language,
    theme,
    notifications,
    emailNotifications,
    pushNotifications,
    locationSharing,
    profileVisibility,
    maxDistance,
    const DeepCollectionEquality().hash(_favoriteSports),
    const DeepCollectionEquality().hash(_blockedSports),
  );

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(this);
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences({
    final String language,
    final String theme,
    final bool notifications,
    final bool emailNotifications,
    final bool pushNotifications,
    final bool locationSharing,
    final bool profileVisibility,
    final int maxDistance,
    final List<String> favoriteSports,
    final List<String> blockedSports,
  }) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  String get language;
  @override
  String get theme;
  @override
  bool get notifications;
  @override
  bool get emailNotifications;
  @override
  bool get pushNotifications;
  @override
  bool get locationSharing;
  @override
  bool get profileVisibility;
  @override
  int get maxDistance;
  @override
  List<String> get favoriteSports;
  @override
  List<String> get blockedSports;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
