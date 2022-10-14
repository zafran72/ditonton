import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/tv_search_bloc.dart';

import '../provider/tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(mockSearchTv);
  });

  group('search tv bloc test', () {
    final tTvModel = Tv(
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
    final tTvList = <Tv>[tTvModel];
    const tQuery = 'dragon';
    test('initial state should be empty', () {
      expect(tvSearchBloc.state, TvSearchEmpty());
    });

    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvSearchLoading(),
        TvSearchHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      },
    );
  });
}
