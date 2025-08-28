import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('es'),
  ];

  // Localized strings
  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get findTeams => _localizedValues[locale.languageCode]!['findTeams']!;
  String get searchTeams => _localizedValues[locale.languageCode]!['searchTeams']!;
  String get noTeamsFound => _localizedValues[locale.languageCode]!['noTeamsFound']!;
  String get tryAdjustingSearch => _localizedValues[locale.languageCode]!['tryAdjustingSearch']!;
  String get teamDetails => _localizedValues[locale.languageCode]!['teamDetails']!;
  String get teamInformation => _localizedValues[locale.languageCode]!['teamInformation']!;
  String get joinTeam => _localizedValues[locale.languageCode]!['joinTeam']!;
  String get location => _localizedValues[locale.languageCode]!['location']!;
  String get sport => _localizedValues[locale.languageCode]!['sport']!;
  String get members => _localizedValues[locale.languageCode]!['members']!;
  String get created => _localizedValues[locale.languageCode]!['created']!;
  String get unknown => _localizedValues[locale.languageCode]!['unknown']!;
  String get unknownLocation => _localizedValues[locale.languageCode]!['unknownLocation']!;
  String get players => _localizedValues[locale.languageCode]!['players']!;
  String get errorLoadingTeams => _localizedValues[locale.languageCode]!['errorLoadingTeams']!;
  String get all => _localizedValues[locale.languageCode]!['all']!;
  String get basketball => _localizedValues[locale.languageCode]!['basketball']!;
  String get football => _localizedValues[locale.languageCode]!['football']!;
  String get soccer => _localizedValues[locale.languageCode]!['soccer']!;
  String get tennis => _localizedValues[locale.languageCode]!['tennis']!;
  String get volleyball => _localizedValues[locale.languageCode]!['volleyball']!;

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'SquadUp',
      'findTeams': 'Find Teams',
      'searchTeams': 'Search teams...',
      'noTeamsFound': 'No teams found',
      'tryAdjustingSearch': 'Try adjusting your search or filters',
      'teamDetails': 'Team Details',
      'teamInformation': 'Team Information',
      'joinTeam': 'Join Team',
      'location': 'Location',
      'sport': 'Sport',
      'members': 'Members',
      'created': 'Created',
      'unknown': 'Unknown',
      'unknownLocation': 'Unknown Location',
      'players': 'players',
      'errorLoadingTeams': 'Error loading teams',
      'all': 'All',
      'basketball': 'Basketball',
      'football': 'Football',
      'soccer': 'Soccer',
      'tennis': 'Tennis',
      'volleyball': 'Volleyball',
    },
    'ar': {
      'appTitle': 'سكواد أب',
      'findTeams': 'البحث عن الفرق',
      'searchTeams': 'البحث عن الفرق...',
      'noTeamsFound': 'لم يتم العثور على فرق',
      'tryAdjustingSearch': 'حاول تعديل البحث أو الفلاتر',
      'teamDetails': 'تفاصيل الفريق',
      'teamInformation': 'معلومات الفريق',
      'joinTeam': 'انضم للفريق',
      'location': 'الموقع',
      'sport': 'الرياضة',
      'members': 'الأعضاء',
      'created': 'تم الإنشاء',
      'unknown': 'غير معروف',
      'unknownLocation': 'موقع غير معروف',
      'players': 'لاعبين',
      'errorLoadingTeams': 'خطأ في تحميل الفرق',
      'all': 'الكل',
      'basketball': 'كرة السلة',
      'football': 'كرة القدم الأمريكية',
      'soccer': 'كرة القدم',
      'tennis': 'التنس',
      'volleyball': 'الكرة الطائرة',
    },
    'es': {
      'appTitle': 'SquadUp',
      'findTeams': 'Encontrar Equipos',
      'searchTeams': 'Buscar equipos...',
      'noTeamsFound': 'No se encontraron equipos',
      'tryAdjustingSearch': 'Intenta ajustar tu búsqueda o filtros',
      'teamDetails': 'Detalles del Equipo',
      'teamInformation': 'Información del Equipo',
      'joinTeam': 'Unirse al Equipo',
      'location': 'Ubicación',
      'sport': 'Deporte',
      'members': 'Miembros',
      'created': 'Creado',
      'unknown': 'Desconocido',
      'unknownLocation': 'Ubicación Desconocida',
      'players': 'jugadores',
      'errorLoadingTeams': 'Error al cargar equipos',
      'all': 'Todos',
      'basketball': 'Baloncesto',
      'football': 'Fútbol Americano',
      'soccer': 'Fútbol',
      'tennis': 'Tenis',
      'volleyball': 'Voleibol',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
