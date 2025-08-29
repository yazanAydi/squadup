// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameModel _$GameModelFromJson(Map<String, dynamic> json) {
  return _GameModel.fromJson(json);
}

/// @nodoc
mixin _$GameModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sport => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  List<String> get players => throw _privateConstructorUsedError;
  List<String> get pendingRequests => throw _privateConstructorUsedError;
  int get currentPlayers => throw _privateConstructorUsedError;
  int get maxPlayers => throw _privateConstructorUsedError;
  int get minPlayers => throw _privateConstructorUsedError;
  DateTime get gameDateTime => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  GameType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get score => throw _privateConstructorUsedError;
  Map<String, dynamic> get statistics => throw _privateConstructorUsedError;
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;

  /// Serializes this GameModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameModelCopyWith<GameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameModelCopyWith<$Res> {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) then) =
      _$GameModelCopyWithImpl<$Res, GameModel>;
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
    String? venue,
    List<String> players,
    List<String> pendingRequests,
    int currentPlayers,
    int maxPlayers,
    int minPlayers,
    DateTime gameDateTime,
    GameStatus status,
    GameType type,
    Map<String, dynamic> score,
    Map<String, dynamic> statistics,
    Map<String, dynamic> settings,
    bool isPublic,
    bool isFree,
    double price,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class _$GameModelCopyWithImpl<$Res, $Val extends GameModel>
    implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameModel
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
    Object? venue = freezed,
    Object? players = null,
    Object? pendingRequests = null,
    Object? currentPlayers = null,
    Object? maxPlayers = null,
    Object? minPlayers = null,
    Object? gameDateTime = null,
    Object? status = null,
    Object? type = null,
    Object? score = null,
    Object? statistics = null,
    Object? settings = null,
    Object? isPublic = null,
    Object? isFree = null,
    Object? price = null,
    Object? currency = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
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
            venue: freezed == venue
                ? _value.venue
                : venue // ignore: cast_nullable_to_non_nullable
                      as String?,
            players: null == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pendingRequests: null == pendingRequests
                ? _value.pendingRequests
                : pendingRequests // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            currentPlayers: null == currentPlayers
                ? _value.currentPlayers
                : currentPlayers // ignore: cast_nullable_to_non_nullable
                      as int,
            maxPlayers: null == maxPlayers
                ? _value.maxPlayers
                : maxPlayers // ignore: cast_nullable_to_non_nullable
                      as int,
            minPlayers: null == minPlayers
                ? _value.minPlayers
                : minPlayers // ignore: cast_nullable_to_non_nullable
                      as int,
            gameDateTime: null == gameDateTime
                ? _value.gameDateTime
                : gameDateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GameStatus,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as GameType,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
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
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameModelImplCopyWith<$Res>
    implements $GameModelCopyWith<$Res> {
  factory _$$GameModelImplCopyWith(
    _$GameModelImpl value,
    $Res Function(_$GameModelImpl) then,
  ) = __$$GameModelImplCopyWithImpl<$Res>;
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
    String? venue,
    List<String> players,
    List<String> pendingRequests,
    int currentPlayers,
    int maxPlayers,
    int minPlayers,
    DateTime gameDateTime,
    GameStatus status,
    GameType type,
    Map<String, dynamic> score,
    Map<String, dynamic> statistics,
    Map<String, dynamic> settings,
    bool isPublic,
    bool isFree,
    double price,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class __$$GameModelImplCopyWithImpl<$Res>
    extends _$GameModelCopyWithImpl<$Res, _$GameModelImpl>
    implements _$$GameModelImplCopyWith<$Res> {
  __$$GameModelImplCopyWithImpl(
    _$GameModelImpl _value,
    $Res Function(_$GameModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameModel
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
    Object? venue = freezed,
    Object? players = null,
    Object? pendingRequests = null,
    Object? currentPlayers = null,
    Object? maxPlayers = null,
    Object? minPlayers = null,
    Object? gameDateTime = null,
    Object? status = null,
    Object? type = null,
    Object? score = null,
    Object? statistics = null,
    Object? settings = null,
    Object? isPublic = null,
    Object? isFree = null,
    Object? price = null,
    Object? currency = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _$GameModelImpl(
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
        venue: freezed == venue
            ? _value.venue
            : venue // ignore: cast_nullable_to_non_nullable
                  as String?,
        players: null == players
            ? _value._players
            : players // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pendingRequests: null == pendingRequests
            ? _value._pendingRequests
            : pendingRequests // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        currentPlayers: null == currentPlayers
            ? _value.currentPlayers
            : currentPlayers // ignore: cast_nullable_to_non_nullable
                  as int,
        maxPlayers: null == maxPlayers
            ? _value.maxPlayers
            : maxPlayers // ignore: cast_nullable_to_non_nullable
                  as int,
        minPlayers: null == minPlayers
            ? _value.minPlayers
            : minPlayers // ignore: cast_nullable_to_non_nullable
                  as int,
        gameDateTime: null == gameDateTime
            ? _value.gameDateTime
            : gameDateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GameStatus,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as GameType,
        score: null == score
            ? _value._score
            : score // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
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
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameModelImpl implements _GameModel {
  const _$GameModelImpl({
    required this.id,
    required this.name,
    required this.sport,
    required this.createdBy,
    this.description,
    this.location,
    this.city,
    this.country,
    this.venue,
    final List<String> players = const [],
    final List<String> pendingRequests = const [],
    this.currentPlayers = 0,
    this.maxPlayers = 0,
    this.minPlayers = 0,
    required this.gameDateTime,
    this.status = GameStatus.pending,
    this.type = GameType.casual,
    final Map<String, dynamic> score = const {},
    final Map<String, dynamic> statistics = const {},
    final Map<String, dynamic> settings = const {},
    this.isPublic = false,
    this.isFree = false,
    this.price = 0.0,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.startedAt,
    this.endedAt,
  }) : _players = players,
       _pendingRequests = pendingRequests,
       _score = score,
       _statistics = statistics,
       _settings = settings;

  factory _$GameModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameModelImplFromJson(json);

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
  final String? venue;
  final List<String> _players;
  @override
  @JsonKey()
  List<String> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
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
  final int currentPlayers;
  @override
  @JsonKey()
  final int maxPlayers;
  @override
  @JsonKey()
  final int minPlayers;
  @override
  final DateTime gameDateTime;
  @override
  @JsonKey()
  final GameStatus status;
  @override
  @JsonKey()
  final GameType type;
  final Map<String, dynamic> _score;
  @override
  @JsonKey()
  Map<String, dynamic> get score {
    if (_score is EqualUnmodifiableMapView) return _score;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_score);
  }

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
  final bool isFree;
  @override
  @JsonKey()
  final double price;
  @override
  final String? currency;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;

  @override
  String toString() {
    return 'GameModel(id: $id, name: $name, sport: $sport, createdBy: $createdBy, description: $description, location: $location, city: $city, country: $country, venue: $venue, players: $players, pendingRequests: $pendingRequests, currentPlayers: $currentPlayers, maxPlayers: $maxPlayers, minPlayers: $minPlayers, gameDateTime: $gameDateTime, status: $status, type: $type, score: $score, statistics: $statistics, settings: $settings, isPublic: $isPublic, isFree: $isFree, price: $price, currency: $currency, createdAt: $createdAt, updatedAt: $updatedAt, startedAt: $startedAt, endedAt: $endedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameModelImpl &&
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
            (identical(other.venue, venue) || other.venue == venue) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(
              other._pendingRequests,
              _pendingRequests,
            ) &&
            (identical(other.currentPlayers, currentPlayers) ||
                other.currentPlayers == currentPlayers) &&
            (identical(other.maxPlayers, maxPlayers) ||
                other.maxPlayers == maxPlayers) &&
            (identical(other.minPlayers, minPlayers) ||
                other.minPlayers == minPlayers) &&
            (identical(other.gameDateTime, gameDateTime) ||
                other.gameDateTime == gameDateTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._score, _score) &&
            const DeepCollectionEquality().equals(
              other._statistics,
              _statistics,
            ) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt));
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
    venue,
    const DeepCollectionEquality().hash(_players),
    const DeepCollectionEquality().hash(_pendingRequests),
    currentPlayers,
    maxPlayers,
    minPlayers,
    gameDateTime,
    status,
    type,
    const DeepCollectionEquality().hash(_score),
    const DeepCollectionEquality().hash(_statistics),
    const DeepCollectionEquality().hash(_settings),
    isPublic,
    isFree,
    price,
    currency,
    createdAt,
    updatedAt,
    startedAt,
    endedAt,
  ]);

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith =>
      __$$GameModelImplCopyWithImpl<_$GameModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameModelImplToJson(this);
  }
}

