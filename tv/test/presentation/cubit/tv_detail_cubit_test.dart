import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv/presentations/cubit/tv_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail, GetTvSeriesRecommendations])
void main() {
  late TvDetailCubit tvDetailCubit;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvDetailCubit = TvDetailCubit(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations);
  });

  const tId = 1;

  group('Get Movie Detail', () {
    test('initialState should be Empty', () {
      expect(tvDetailCubit.state, TvDetailInitial());
    });

    blocTest<TvDetailCubit, TvDetailState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTvSeriesDetail.execute(tId))
              .thenAnswer((_) async => const Right(testTvSeriesDetail));

          return tvDetailCubit;
        },
        act: (cubit) => cubit.fetchTvDetail(tId),
        expect: () => [
              TvDetailLoading(),
              const TvDetailHasData(testTvSeriesDetail),
            ],
        verify: (_) {
          verify(mockGetTvSeriesDetail.execute(tId));
        });

    blocTest<TvDetailCubit, TvDetailState>(
        'should emit MovieDetail [Loading, Error] when request is unsuccessful',
        build: () {
          when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvDetailCubit;
        },
        act: (cubit) => cubit.fetchTvDetail(tId),
        expect: () =>
            [TvDetailLoading(), const TvDetailError('Server Failure')],
        verify: (_) {
          verify(mockGetTvSeriesDetail.execute(tId));
        });
  });
}
