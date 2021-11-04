import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_season_detail_model.dart';
import 'package:tv/data/models/tv_series_detail_model.dart';
import 'package:tv/data/models/tv_series_model.dart';
import 'package:tv/data/repositories/tv_series_repository_impl.dart';
import 'package:tv/domain/entities/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesLocalDataSource mockLocalDataSource;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource);
  });

  const tTvSeriesModel = TvSeriesModel(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: [18, 9648],
    id: 557,
    originalName: 'Pretty Little Liars',
    overview:
        'A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.',
    popularity: 37.882356,
    posterPath: '/esN3gWb1P091xExLddD2nh4zmi3.jpg',
    firstAirDate: '2015-05-27',
    name: 'Spider-Man',
    voteAverage: 7.5,
    voteCount: 133,
  );

  final tTvSeries = TvSeries(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: const [18, 9648],
    id: 557,
    originalName: 'Pretty Little Liars',
    overview:
        'A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.',
    popularity: 37.882356,
    posterPath: '/esN3gWb1P091xExLddD2nh4zmi3.jpg',
    firstAirDate: '2015-05-27',
    name: 'Spider-Man',
    voteAverage: 7.5,
    voteCount: 133,
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.getNowPlayingTvSeries();

      verify(mockRemoteDataSource.getNowPlayingTvSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());

      final result = await repository.getNowPlayingTvSeries();

      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getNowPlayingTvSeries();

      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.getPopularTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());

      final result = await repository.getPopularTvSeries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTvSeries();

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test('should return movie list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.getTopRatedTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());

      final result = await repository.getTopRatedTvSeries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedTvSeries();

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    const tId = 1;
    const tTvSeriesResponse = TvSeriesDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      popularity: 1,
      id: 1,
      originalName: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      firstAirDate: 'releaseDate',
      episodeRunTime: [120],
      name: 'title',
      voteAverage: 1,
      voteCount: 1,
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      seasons: [
        SeasonModel(
            airDate: "airDate",
            id: 1,
            name: "name",
            overview: "overview",
            posterPath: "posterPath",
            seasonNumber: 1)
      ],
    );

    test(
        'should return Tv Series data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);

      final result = await repository.getTvSeriesDetail(tId);

      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(const Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvSeriesDetail(tId);

      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvSeriesDetail(tId);

      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Season', () {
    const tId = 1;
    const tSeasonNumber = 1;

    const tTvSeriesSeasonResponse = TvSeasonDetailResponse(
      id: 1,
      name: 'title',
      episodes: [
        EpisodeModel(
            airDate: "airDate",
            id: 1,
            name: "name",
            overview: "overview",
            stillPath: "stillPath",
            episodeNumber: 1,
            seasonNumber: 1)
      ],
      airDate: 'airDate',
    );

    test(
        'should return Tv Series Season data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => tTvSeriesSeasonResponse);

      final result =
          await repository.getTvSeriesSeasonDetail(tId, tSeasonNumber);

      verify(mockRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(const Right(testTvSeriesSeasonDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());

      final result =
          await repository.getTvSeriesSeasonDetail(tId, tSeasonNumber);

      verify(mockRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeasonNumber))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result =
          await repository.getTvSeriesSeasonDetail(tId, tSeasonNumber);

      verify(mockRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeasonNumber));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    const tId = 1;

    test('should return data Tv Series list when the call is successful',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);

      final result = await repository.getTvSeriesRecommendations(tId);

      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvSeriesRecommendations(tId);

      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvSeriesRecommendations(tId);

      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Series', () {
    const tQuery = 'withcer';

    test('should return Tv Series list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);

      final result = await repository.searchTvSeries(tQuery);

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());

      final result = await repository.searchTvSeries(tQuery);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchTvSeries(tQuery);

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlist(testTvSeriesDetail);

      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchlist(testTvSeriesDetail);

      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      final result = await repository.removeWatchlist(testTvSeriesDetail);

      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result = await repository.removeWatchlist(testTvSeriesDetail);

      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      const tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(tId);

      expect(result, false);
    });
  });
  group('get watchlist Tv Series', () {
    test('should return list of Tv Series', () async {
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);

      final result = await repository.getWatchlistTvSeries();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
