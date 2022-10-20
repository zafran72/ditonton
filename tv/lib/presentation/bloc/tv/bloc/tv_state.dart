part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvState {}

class TvLoading extends TvState {}

class TvHasData extends TvState {
  final List<Tv> tv;

  const TvHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvHasError extends TvState {
  final String message;

  const TvHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvState {
  final TvDetail tv;

  const TvDetailHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistTvHasData extends TvState {
  final List<Tv> watchlistTv;

  const WatchlistTvHasData(this.watchlistTv);

  @override
  List<Object> get props => [watchlistTv];
}

class WatchlistTvMessage extends TvState {
  final String message;

  const WatchlistTvMessage(this.message);
}

class LoadTvWatchlistData extends TvState {
  final bool status;

  const LoadTvWatchlistData(this.status);

  @override
  List<Object> get props => [status];
}
