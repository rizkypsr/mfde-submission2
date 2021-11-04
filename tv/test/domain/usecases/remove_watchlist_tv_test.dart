import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecaseTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseTvSeries = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  group('remove watchlist', () {
    test('should remove watchlist tv series from repository', () async {
      when(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from watchlist'));

      final result = await usecaseTvSeries.execute(testTvSeriesDetail);

      verify(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail));
      expect(result, const Right('Removed from watchlist'));
    });
  });
}