abstract class _GameModel implements GameModel {
  const factory _GameModel({
    required final String id,
    required final String name,
    required final String sport,
    required final String createdBy,
    final String? description,
    final String? location,
    final String? city,
    final String? country,
    final String? venue,
    final List<String> players,
    final List<String> pendingRequests,
    final int currentPlayers,
    final int maxPlayers,
    final int minPlayers,
    required final DateTime gameDateTime,
    final GameStatus status,
    final GameType type,
    final Map<String, dynamic> score,
    final Map<String, dynamic> statistics,
    final Map<String, dynamic> settings,
    final bool isPublic,
    final bool isFree,
    final double price,
    final String? currency,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? startedAt,
    final DateTime? endedAt,
  }) = _$GameModelImpl;

  factory _GameModel.fromJson(Map<String, dynamic> json) =
      _$GameModelImpl.fromJson;

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
  String? get venue;
  @override
  List<String> get players;
  @override
  List<String> get pendingRequests;
  @override
  int get currentPlayers;
  @override
  int get maxPlayers;
  @override
  int get minPlayers;
  @override
  DateTime get gameDateTime;
  @override
  GameStatus get status;
  @override
  GameType get type;
  @override
  Map<String, dynamic> get score;
  @override
  Map<String, dynamic> get statistics;
  @override
  Map<String, dynamic> get settings;
  @override
  bool get isPublic;
  @override
  bool get isFree;
  @override
  double get price;
  @override
  String? get currency;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;

