// Mocks generated by Mockito 5.0.16 from annotations
// in tv/test/presentation/cubit/tv_season_detail_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv_season_detail.dart' as _i7;
import 'package:tv/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:tv/domain/usecases/get_tv_series_season_detail.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvSeriesRepository_0 extends _i1.Fake
    implements _i2.TvSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTvSeriesSeasonDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvSeriesSeasonDetail extends _i1.Mock
    implements _i4.GetTvSeriesSeasonDetail {
  MockGetTvSeriesSeasonDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvSeriesSeasonDetail>> execute(
          int? tvId, int? seasonNumber) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvId, seasonNumber]),
              returnValue: Future<
                      _i3.Either<_i6.Failure, _i7.TvSeriesSeasonDetail>>.value(
                  _FakeEither_1<_i6.Failure, _i7.TvSeriesSeasonDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TvSeriesSeasonDetail>>);
  @override
  String toString() => super.toString();
}