import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;

  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MovieDetailBloc detailMovieBloc;
  late RecommendationMovieBloc recommendationMovieBloc;
  late WatchlistMovieBloc watchListMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();

    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
    detailMovieBloc = MovieDetailBloc(mockGetMovieDetail,
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
    watchListMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: 'name')],
  );

  const tId = 1;

  group('Get now playing movies', () {
    test('initial state must be empty', () {
      expect(nowPlayingMoviesBloc.state, MoviesEmpty());
    });

    blocTest<NowPlayingMoviesBloc, MovieBlocState>(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, MovieBlocState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMoviesBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('Get Popular movies', () {
    test('initial state must be empty', () {
      expect(popularMoviesBloc.state, MoviesEmpty());
    });

    blocTest<PopularMoviesBloc, MovieBlocState>(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('Get Top Rated movies', () {
    test('initial state must be empty', () {
      expect(topRatedMoviesBloc.state, MoviesEmpty());
    });

    blocTest<TopRatedMoviesBloc, MovieBlocState>(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('Get Recommended movies', () {
    test('initial state must be empty', () {
      expect(recommendationMovieBloc.state, MoviesEmpty());
    });

    blocTest<RecommendationMovieBloc, MovieBlocState>(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMovieBloc;
      },
      act: (RecommendationMovieBloc bloc) =>
          bloc.add(const FetchMovieRecommendations(tId)),
      expect: () => [
        MoviesLoading(),
        MoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationMovieBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return recommendationMovieBloc;
      },
      act: (RecommendationMovieBloc bloc) =>
          bloc.add(const FetchMovieRecommendations(tId)),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Get Details movies', () {
    test('initial state must be empty', () {
      expect(detailMovieBloc.state, MoviesEmpty());
    });

    blocTest<MovieDetailBloc, MovieBlocState>(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MoviesLoading(),
        const MovieDetailHasData(tMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieBlocState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
    group('load watchlist', () {
      blocTest<MovieDetailBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return detailMovieBloc;
        },
        act: (MovieDetailBloc bloc) =>
            bloc.add(const LoadWatchlistMovieStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const LoadWatchlistData(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(tId));
        },
      );

      blocTest<MovieDetailBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return detailMovieBloc;
        },
        act: (MovieDetailBloc bloc) =>
            bloc.add(const LoadWatchlistMovieStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const LoadWatchlistData(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(tId));
        },
      );
    });

    group('add watchlist', () {
      blocTest<MovieDetailBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(tMovieDetail)).thenAnswer((_) async =>
              const Right(MovieDetailBloc.watchlistAddSuccessMessage));
          return detailMovieBloc;
        },
        act: (MovieDetailBloc bloc) =>
            bloc.add(const AddWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const WatchlistMoviesMessage(
              MovieDetailBloc.watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockSaveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return detailMovieBloc;
        },
        act: (MovieDetailBloc bloc) =>
            bloc.add(const AddWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const MoviesHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tMovieDetail));
        },
      );
    });

    group('remove watchlist', () {
      blocTest<MovieDetailBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async =>
                  const Right(MovieDetailBloc.watchlistAddSuccessMessage));
          return detailMovieBloc;
        },
        act: (MovieDetailBloc bloc) =>
            bloc.add(const RemoveWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const WatchlistMoviesMessage(
              MovieDetailBloc.watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return detailMovieBloc;
        },
        act: (MovieDetailBloc bloc) =>
            bloc.add(const RemoveWatchlistMovies(tMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const MoviesHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tMovieDetail));
        },
      );
    });
  });

  group('Get watchlist movies', () {
    test('initial state must be empty', () {
      expect(watchListMovieBloc.state, MoviesEmpty());
    });

    test('initial state should be empty', () {
      expect(watchListMovieBloc.state, MoviesEmpty());
    });

    group('Fetch', () {
      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          WatchlistMovieHasData(tMovieList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<WatchlistMovieBloc, MovieBlocState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchListMovieBloc;
        },
        act: (WatchlistMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MoviesLoading(),
          const MoviesHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    });
  });
}
