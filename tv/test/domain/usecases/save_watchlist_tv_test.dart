import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecaseTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseTvSeries = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  group('save watchlist', () {
    test('should save tv series to the repository', () async {
      when(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));

      final result = await usecaseTvSeries.execute(testTvSeriesDetail);

      verify(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail));
      expect(result, const Right('Added to Watchlist'));
    });
  });
}
