// coverage:ignore-file

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()

///initializing service locator for the app
Future<void> configureInjection({String? environment}) async {
  getIt.init(environment: environment);
}

// ignore: lines_longer_than_80_chars
///Environments for service locator [dev] for development [prod] for production [stg] for staging
abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
  static const stg = 'stg';
}
