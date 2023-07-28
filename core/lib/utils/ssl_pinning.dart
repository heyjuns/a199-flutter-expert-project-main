import 'package:core/utils/http_helper.dart';
import 'package:http/http.dart' as http;

class SSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await HttpHelper.createClient();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
