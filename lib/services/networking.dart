import 'package:http/http.dart' as http;

class NetworkService {
  final url;

  NetworkService(this.url);

  Future<http.Response> fetchData() async {
    return http.get(url);
  }
}
