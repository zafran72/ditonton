import 'package:core/domain/entities/genre.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
  firstAirDate: '2022-08-21',
  genreIds: [10765, 18, 10759],
  id: 94997,
  name: 'House of the Dragon',
  originCountry: ["US"],
  originalLanguage: 'en',
  originalName: 'House of the Dragon',
  overview:
      'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
  popularity: 7222.052,
  posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
  voteAverage: 8.6,
  voteCount: 1564,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  id: 1,
  backdropPath: 'backdropPath',
  name: 'name',
  voteAverage: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  genres: [Genre(id: 1, name: 'Action')],
  seasons: [
    Season(id: 1, name: 'Season 1', episodeCount: 1, posterPath: 'posterPath'),
  ],
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
