// Mocks generated by Mockito 5.0.16 from annotations
// in search/test/usecases/search_tv_series_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/core.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv_season_detail.dart' as _i8;
import 'package:tv/domain/entities/tv_series.dart' as _i6;
import 'package:tv/domain/entities/tv_series_detail.dart' as _i7;
import 'package:tv/domain/repositories/tv_series_repository.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i3.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getNowPlayingTvSeries() =>
          (super.noSuchMethod(Invocation.method(#getNowPlayingTvSeries, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
                          _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>()))
              as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getPopularTvSeries() =>
          (super.noSuchMethod(Invocation.method(#getPopularTvSeries, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
                          _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>()))
              as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getTopRatedTvSeries() =>
          (super.noSuchMethod(Invocation.method(#getTopRatedTvSeries, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
                          _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>()))
              as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, _i7.TvSeriesDetail>>.value(
                      _FakeEither_0<_i5.Failure, _i7.TvSeriesDetail>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i7.TvSeriesDetail>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvSeriesRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.TvSeriesSeasonDetail>>
      getTvSeriesSeasonDetail(int? tvId, int? seasonNumber) =>
          (super.noSuchMethod(
              Invocation.method(#getTvSeriesSeasonDetail, [tvId, seasonNumber]),
              returnValue: Future<
                      _i2.Either<_i5.Failure, _i8.TvSeriesSeasonDetail>>.value(
                  _FakeEither_0<_i5.Failure, _i8.TvSeriesSeasonDetail>())) as _i4
              .Future<_i2.Either<_i5.Failure, _i8.TvSeriesSeasonDetail>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>
      getWatchlistTvSeries() =>
          (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>.value(
                          _FakeEither_0<_i5.Failure, List<_i6.TvSeries>>()))
              as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvSeries>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(
          _i7.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvSeries]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
          _i7.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}
