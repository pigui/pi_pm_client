import 'package:pi_pm_client/core/environments/environment.dart';

class Network {
  const Network(this._env);
  final Environment _env;

  get apiUrl {
    return _env.apiUrl;
  }
}
