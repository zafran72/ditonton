// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MovieDetailBlocHelper movieDetailBlocHelper;
  late RecommendationsMovieBlocHelper recommendationsMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUp(() {
    movieDetailBlocHelper = MovieDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    recommendationsMovieBlocHelper = RecommendationsMovieBlocHelper();
    registerFallbackValue(RecommendationsMovieEventHelper());
    registerFallbackValue(RecommendationsMovieStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => watchlistMovieBlocHelper,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (_) => recommendationsMovieBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(const LoadWatchlistData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(const LoadWatchlistData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(const LoadWatchlistData(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(() => movieDetailBlocHelper.state)
  //       .thenReturn(const MovieDetailHasData(testMovieDetail));
  //   when(() => recommendationsMovieBlocHelper.state)
  //       .thenReturn(MoviesHasData(testMovieList));
  //   when(() => watchlistMovieBlocHelper.state)
  //       .thenReturn(const LoadWatchlistData(false));

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
