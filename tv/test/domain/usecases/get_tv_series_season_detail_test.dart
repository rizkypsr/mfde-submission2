import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_series_season_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeasonDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesSeasonDetail(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('should get tv series season detail from the repository', () async {
    when(mockTvSeriesRepository.getTvSeriesSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testTvSeriesSeasonDetail));

    final result = await usecase.execute(tId, tSeasonNumber);

    expect(result, const Right(testTvSeriesSeasonDetail));
  });
}
