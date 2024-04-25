import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:we_works_movie_app/model/answer.dart';
import 'package:we_works_movie_app/resources/strings/constants.dart';
import 'package:we_works_movie_app/resources/strings/endpoints.dart';
import 'package:we_works_movie_app/utils/extensions/response_extensions.dart';
import 'package:we_works_movie_app/web_service/app_exceptions.dart';
import 'package:we_works_movie_app/web_service/base_request.dart';

class MovieRequest extends BaseRequest {
  Future<dynamic> getMoviesPlayingNow({
    String language = StringConstants.englishLanguageCode,
    int page = 1,
  }) async {
    final http.Response? response = await constructAndExecuteRequest(
      endPoint: EndPoints.moviesNowPlaying,
      method: HttpMethod.get,
      queryParameters: {
        "language": language,
        "page": page,
      },
    );
    if (response!.isSuccessful()) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw AppException(response).throwExceptionForResponse();
    }
  }

  Future<dynamic> getTopRatedMovies({
    String language = StringConstants.englishLanguageCode,
    int page = 1,
  }) async {
    final http.Response? response = await constructAndExecuteRequest(
      endPoint: EndPoints.topRatedMovies,
      method: HttpMethod.get,
    );
    if (response!.isSuccessful()) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw AppException(response).throwExceptionForResponse();
    }
  }

  Future<Answer> getConfiguration() async {
    final http.Response? response = await constructAndExecuteRequest(
      endPoint: EndPoints.configuration,
      method: HttpMethod.get,
    );
    if (response!.isSuccessful()) {
      return Answer.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw AppException(response).throwExceptionForResponse();
    }
  }
}
