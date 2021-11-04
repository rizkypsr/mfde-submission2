import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentations/cubit/movie_detail_cubit.dart';
import 'package:movie/presentations/cubit/movie_detail_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailCubit = MovieDetailCubit(
        getMovieDetail: mockGetMovieDetail,
        getMovieRecommendations: mockGetMovieRecommendations);
  });

  const tId = 1;

  group('Get Movie Detail', () {
    test('initialState should be Empty', () {
      expect(movieDetailCubit.state, MovieDetailInitial());
    });

    blocTest<MovieDetailCubit, MovieDetailState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));

          return movieDetailCubit;
        },
        act: (cubit) => cubit.fetchMovieDetail(tId),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailHasData(testMovieDetail),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailCubit, MovieDetailState>(
        'should emit MovieDetail [Loading, Error] when request is unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieDetailCubit;
        },
        act: (cubit) => cubit.fetchMovieDetail(tId),
        expect: () =>
            [MovieDetailLoading(), MovieDetailError('Server Failure')],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });
}
