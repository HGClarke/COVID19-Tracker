import 'package:covid19_tracker/utilities/api_service.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final url;
  Map<String, dynamic> headers;

  NetworkService(this.url, this.headers);

  Future<http.Response> fetchData() async {
    return http.get(url, headers: APIService.covidStatsHeaders);
  }
}
