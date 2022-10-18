import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

class NowPlayingMoviesEventHelper extends Fake implements MovieBlocEvent {}

class NowPlayingMoviesStateHelper extends Fake implements MovieBlocState {}

class NowPlayingMoviesBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements NowPlayingMoviesBloc {}

class PopularMoviesEventHelper extends Fake implements MovieBlocEvent {}

class PopularMoviesStateHelper extends Fake implements MovieBlocState {}

class PopularMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements PopularMoviesBloc {}

class TopRatedMoviesEventHelper extends Fake implements MovieBlocEvent {}

class TopRatedMoviesStateHelper extends Fake implements MovieBlocState {}

class TopRatedMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements TopRatedMoviesBloc {}

class MovieDetailEventHelper extends Fake implements MovieBlocEvent {}

class MovieDetailStateHelper extends Fake implements MovieBlocState {}

class MovieDetailBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements MovieDetailBloc {}

class RecommendationsMovieEventHelper extends Fake implements MovieBlocEvent {}

class RecommendationsMovieStateHelper extends Fake implements MovieBlocState {}

class RecommendationsMovieBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements RecommendationMovieBloc {}

class WatchlistMovieEventHelper extends Fake implements MovieBlocEvent {}

class WatchlistMovieStateHelper extends Fake implements MovieBlocState {}

class WatchlistMovieBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements WatchlistMovieBloc {}
