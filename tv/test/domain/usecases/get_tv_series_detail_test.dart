import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_series_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  const tId = 1;

  test('should get tv series detail from the repository', () async {
    when(mockTvSeriesRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));

    final result = await usecase.execute(tId);

    expect(result, const Right(testTvSeriesDetail));
  });
}
