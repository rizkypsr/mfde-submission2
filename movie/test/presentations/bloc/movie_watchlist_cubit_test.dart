import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/presentations/cubit/movie_watchlist_cubit.dart';

import 'movie_watchlist_cubit_test.mocks.dart';

@GenerateMocks(
    [GetWatchListMovieStatus, SaveWatchlistMovie, RemoveWatchlistMovie])
void main() {
  late MovieWatchlistCubit movieWatchlistCubit;
  late MockGetWatchListMovieStatus mockGetWatchListMovieStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchListMovieStatus = MockGetWatchListMovieStatus();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    movieWatchlistCubit = MovieWatchlistCubit(
        getWatchListMovieStatus: mockGetWatchListMovieStatus,
        saveWatchlistMovie: mockSaveWatchlistMovie,
        removeWatchlistMovie: mockRemoveWatchlistMovie);
  });

  const tId = 1;

  group('Watchlist', () {
    test('initialState should be Empty', () {
      expect(movieWatchlistCubit.state, MovieWatchlistInitial());
    });

    blocTest<MovieWatchlistCubit, MovieWatchlistState>(
        'should emit MovieWatchlistStatus when request is success',
        build: () {
          when(mockGetWatchListMovieStatus.execute(tId))
              .thenAnswer((_) async => true);

          return movieWatchlistCubit;
        },
        act: (cubit) => cubit.loadWatchlistStatus(tId),
        expect: () => [const MovieWatchlistStatus(true)],
        verify: (_) {
          verify(mockGetWatchListMovieStatus.execute(tId));
        });
  });
}
