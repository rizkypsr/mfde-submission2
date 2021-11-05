import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentations/cubit/now_playing_movies_cubit.dart';

import 'now_playing_movies_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesCubit movieListCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieListCubit = NowPlayingMoviesCubit(
      getNowPlayingMovies: mockGetNowPlayingMovies,
    );
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

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieListCubit.state, MovieListInitial());
    });

    blocTest<NowPlayingMoviesCubit, MovieListState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return movieListCubit;
        },
        act: (cubit) => cubit.fetchNowPlayingMovies(),
        expect: () => [
              MovieListLoading(),
              MovieListHasData(tMovieList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });

    blocTest<NowPlayingMoviesCubit, MovieListState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieListCubit;
        },
        act: (cubit) => cubit.fetchNowPlayingMovies(),
        expect: () => [
              MovieListLoading(),
              MovieListError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });
}
