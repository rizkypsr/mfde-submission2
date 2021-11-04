import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.insertWatchlist(testTvSeriesTable);

      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlist(testTvSeriesTable))
          .thenThrow(Exception());

      final call = dataSource.insertWatchlist(testTvSeriesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.removeWatchlist(testTvSeriesTable);

      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelper.removeWatchlist(testTvSeriesTable))
          .thenThrow(Exception());

      final call = dataSource.removeWatchlist(testTvSeriesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail By Id', () {
    const tId = 1;

    test('should return Tv Series Detail Table when data is found', () async {
      when(mockDatabaseHelper.getItemById(tId))
          .thenAnswer((_) async => testTvSeriesMap);

      final result = await dataSource.getTvSeriesById(tId);

      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getItemById(tId)).thenAnswer((_) async => null);

      final result = await dataSource.getTvSeriesById(tId);

      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      when(mockDatabaseHelper.getWatchlistItem())
          .thenAnswer((_) async => [testTvSeriesMap]);

      final result = await dataSource.getWatchlistTvSeries();

      expect(result, [testTvSeriesTable]);
    });
  });
}