  /// Create a copy of GameModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameScore _$GameScoreFromJson(Map<String, dynamic> json) {
  return _GameScore.fromJson(json);
}

/// @nodoc
mixin _$GameScore {
  Map<String, int> get teamScores => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;
  Map<String, dynamic> get statistics => throw _privateConstructorUsedError;
  String? get winner => throw _privateConstructorUsedError;
  String? get mvp => throw _privateConstructorUsedError;
  bool get isFinal => throw _privateConstructorUsedError;

  /// Serializes this GameScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameScoreCopyWith<GameScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameScoreCopyWith<$Res> {
  factory $GameScoreCopyWith(GameScore value, $Res Function(GameScore) then) =
      _$GameScoreCopyWithImpl<$Res, GameScore>;
  @useResult
  $Res call({
    Map<String, int> teamScores,
    Map<String, int> playerScores,
    Map<String, dynamic> statistics,
    String? winner,
    String? mvp,
    bool isFinal,
  });
}

/// @nodoc
class _$GameScoreCopyWithImpl<$Res, $Val extends GameScore>
    implements $GameScoreCopyWith<$Res> {
  _$GameScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamScores = null,
    Object? playerScores = null,
    Object? statistics = null,
    Object? winner = freezed,
    Object? mvp = freezed,
    Object? isFinal = null,
  }) {
    return _then(
      _value.copyWith(
            teamScores: null == teamScores
                ? _value.teamScores
                : teamScores // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            playerScores: null == playerScores
                ? _value.playerScores
                : playerScores // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            statistics: null == statistics
                ? _value.statistics
                : statistics // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            winner: freezed == winner
                ? _value.winner
                : winner // ignore: cast_nullable_to_non_nullable
                      as String?,
            mvp: freezed == mvp
                ? _value.mvp
                : mvp // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFinal: null == isFinal
                ? _value.isFinal
                : isFinal // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameScoreImplCopyWith<$Res>
    implements $GameScoreCopyWith<$Res> {
  factory _$$GameScoreImplCopyWith(
    _$GameScoreImpl value,
    $Res Function(_$GameScoreImpl) then,
  ) = __$$GameScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, int> teamScores,
    Map<String, int> playerScores,
    Map<String, dynamic> statistics,
    String? winner,
    String? mvp,
    bool isFinal,
  });
}

/// @nodoc
class __$$GameScoreImplCopyWithImpl<$Res>
    extends _$GameScoreCopyWithImpl<$Res, _$GameScoreImpl>
    implements _$$GameScoreImplCopyWith<$Res> {
  __$$GameScoreImplCopyWithImpl(
    _$GameScoreImpl _value,
    $Res Function(_$GameScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamScores = null,
    Object? playerScores = null,
    Object? statistics = null,
    Object? winner = freezed,
    Object? mvp = freezed,
    Object? isFinal = null,
  }) {
    return _then(
      _$GameScoreImpl(
        teamScores: null == teamScores
            ? _value._teamScores
            : teamScores // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        playerScores: null == playerScores
            ? _value._playerScores
            : playerScores // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        statistics: null == statistics
            ? _value._statistics
            : statistics // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        winner: freezed == winner
            ? _value.winner
            : winner // ignore: cast_nullable_to_non_nullable
                  as String?,
        mvp: freezed == mvp
            ? _value.mvp
            : mvp // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFinal: null == isFinal
            ? _value.isFinal
            : isFinal // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameScoreImpl implements _GameScore {
  const _$GameScoreImpl({
    final Map<String, int> teamScores = const {},
    final Map<String, int> playerScores = const {},
    final Map<String, dynamic> statistics = const {},
    this.winner,
    this.mvp,
    this.isFinal = false,
  }) : _teamScores = teamScores,
       _playerScores = playerScores,
       _statistics = statistics;

  factory _$GameScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameScoreImplFromJson(json);

  final Map<String, int> _teamScores;
  @override
  @JsonKey()
  Map<String, int> get teamScores {
    if (_teamScores is EqualUnmodifiableMapView) return _teamScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_teamScores);
  }

  final Map<String, int> _playerScores;
  @override
  @JsonKey()
  Map<String, int> get playerScores {
    if (_playerScores is EqualUnmodifiableMapView) return _playerScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerScores);
  }

  final Map<String, dynamic> _statistics;
  @override
  @JsonKey()
  Map<String, dynamic> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  @override
  final String? winner;
  @override
  final String? mvp;
  @override
  @JsonKey()
  final bool isFinal;

  @override
  String toString() {
    return 'GameScore(teamScores: $teamScores, playerScores: $playerScores, statistics: $statistics, winner: $winner, mvp: $mvp, isFinal: $isFinal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameScoreImpl &&
            const DeepCollectionEquality().equals(
              other._teamScores,
              _teamScores,
            ) &&
            const DeepCollectionEquality().equals(
              other._playerScores,
              _playerScores,
            ) &&
            const DeepCollectionEquality().equals(
              other._statistics,
              _statistics,
            ) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.mvp, mvp) || other.mvp == mvp) &&
            (identical(other.isFinal, isFinal) || other.isFinal == isFinal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_teamScores),
    const DeepCollectionEquality().hash(_playerScores),
    const DeepCollectionEquality().hash(_statistics),
    winner,
    mvp,
    isFinal,
  );

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameScoreImplCopyWith<_$GameScoreImpl> get copyWith =>
      __$$GameScoreImplCopyWithImpl<_$GameScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameScoreImplToJson(this);
  }
}

