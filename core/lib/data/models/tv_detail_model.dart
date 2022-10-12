import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
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
  final List<GenreModel> genres;
  final List<SeasonModel> seasons;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        id: json["id"],
        backdropPath: json["backdrop_path"],
        name: json["name"],
        voteAverage: json["vote_average"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrop_path": backdropPath,
        "name": name,
        "vote_average": voteAverage,
        "overview": overview,
        "poster_path": posterPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };

  TvDetail toEntity() {
    return TvDetail(
      id: id,
      backdropPath: backdropPath,
      name: name,
      voteAverage: voteAverage,
      overview: overview,
      posterPath: posterPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      seasons: seasons.map((season) => season.toEntity()).toList(),
    );
  }

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
