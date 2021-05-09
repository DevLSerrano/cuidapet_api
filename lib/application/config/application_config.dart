import 'package:cuidapet_api/application/config/database_connection_configuration.dart';
import 'package:cuidapet_api/application/config/service_locator_config.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/application/logger/logger.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:get_it/get_it.dart';

class ApplicationConfig {
  void loadConfigApplication() async {
    await _loadEnv();
    _loadDatabaseConfig();
    _configLogger();
    _loadDependencies();
  }

  Future<void> _loadEnv() async => load();

  void _loadDatabaseConfig() {
    final databaseConfig = DatabaseConnectionConfiguration(
      host: env['DATABASE_HOST'] ?? env['databaseHost']!,
      user: env['DATABASE_USER'] ?? env['databaseUser']!,
      password: env['DATABASE_PASSWORD'] ?? env['databasePassword']!,
      databaseName: env['DATABASE_NAME'] ?? env['databaseName']!,
      port: int.tryParse(env['DATABASE_PORT'] ?? env['databsePort']!) ?? 0,
    );

    GetIt.I.registerSingleton(databaseConfig);
  }

  void _configLogger() =>
      GetIt.I.registerLazySingleton<ILogger>(() => Logger());

  void _loadDependencies() => configureDependencies();
}