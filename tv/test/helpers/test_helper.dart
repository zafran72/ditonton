import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/io_client.dart';
import 'package:tv/data/datasources/db/tv_database_helper.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/presentation/bloc/tv/bloc/tv_bloc.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}

class NowPlayingTvEventHelper extends Fake implements TvEvent {}

class NowPlayingTvStateHelper extends Fake implements TvState {}

class NowPlayingTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements NowPlayingTvBloc {}

class PopularTvEventHelper extends Fake implements TvEvent {}

class PopularTvStateHelper extends Fake implements TvState {}

class PopularTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements PopularTvBloc {}

class TopRatedTvEventHelper extends Fake implements TvEvent {}

class TopRatedTvStateHelper extends Fake implements TvState {}

class TopRatedTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements TopRatedTvBloc {}

class TvDetailEventHelper extends Fake implements TvEvent {}

class TvDetailStateHelper extends Fake implements TvState {}

class TvDetailBlocHelper extends MockBloc<TvEvent, TvState>
    implements TvDetailBloc {}

class RecommendationsTvEventHelper extends Fake implements TvEvent {}

class RecommendationsTvStateHelper extends Fake implements TvState {}

class RecommendationsTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements RecommendationTvBloc {}

class WatchlistTvEventHelper extends Fake implements TvEvent {}

class WatchlistTvStateHelper extends Fake implements TvState {}

class WatchlistTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements WatchlistTvBloc {}
