import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.id,
    required this.backdropPath,
    required this.name,
    required this.voteAverage,
    required this.overview,
    required this.posterPath,
    required this.genres,
    required this.seasons,
  });

  final int id;
  final String? backdropPath;
  final String name;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final List<Genre> genres;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        name,
        voteAverage,
        overview,
        posterPath,
        genres,
        seasons,
      ];
}
