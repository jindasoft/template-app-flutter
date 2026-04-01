import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static final String? authUrl = dotenv.env['AUTH_URL'];
  static final String? apiUrl = dotenv.env['API_URL'];
  static final String? imgUrl = dotenv.env['IMG_URL'];

  final String googleServerClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID']!;
  final String googlePeopleApiUrl = dotenv.env['GOOGLE_PEOPLE_API_URL']!;
}
