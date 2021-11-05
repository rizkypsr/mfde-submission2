import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/movie.dart';

import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsCubit movieRecommendationsCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsCubit =
        MovieRecommendationsCubit(mockGetMovieRecommendations);
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group('Movie Recommendations', () {
    test('initialState should be Empty', () {
      expect(movieRecommendationsCubit.state, MovieRecomendationsInitial());
    });

    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));

          return movieRecommendationsCubit;
        },
        act: (cubit) => cubit.fetchMovieRecommendations(tId),
        expect: () => [
              MovieRecommandationsLoading(),
              MovieRecommandationsHasData(tMovies),
            ],
        verify: (_) {
          verify(mockGetMovieRecommendations.execute(tId));
        });

    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
        'should emit [Loading, Error] when data is gotten successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieRecommendationsCubit;
        },
        act: (cubit) => cubit.fetchMovieRecommendations(tId),
        expect: () => [
              MovieRecommandationsLoading(),
              const MovieRecommandationsError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });
}