abstract class _GameScore implements GameScore {
  const factory _GameScore({
    final Map<String, int> teamScores,
    final Map<String, int> playerScores,
    final Map<String, dynamic> statistics,
    final String? winner,
    final String? mvp,
    final bool isFinal,
  }) = _$GameScoreImpl;

  factory _GameScore.fromJson(Map<String, dynamic> json) =
      _$GameScoreImpl.fromJson;

  @override
  Map<String, int> get teamScores;
  @override
  Map<String, int> get playerScores;
  @override
  Map<String, dynamic> get statistics;
  @override
  String? get winner;
  @override
  String? get mvp;
  @override
  bool get isFinal;

  /// Create a copy of GameScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameScoreImplCopyWith<_$GameScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameStats _$GameStatsFromJson(Map<String, dynamic> json) {
  return _GameStats.fromJson(json);
}

/// @nodoc
mixin _$GameStats {
  int get totalPoints => throw _privateConstructorUsedError;
  int get totalAssists => throw _privateConstructorUsedError;
  int get totalRebounds => throw _privateConstructorUsedError;
  int get totalSteals => throw _privateConstructorUsedError;
  int get totalBlocks => throw _privateConstructorUsedError;
  int get totalFouls => throw _privateConstructorUsedError;
  int get totalTurnovers => throw _privateConstructorUsedError;
  double get fieldGoalPercentage => throw _privateConstructorUsedError;
  double get threePointPercentage => throw _privateConstructorUsedError;
  double get freeThrowPercentage => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  int get totalSeconds => throw _privateConstructorUsedError;

  /// Serializes this GameStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStatsCopyWith<GameStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStatsCopyWith<$Res> {
  factory $GameStatsCopyWith(GameStats value, $Res Function(GameStats) then) =
      _$GameStatsCopyWithImpl<$Res, GameStats>;
  @useResult
  $Res call({
    int totalPoints,
    int totalAssists,
    int totalRebounds,
    int totalSteals,
    int totalBlocks,
    int totalFouls,
    int totalTurnovers,
    double fieldGoalPercentage,
    double threePointPercentage,
    double freeThrowPercentage,
    int totalMinutes,
    int totalSeconds,
  });
}

