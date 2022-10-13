import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';

import 'package:equatable/equatable.dart';

import '../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, SearchState> {
  final SearchMovies _moviesSearch;

  MovieSearchBloc(this._moviesSearch) : super(SearchEmpty()) {
    on<OnMovieQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _moviesSearch.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchMovieHasData(data));
          },
        );
      },
    );
  }
}
