import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/tv_remove_watchlist.dart';
import 'package:tv/domain/usecases/tv_save_watchlist.dart';
import 'package:tv/presentation/bloc/tv/bloc/tv_bloc.dart';

import 'tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
  GetPopularTv,
  GetTopRatedTv,
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistTv,
  GetWatchlistTvStatus,
  TvRemoveWatchlist,
  TvSaveWatchlist,
])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockTvRemoveWatchlist mockTvRemoveWatchlist;
  late MockTvSaveWatchlist mockTvSaveWatchlist;

  late NowPlayingTvBloc nowPlayingTvBloc;
  late PopularTvBloc popularTvBloc;
  late TopRatedTvBloc topRatedTvBloc;
  late TvDetailBloc detailTvBloc;
  late RecommendationTvBloc recommendationTvBloc;
  late WatchlistTvBloc watchListTvBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockTvRemoveWatchlist = MockTvRemoveWatchlist();
    mockTvSaveWatchlist = MockTvSaveWatchlist();

    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
    recommendationTvBloc = RecommendationTvBloc(mockGetTvRecommendations);
    detailTvBloc = TvDetailBloc(mockGetTvDetail);
    watchListTvBloc = WatchlistTvBloc(mockGetWatchlistTv,
        mockGetWatchlistTvStatus, mockTvSaveWatchlist, mockTvRemoveWatchlist);
  });

  final tTv = Tv(
    backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
    firstAirDate: '2022-08-21',
    genreIds: const [10765, 18, 10759],
    id: 94997,
    name: 'House of the Dragon',
    originCountry: const ["US"],
    originalLanguage: 'en',
    originalName: 'House of the Dragon',
    overview:
        'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
    popularity: 7222.052,
    posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
    voteAverage: 8.6,
    voteCount: 1564,
  );

  final tTvList = <Tv>[tTv];

  const tTvDetail = TvDetail(
    id: 1,
    backdropPath: 'backdropPath',
    name: 'name',
    voteAverage: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    genres: [Genre(id: 1, name: 'Action')],
    seasons: [
      Season(
          id: 1, name: 'Season 1', episodeCount: 1, posterPath: 'posterPath'),
    ],
  );

  const tId = 1;

  group('Get now playing tv', () {
    test('initial state must be empty', () {
      expect(nowPlayingTvBloc.state, TvEmpty());
    });

    blocTest<NowPlayingTvBloc, TvState>(
      'should emit[loading, tvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTv()),
      expect: () => [
        TvLoading(),
        TvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<NowPlayingTvBloc, TvState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (NowPlayingTvBloc bloc) => bloc.add(FetchNowPlayingTv()),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  });

  group('Get Popular tv', () {
    test('initial state must be empty', () {
      expect(popularTvBloc.state, TvEmpty());
    });

    blocTest<PopularTvBloc, TvState>(
      'should emit[loading, tvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (PopularTvBloc bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        TvLoading(),
        TvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, TvState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (PopularTvBloc bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });

  group('Get Top Rated tv', () {
    test('initial state must be empty', () {
      expect(topRatedTvBloc.state, TvEmpty());
    });

    blocTest<TopRatedTvBloc, TvState>(
      'should emit[loading, tvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        TvLoading(),
        TvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TvState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });

  group('Get Recommended tv', () {
    test('initial state must be empty', () {
      expect(recommendationTvBloc.state, TvEmpty());
    });

    blocTest<RecommendationTvBloc, TvState>(
      'should emit[loading, tvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvList));
        return recommendationTvBloc;
      },
      act: (RecommendationTvBloc bloc) =>
          bloc.add(const FetchTvRecommendations(tId)),
      expect: () => [
        TvLoading(),
        TvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationTvBloc, TvState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return recommendationTvBloc;
      },
      act: (RecommendationTvBloc bloc) =>
          bloc.add(const FetchTvRecommendations(tId)),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('Get Details tv', () {
    test('initial state must be empty', () {
      expect(detailTvBloc.state, TvEmpty());
    });

    blocTest<TvDetailBloc, TvState>(
      'should emit[loading, tvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(tTvDetail));
        return detailTvBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        TvLoading(),
        const TvDetailHasData(tTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });

  group('Get watchlist tv', () {
    test('initial state must be empty', () {
      expect(watchListTvBloc.state, TvEmpty());
    });

    test('initial state should be empty', () {
      expect(watchListTvBloc.state, TvEmpty());
    });

    group('Fetch', () {
      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTv()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          WatchlistTvHasData(tTvList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );

      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTv()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const TvHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );
    });

    group('load watchlist', () {
      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTvStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) =>
            bloc.add(const LoadWatchlistTvStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const LoadTvWatchlistData(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTvStatus.execute(tId));
        },
      );

      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockGetWatchlistTvStatus.execute(tId))
              .thenAnswer((_) async => false);
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) =>
            bloc.add(const LoadWatchlistTvStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const LoadTvWatchlistData(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTvStatus.execute(tId));
        },
      );
    });

    group('add watchlist', () {
      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockTvSaveWatchlist.execute(tTvDetail)).thenAnswer((_) async =>
              const Right(WatchlistTvBloc.watchlistAddSuccessMessage));
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) =>
            bloc.add(const AddWatchlistTv(tTvDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const WatchlistTvMessage(WatchlistTvBloc.watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockTvSaveWatchlist.execute(tTvDetail));
        },
      );

      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockTvSaveWatchlist.execute(tTvDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) =>
            bloc.add(const AddWatchlistTv(tTvDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const TvHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockTvSaveWatchlist.execute(tTvDetail));
        },
      );
    });

    group('remove watchlist', () {
      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockTvRemoveWatchlist.execute(tTvDetail)).thenAnswer((_) async =>
              const Right(WatchlistTvBloc.watchlistAddSuccessMessage));
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) =>
            bloc.add(const RemoveWatchlistTv(tTvDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const WatchlistTvMessage(WatchlistTvBloc.watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockTvRemoveWatchlist.execute(tTvDetail));
        },
      );

      blocTest<WatchlistTvBloc, TvState>(
        'Should emit [Loading, Error] when get data is unsuccessful',
        build: () {
          when(mockTvRemoveWatchlist.execute(tTvDetail)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchListTvBloc;
        },
        act: (WatchlistTvBloc bloc) =>
            bloc.add(const RemoveWatchlistTv(tTvDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvLoading(),
          const TvHasError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockTvRemoveWatchlist.execute(tTvDetail));
        },
      );
    });
  });
}
