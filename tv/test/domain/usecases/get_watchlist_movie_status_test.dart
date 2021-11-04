import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTvSeriesStatus usecaseTv;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecaseTv = GetWatchListTvSeriesStatus(mockTvSeriesRepository);
  });
  test('should get watchlist status tv from repository', () async {
    when(mockTvSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);

    final result = await usecaseTv.execute(1);

    expect(result, true);
  });
}
