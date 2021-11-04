import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test(
      'should get list of popular tv series from the repository when execute function is called',
      () async {
    when(mockTvSeriesRepository.getPopularTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));

    final result = await usecase.execute();

    expect(result, Right(tTvSeries));
  });
}
