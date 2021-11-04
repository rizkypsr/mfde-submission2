import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListMovieStatus usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchListMovieStatus(mockMovieRepository);
  });

  test('should get watchlist status tv from repository', () async {
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);

    final result = await usecase.execute(1);

    expect(result, true);
  });
}
