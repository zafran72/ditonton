import 'package:tv/data/datasources/db/tv_database_helper.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:core/utils/exception.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchList(TvTable tv);
  Future<String> removeWatchList(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper tvDatabaseHelper;

  TvLocalDataSourceImpl({required this.tvDatabaseHelper});

  @override
  Future<String> insertWatchList(TvTable tv) async {
    try {
      await tvDatabaseHelper.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchList(TvTable tv) async {
    try {
      await tvDatabaseHelper.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await tvDatabaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await tvDatabaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
