// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late TvDetailBlocHelper movieDetailBlocHelper;
  late RecommendationsTvBlocHelper recommendationsTvBlocHelper;
  late WatchlistTvBlocHelper watchlistTvBlocHelper;

  setUp(() {
    movieDetailBlocHelper = TvDetailBlocHelper();
    registerFallbackValue(TvDetailEventHelper());
    registerFallbackValue(TvDetailStateHelper());

    recommendationsTvBlocHelper = RecommendationsTvBlocHelper();
    registerFallbackValue(RecommendationsTvEventHelper());
    registerFallbackValue(RecommendationsTvStateHelper());

    watchlistTvBlocHelper = WatchlistTvBlocHelper();
    registerFallbackValue(WatchlistTvEventHelper());
    registerFallbackValue(WatchlistTvStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => watchlistTvBlocHelper,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => recommendationsTvBlocHelper,
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
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => recommendationsTvBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(const LoadTvWatchlistData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => recommendationsTvBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(const LoadTvWatchlistData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => recommendationsTvBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(const LoadTvWatchlistData(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

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
  //       .thenReturn(const TvDetailHasData(testTvDetail));
  //   when(() => recommendationsTvBlocHelper.state)
  //       .thenReturn(TvHasData(testTvList));
  //   when(() => watchlistTvBlocHelper.state)
  //       .thenReturn(const LoadWatchlistData(false));

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
