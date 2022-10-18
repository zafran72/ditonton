part of 'movie_bloc.dart';

abstract class MovieBlocEvent extends Equatable {
  const MovieBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MovieBlocEvent {}

class FetchPopularMovies extends MovieBlocEvent {}

class FetchTopRatedMovies extends MovieBlocEvent {}

class FetchMovieDetail extends MovieBlocEvent {
  final int id;
  const FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchMovieRecommendations extends MovieBlocEvent {
  final int id;
  const FetchMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistMovies extends MovieBlocEvent {}

class AddWatchlistMovies extends MovieBlocEvent {
  final MovieDetail movie;

  const AddWatchlistMovies(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovies extends MovieBlocEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovies(this.movie);
  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatus extends MovieBlocEvent {
  final int id;

  const LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
