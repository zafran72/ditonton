import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/tv_remove_watchlist.dart';
import 'package:tv/domain/usecases/tv_save_watchlist.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class NowPlayingTvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv _getNowPlayingTv;

  NowPlayingTvBloc(this._getNowPlayingTv) : super(TvEmpty()) {
    on<FetchNowPlayingTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getNowPlayingTv.execute();

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (tvData) {
          emit(TvHasData(tvData));
        },
      );
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(TvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (tvData) {
          emit(TvHasData(tvData));
        },
      );
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TvEmpty()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (tvData) {
          emit(TvHasData(tvData));
        },
      );
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      final id = event.id;

      emit(TvLoading());
      final result = await _getTvDetail.execute(id);

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (tv) {
          emit(TvDetailHasData(tv));
        },
      );
    });
  }
}

class RecommendationTvBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(this._getTvRecommendations) : super(TvEmpty()) {
    on<FetchTvRecommendations>((event, emit) async {
      final int id = event.id;

      emit(TvLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (tvData) {
          emit(TvHasData(tvData));
        },
      );
    });
  }
}

class WatchlistTvBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTv getWatchlistTv;
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final TvSaveWatchlist tvSaveWatchlist;
  final TvRemoveWatchlist tvRemoveWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvBloc(this.getWatchlistTv, this.getWatchlistTvStatus,
      this.tvSaveWatchlist, this.tvRemoveWatchlist)
      : super(TvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async {
      emit(TvLoading());
      final result = await getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (tvData) {
          emit(WatchlistTvHasData(tvData));
        },
      );
    });

    on<AddWatchlistTv>((event, emit) async {
      final tv = event.tv;

      emit(TvLoading());
      final result = await tvSaveWatchlist.execute(tv);

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (successMessage) {
          emit(
            WatchlistTvMessage(successMessage),
          );
        },
      );
    });

    on<RemoveWatchlistTv>((event, emit) async {
      final tv = event.tv;

      emit(TvLoading());
      final result = await tvRemoveWatchlist.execute(tv);

      result.fold(
        (failure) {
          emit(TvHasError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvMessage(successMessage));
        },
      );
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final id = event.id;

      emit(TvLoading());
      final result = await getWatchlistTvStatus.execute(id);

      emit(LoadTvWatchlistData(result));
    });
  }
}
