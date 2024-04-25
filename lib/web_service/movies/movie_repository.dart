import 'package:we_works_movie_app/model/answer.dart';
import 'package:we_works_movie_app/storage/shared_preferences.dart';
import 'package:we_works_movie_app/web_service/base_repository.dart';
import 'package:we_works_movie_app/web_service/movies/movie_request.dart';

abstract class MovieRepository extends BaseRepository {
  Future<dynamic> getMoviesPlayingNow();

  Future<dynamic> getTopRatedMovies();

  Future<Answer> getConfiguration(String id);
}

class MovieRepositoryImpl extends MovieRepository {
  MovieRepositoryImpl({
    required this.preferences,
  });

  final Preferences preferences;
  final MovieRequest _request = MovieRequest();

  @override
  Future<dynamic> getMoviesPlayingNow() async {
    return _request.getMoviesPlayingNow();
  }

  @override
  Future<dynamic> getTopRatedMovies() async {
    return _request.getTopRatedMovies();
  }

  @override
  Future<Answer> getConfiguration(String id) async {
    return _request.getConfiguration();
  }
}
