import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentations/cubit/popular_movies_cubit.dart';

import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesCubit popularMoviesCubit;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesCubit =
        PopularMoviesCubit(getPopularMovies: mockGetPopularMovies);
  });

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

  final tMovieList = <Movie>[tMovie];
  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(popularMoviesCubit.state, PopularMoviesInitial());
    });

    blocTest<PopularMoviesCubit, PopularMoviesState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return popularMoviesCubit;
        },
        act: (cubit) => cubit.fetchPopularMovies(),
        expect: () => [
              PopularMoviesLoading(),
              PopularMoviesHasData(tMovieList),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<PopularMoviesCubit, PopularMoviesState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetPopularMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return popularMoviesCubit;
        },
        act: (cubit) => cubit.fetchPopularMovies(),
        expect: () => [
              PopularMoviesLoading(),
              PopularMoviesError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
