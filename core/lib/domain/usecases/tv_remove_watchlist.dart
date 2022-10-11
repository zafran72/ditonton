import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class TvRemoveWatchlist {
  final TvRepository repository;

  TvRemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.tvRemoveWatchlist(tv);
  }
}
