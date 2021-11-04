import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_season_detail_model.dart';
import 'package:tv/data/models/tv_series_detail_model.dart';
import 'package:tv/data/models/tv_series_response.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air.json')))
        .tvSeriesList;

    test('should return list of Tv Series Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));

      final result = await dataSource.getNowPlayingTvSeries();

      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getNowPlayingTvSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvSeriesList;

    test('should return list of tv series when response is success 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));

      final result = await dataSource.getPopularTvSeries();

      expect(result, tTvSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getPopularTvSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_series.json')))
        .tvSeriesList;

    test('should return list of tv series when response is success 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/top_rated_tv_series.json'), 200));

      final result = await dataSource.getTopRatedTvSeries();

      expect(result, tTvSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedTvSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    const tId = 1;
    final tvTvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));

    test('should return tv series detail when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series_detail.json'), 200));

      final result = await dataSource.getTvSeriesDetail(tId);

      expect(result, equals(tvTvSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTvSeriesDetail(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series recommendations', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .tvSeriesList;
    const tId = 2;

    test('should return list of Tv Series Model when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_recommendations.json'), 200));

      final result = await dataSource.getTvSeriesRecommendations(tId);

      expect(result, equals(tTvSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series seasons', () {
    final tTvSeriesList = TvSeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_seasons.json')));
    const tId = 1399;
    const seasonNumber = 0;
    test(
        'should return list of Tv Series seasons Model when the response code is 200',
        () async {
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_seasons.json'), 200));

      final result =
          await dataSource.getTvSeriesSeasonDetail(tId, seasonNumber);

      expect(result, equals(tTvSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$seasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTvSeriesSeasonDetail(tId, seasonNumber);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series', () {
    final tSearchResult = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_witcher_movie.json')))
        .tvSeriesList;
    const tQuery = 'Witcher';

    test('should return list of tv series when response code is 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_witcher_movie.json'), 200));

      final result = await dataSource.searchTvSeries(tQuery);

      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.searchTvSeries(tQuery);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
