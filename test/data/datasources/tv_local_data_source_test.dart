import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(tvDatabaseHelper: mockDatabaseHelper);
  });

  group('save tv watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.insertWatchList(testTvTable);
      //assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.insertWatchlist(testTvTable))
          .thenThrow(Exception());
      //act
      final call = dataSource.insertWatchList(testTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove tv watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.removeWatchList(testTvTable);
      //assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlist(testTvTable))
          .thenThrow(Exception());
      //act
      final call = dataSource.removeWatchList(testTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail by Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      //arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      //act
      final result = await dataSource.getTvById(tId);
      //assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      //arrange
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      //act
      final result = await dataSource.getTvById(tId);
      //assert
      expect(result, null);
    });
  });

  group("Get Watchlist Tv", () {
    test('should return list of TvTable from database', () async {
      //arrange
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      //act
      final result = await dataSource.getWatchlistTv();
      //assert
      expect(result, [testTvTable]);
    });
  });
}
