import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvHelper {
  static EnvHelper? _instance;

  EnvHelper._();

  static EnvHelper get instance {
    _instance ??= EnvHelper._();

    return _instance!;
  }

  Future<void> load() => dotenv.load();

  String? operator [](String key) => dotenv.env[key];

  String? maybeGet(String key) => dotenv.maybeGet(key);

  String get(String key) => dotenv.get(key);
}
