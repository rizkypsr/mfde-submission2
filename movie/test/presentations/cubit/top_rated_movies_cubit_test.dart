import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentations/cubit/top_rated_movies_cubit.dart';

import 'top_rated_movies_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesCubit topRatedMoviesCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesCubit =
        TopRatedMoviesCubit(getTopRatedMovies: mockGetTopRatedMovies);
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
  group('top rated movies', () {
    test('initialState should be Empty', () {
      expect(topRatedMoviesCubit.state, TopRatedMoviesInitial());
    });

    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return topRatedMoviesCubit;
        },
        act: (cubit) => cubit.fetchTopRatedMovies(),
        expect: () => [
              TopRatedMoviesLoading(),
              TopRatedMoviesHasData(tMovieList),
            ],
        verify: (_) {
          verify(mockGetTopRatedMovies.execute());
        });

    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return topRatedMoviesCubit;
        },
        act: (cubit) => cubit.fetchTopRatedMovies(),
        expect: () => [
              TopRatedMoviesLoading(),
              TopRatedMoviesError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetTopRatedMovies.execute());
        });
  });
}
