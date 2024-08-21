import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironConfig {
  static final username = dotenv.env['ADMIN_USERNAME'];
  static final password = dotenv.env['ADMIN_PASSWORD'];
}