/// @nodoc
class _$GameStatsCopyWithImpl<$Res, $Val extends GameStats>
    implements $GameStatsCopyWith<$Res> {
  _$GameStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPoints = null,
    Object? totalAssists = null,
    Object? totalRebounds = null,
    Object? totalSteals = null,
    Object? totalBlocks = null,
    Object? totalFouls = null,
    Object? totalTurnovers = null,
    Object? fieldGoalPercentage = null,
    Object? threePointPercentage = null,
    Object? freeThrowPercentage = null,
    Object? totalMinutes = null,
    Object? totalSeconds = null,
  }) {
    return _then(
      _value.copyWith(
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
            totalSteals: null == totalSteals
                ? _value.totalSteals
                : totalSteals // ignore: cast_nullable_to_non_nullable
                      as int,
            totalBlocks: null == totalBlocks
                ? _value.totalBlocks
                : totalBlocks // ignore: cast_nullable_to_non_nullable
                      as int,
            totalFouls: null == totalFouls
                ? _value.totalFouls
                : totalFouls // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTurnovers: null == totalTurnovers
                ? _value.totalTurnovers
                : totalTurnovers // ignore: cast_nullable_to_non_nullable
                      as int,
            fieldGoalPercentage: null == fieldGoalPercentage
                ? _value.fieldGoalPercentage
                : fieldGoalPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            threePointPercentage: null == threePointPercentage
                ? _value.threePointPercentage
                : threePointPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            freeThrowPercentage: null == freeThrowPercentage
                ? _value.freeThrowPercentage
                : freeThrowPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            totalMinutes: null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSeconds: null == totalSeconds
                ? _value.totalSeconds
                : totalSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameStatsImplCopyWith<$Res>
    implements $GameStatsCopyWith<$Res> {
  factory _$$GameStatsImplCopyWith(
    _$GameStatsImpl value,
    $Res Function(_$GameStatsImpl) then,
  ) = __$$GameStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalPoints,
    int totalAssists,
    int totalRebounds,
    int totalSteals,
    int totalBlocks,
    int totalFouls,
    int totalTurnovers,
    double fieldGoalPercentage,
    double threePointPercentage,
    double freeThrowPercentage,
    int totalMinutes,
    int totalSeconds,
  });
}

/// @nodoc
class __$$GameStatsImplCopyWithImpl<$Res>
    extends _$GameStatsCopyWithImpl<$Res, _$GameStatsImpl>
    implements _$$GameStatsImplCopyWith<$Res> {
  __$$GameStatsImplCopyWithImpl(
    _$GameStatsImpl _value,
    $Res Function(_$GameStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPoints = null,
    Object? totalAssists = null,
    Object? totalRebounds = null,
    Object? totalSteals = null,
    Object? totalBlocks = null,
    Object? totalFouls = null,
    Object? totalTurnovers = null,
    Object? fieldGoalPercentage = null,
    Object? threePointPercentage = null,
    Object? freeThrowPercentage = null,
    Object? totalMinutes = null,
    Object? totalSeconds = null,
  }) {
    return _then(
      _$GameStatsImpl(
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
        totalSteals: null == totalSteals
            ? _value.totalSteals
            : totalSteals // ignore: cast_nullable_to_non_nullable
                  as int,
        totalBlocks: null == totalBlocks
            ? _value.totalBlocks
            : totalBlocks // ignore: cast_nullable_to_non_nullable
                  as int,
        totalFouls: null == totalFouls
            ? _value.totalFouls
            : totalFouls // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTurnovers: null == totalTurnovers
            ? _value.totalTurnovers
            : totalTurnovers // ignore: cast_nullable_to_non_nullable
                  as int,
        fieldGoalPercentage: null == fieldGoalPercentage
            ? _value.fieldGoalPercentage
            : fieldGoalPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        threePointPercentage: null == threePointPercentage
            ? _value.threePointPercentage
            : threePointPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        freeThrowPercentage: null == freeThrowPercentage
            ? _value.freeThrowPercentage
            : freeThrowPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        totalMinutes: null == totalMinutes
            ? _value.totalMinutes
            : totalMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSeconds: null == totalSeconds
            ? _value.totalSeconds
            : totalSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStatsImpl implements _GameStats {
  const _$GameStatsImpl({
    this.totalPoints = 0,
    this.totalAssists = 0,
    this.totalRebounds = 0,
    this.totalSteals = 0,
    this.totalBlocks = 0,
    this.totalFouls = 0,
    this.totalTurnovers = 0,
    this.fieldGoalPercentage = 0.0,
    this.threePointPercentage = 0.0,
    this.freeThrowPercentage = 0.0,
    this.totalMinutes = 0,
    this.totalSeconds = 0,
  });

  factory _$GameStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStatsImplFromJson(json);

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
  final int totalSteals;
  @override
  @JsonKey()
  final int totalBlocks;
  @override
  @JsonKey()
  final int totalFouls;
  @override
  @JsonKey()
  final int totalTurnovers;
  @override
  @JsonKey()
  final double fieldGoalPercentage;
  @override
  @JsonKey()
  final double threePointPercentage;
  @override
  @JsonKey()
  final double freeThrowPercentage;
  @override
  @JsonKey()
  final int totalMinutes;
  @override
  @JsonKey()
  final int totalSeconds;

  @override
  String toString() {
    return 'GameStats(totalPoints: $totalPoints, totalAssists: $totalAssists, totalRebounds: $totalRebounds, totalSteals: $totalSteals, totalBlocks: $totalBlocks, totalFouls: $totalFouls, totalTurnovers: $totalTurnovers, fieldGoalPercentage: $fieldGoalPercentage, threePointPercentage: $threePointPercentage, freeThrowPercentage: $freeThrowPercentage, totalMinutes: $totalMinutes, totalSeconds: $totalSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStatsImpl &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.totalAssists, totalAssists) ||
                other.totalAssists == totalAssists) &&
            (identical(other.totalRebounds, totalRebounds) ||
                other.totalRebounds == totalRebounds) &&
            (identical(other.totalSteals, totalSteals) ||
                other.totalSteals == totalSteals) &&
            (identical(other.totalBlocks, totalBlocks) ||
                other.totalBlocks == totalBlocks) &&
            (identical(other.totalFouls, totalFouls) ||
                other.totalFouls == totalFouls) &&
            (identical(other.totalTurnovers, totalTurnovers) ||
                other.totalTurnovers == totalTurnovers) &&
            (identical(other.fieldGoalPercentage, fieldGoalPercentage) ||
                other.fieldGoalPercentage == fieldGoalPercentage) &&
            (identical(other.threePointPercentage, threePointPercentage) ||
                other.threePointPercentage == threePointPercentage) &&
            (identical(other.freeThrowPercentage, freeThrowPercentage) ||
                other.freeThrowPercentage == freeThrowPercentage) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalPoints,
    totalAssists,
    totalRebounds,
    totalSteals,
    totalBlocks,
    totalFouls,
    totalTurnovers,
    fieldGoalPercentage,
    threePointPercentage,
    freeThrowPercentage,
    totalMinutes,
    totalSeconds,
  );

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStatsImplCopyWith<_$GameStatsImpl> get copyWith =>
      __$$GameStatsImplCopyWithImpl<_$GameStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStatsImplToJson(this);
  }
}

abstract class _GameStats implements GameStats {
  const factory _GameStats({
    final int totalPoints,
    final int totalAssists,
    final int totalRebounds,
    final int totalSteals,
    final int totalBlocks,
    final int totalFouls,
    final int totalTurnovers,
    final double fieldGoalPercentage,
    final double threePointPercentage,
    final double freeThrowPercentage,
    final int totalMinutes,
    final int totalSeconds,
  }) = _$GameStatsImpl;

  factory _GameStats.fromJson(Map<String, dynamic> json) =
      _$GameStatsImpl.fromJson;

  @override
  int get totalPoints;
  @override
  int get totalAssists;
  @override
  int get totalRebounds;
  @override
  int get totalSteals;
  @override
  int get totalBlocks;
  @override
  int get totalFouls;
  @override
  int get totalTurnovers;
  @override
  double get fieldGoalPercentage;
  @override
  double get threePointPercentage;
  @override
  double get freeThrowPercentage;
  @override
  int get totalMinutes;
  @override
  int get totalSeconds;

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStatsImplCopyWith<_$GameStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameSettings _$GameSettingsFromJson(Map<String, dynamic> json) {
  return _GameSettings.fromJson(json);
}

/// @nodoc
mixin _$GameSettings {
  bool get allowJoinRequests => throw _privateConstructorUsedError;
  bool get allowSpectators => throw _privateConstructorUsedError;
  bool get requireApproval => throw _privateConstructorUsedError;
  bool get allowChat => throw _privateConstructorUsedError;
  bool get allowLiveUpdates => throw _privateConstructorUsedError;
  int get maxSpectators => throw _privateConstructorUsedError;
  List<String> get allowedSports => throw _privateConstructorUsedError;
  List<String> get blockedUsers => throw _privateConstructorUsedError;

  /// Serializes this GameSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameSettingsCopyWith<GameSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSettingsCopyWith<$Res> {
  factory $GameSettingsCopyWith(
    GameSettings value,
    $Res Function(GameSettings) then,
  ) = _$GameSettingsCopyWithImpl<$Res, GameSettings>;
  @useResult
  $Res call({
    bool allowJoinRequests,
    bool allowSpectators,
    bool requireApproval,
    bool allowChat,
    bool allowLiveUpdates,
    int maxSpectators,
    List<String> allowedSports,
    List<String> blockedUsers,
  });
}

/// @nodoc
class _$GameSettingsCopyWithImpl<$Res, $Val extends GameSettings>
    implements $GameSettingsCopyWith<$Res> {
  _$GameSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowJoinRequests = null,
    Object? allowSpectators = null,
    Object? requireApproval = null,
    Object? allowChat = null,
    Object? allowLiveUpdates = null,
    Object? maxSpectators = null,
    Object? allowedSports = null,
    Object? blockedUsers = null,
  }) {
    return _then(
      _value.copyWith(
            allowJoinRequests: null == allowJoinRequests
                ? _value.allowJoinRequests
                : allowJoinRequests // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowSpectators: null == allowSpectators
                ? _value.allowSpectators
                : allowSpectators // ignore: cast_nullable_to_non_nullable
                      as bool,
            requireApproval: null == requireApproval
                ? _value.requireApproval
                : requireApproval // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowChat: null == allowChat
                ? _value.allowChat
                : allowChat // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowLiveUpdates: null == allowLiveUpdates
                ? _value.allowLiveUpdates
                : allowLiveUpdates // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxSpectators: null == maxSpectators
                ? _value.maxSpectators
                : maxSpectators // ignore: cast_nullable_to_non_nullable
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
abstract class _$$GameSettingsImplCopyWith<$Res>
    implements $GameSettingsCopyWith<$Res> {
  factory _$$GameSettingsImplCopyWith(
    _$GameSettingsImpl value,
    $Res Function(_$GameSettingsImpl) then,
  ) = __$$GameSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool allowJoinRequests,
    bool allowSpectators,
    bool requireApproval,
    bool allowChat,
    bool allowLiveUpdates,
    int maxSpectators,
    List<String> allowedSports,
    List<String> blockedUsers,
  });
}

/// @nodoc
class __$$GameSettingsImplCopyWithImpl<$Res>
    extends _$GameSettingsCopyWithImpl<$Res, _$GameSettingsImpl>
    implements _$$GameSettingsImplCopyWith<$Res> {
  __$$GameSettingsImplCopyWithImpl(
    _$GameSettingsImpl _value,
    $Res Function(_$GameSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowJoinRequests = null,
    Object? allowSpectators = null,
    Object? requireApproval = null,
    Object? allowChat = null,
    Object? allowLiveUpdates = null,
    Object? maxSpectators = null,
    Object? allowedSports = null,
    Object? blockedUsers = null,
  }) {
    return _then(
      _$GameSettingsImpl(
        allowJoinRequests: null == allowJoinRequests
            ? _value.allowJoinRequests
            : allowJoinRequests // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowSpectators: null == allowSpectators
            ? _value.allowSpectators
            : allowSpectators // ignore: cast_nullable_to_non_nullable
                  as bool,
        requireApproval: null == requireApproval
            ? _value.requireApproval
            : requireApproval // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowChat: null == allowChat
            ? _value.allowChat
            : allowChat // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowLiveUpdates: null == allowLiveUpdates
            ? _value.allowLiveUpdates
            : allowLiveUpdates // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxSpectators: null == maxSpectators
            ? _value.maxSpectators
            : maxSpectators // ignore: cast_nullable_to_non_nullable
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
class _$GameSettingsImpl implements _GameSettings {
  const _$GameSettingsImpl({
    this.allowJoinRequests = true,
    this.allowSpectators = true,
    this.requireApproval = false,
    this.allowChat = false,
    this.allowLiveUpdates = false,
    this.maxSpectators = 0,
    final List<String> allowedSports = const [],
    final List<String> blockedUsers = const [],
  }) : _allowedSports = allowedSports,
       _blockedUsers = blockedUsers;

  factory _$GameSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool allowJoinRequests;
  @override
  @JsonKey()
  final bool allowSpectators;
  @override
  @JsonKey()
  final bool requireApproval;
  @override
  @JsonKey()
  final bool allowChat;
  @override
  @JsonKey()
  final bool allowLiveUpdates;
  @override
  @JsonKey()
  final int maxSpectators;
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
    return 'GameSettings(allowJoinRequests: $allowJoinRequests, allowSpectators: $allowSpectators, requireApproval: $requireApproval, allowChat: $allowChat, allowLiveUpdates: $allowLiveUpdates, maxSpectators: $maxSpectators, allowedSports: $allowedSports, blockedUsers: $blockedUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSettingsImpl &&
            (identical(other.allowJoinRequests, allowJoinRequests) ||
                other.allowJoinRequests == allowJoinRequests) &&
            (identical(other.allowSpectators, allowSpectators) ||
                other.allowSpectators == allowSpectators) &&
            (identical(other.requireApproval, requireApproval) ||
                other.requireApproval == requireApproval) &&
            (identical(other.allowChat, allowChat) ||
                other.allowChat == allowChat) &&
            (identical(other.allowLiveUpdates, allowLiveUpdates) ||
                other.allowLiveUpdates == allowLiveUpdates) &&
            (identical(other.maxSpectators, maxSpectators) ||
                other.maxSpectators == maxSpectators) &&
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
    allowSpectators,
    requireApproval,
    allowChat,
    allowLiveUpdates,
    maxSpectators,
    const DeepCollectionEquality().hash(_allowedSports),
    const DeepCollectionEquality().hash(_blockedUsers),
  );

  /// Create a copy of GameSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSettingsImplCopyWith<_$GameSettingsImpl> get copyWith =>
      __$$GameSettingsImplCopyWithImpl<_$GameSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameSettingsImplToJson(this);
  }
}

abstract class _GameSettings implements GameSettings {
  const factory _GameSettings({
    final bool allowJoinRequests,
    final bool allowSpectators,
    final bool requireApproval,
    final bool allowChat,
    final bool allowLiveUpdates,
    final int maxSpectators,
    final List<String> allowedSports,
    final List<String> blockedUsers,
  }) = _$GameSettingsImpl;

  factory _GameSettings.fromJson(Map<String, dynamic> json) =
      _$GameSettingsImpl.fromJson;

  @override
  bool get allowJoinRequests;
  @override
  bool get allowSpectators;
  @override
  bool get requireApproval;
  @override
  bool get allowChat;
  @override
  bool get allowLiveUpdates;
  @override
  int get maxSpectators;
  @override
  List<String> get allowedSports;
  @override
  List<String> get blockedUsers;

  /// Create a copy of GameSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameSettingsImplCopyWith<_$GameSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
