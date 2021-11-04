import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:tv/tv.dart';

import 'search_tv_series_test.mocks.dart';

@GenerateMocks([TvSeriesRepository])
void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];
  const tQuery = 'Doctor';

  test('should get list of tv series from the repository', () async {
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));

    final result = await usecase.execute(tQuery);

    expect(result, Right(tTvSeries));
  });
}
