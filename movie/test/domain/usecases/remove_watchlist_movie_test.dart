import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlistMovie(mockMovieRepository);
  });

  group('remove watchlist', () {
    test('should remove watchlist tv series from repository', () async {
      when(mockMovieRepository.removeWatchlist(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from watchlist'));

      final result = await usecase.execute(testMovieDetail);

      verify(mockMovieRepository.removeWatchlist(testMovieDetail));
      expect(result, const Right('Removed from watchlist'));
    });
  });
}
