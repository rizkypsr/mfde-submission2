import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_season_detail.dart';
import 'package:tv/presentations/cubit/tv_season_detail_cubit.dart';

import 'tv_season_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesSeasonDetail])
void main() {
  late TvSeasonDetailCubit tvSeasonDetailCubit;
  late MockGetTvSeriesSeasonDetail mockGetTvSeriesSeasonDetail;

  setUp(() {
    mockGetTvSeriesSeasonDetail = MockGetTvSeriesSeasonDetail();
    tvSeasonDetailCubit = TvSeasonDetailCubit(mockGetTvSeriesSeasonDetail);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  const tTvSeriesSeasonDetail = TvSeriesSeasonDetail(
      airDate: 'airDate', episodes: [], id: 1, name: 'name');

  group('Get Tv Series Season', () {
    test('initialState should be Empty', () {
      expect(tvSeasonDetailCubit.state, TvSeasonDetailInitial());
    });

    blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTvSeriesSeasonDetail.execute(tId, tSeasonNumber))
              .thenAnswer((_) async => const Right(tTvSeriesSeasonDetail));

          return tvSeasonDetailCubit;
        },
        act: (cubit) => cubit.fetchTvSeasonDetail(tId, tSeasonNumber),
        expect: () => [
              TvSeasonDetailLoading(),
              const TvSeasonDetailHasData(tTvSeriesSeasonDetail),
            ],
        verify: (_) {
          verify(mockGetTvSeriesSeasonDetail.execute(tId, tSeasonNumber));
        });

    blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
        'should emit MovieDetail [Loading, Error] when request is unsuccessful',
        build: () {
          when(mockGetTvSeriesSeasonDetail.execute(tId, tSeasonNumber))
              .thenAnswer(
                  (_) async => const Left(ServerFailure('Server Failure')));

          return tvSeasonDetailCubit;
        },
        act: (cubit) => cubit.fetchTvSeasonDetail(tId, tSeasonNumber),
        expect: () => [
              TvSeasonDetailLoading(),
              const TvSeasonDetailError('Server Failure')
            ],
        verify: (_) {
          verify(mockGetTvSeriesSeasonDetail.execute(tId, tSeasonNumber));
        });
  });
}
