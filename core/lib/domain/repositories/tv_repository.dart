import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/core.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendation(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> tvSaveWatchList(TvDetail tv);
  Future<Either<Failure, String>> tvRemoveWatchlist(TvDetail tv);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
