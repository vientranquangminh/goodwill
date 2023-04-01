
import 'package:dio/dio.dart';
import 'package:goodwill/source/data/api/api_resources.dart';
import 'package:goodwill/source/models/joke.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiResources.devBaseUrl)
abstract class ApiClient {
  factory ApiClient(
    Dio dio, {
    String baseUrl,
  }) = _ApiClient;

  static const Type client = _ApiClient;

  @GET('${ApiResources.joke}{category}')
  Future<Joke> getJokes(@Path('category') String category);
}
