abstract class BaseService {
  final String apiKey = "My API cey paste her";
  final String baseUrl = "https://api.quotable.io/random";

  Future<dynamic> getResponse(String url);
}
