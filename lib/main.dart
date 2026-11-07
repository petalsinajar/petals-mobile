import 'package:petalsinajar/app/app.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/bootstrap.dart';

void main() => bootstrap(App.new, config: AppConfig.fromEnvironment());
