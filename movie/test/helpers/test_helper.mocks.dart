// Mocks generated by Mockito 5.0.16 from annotations
// in movie/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i15;
import 'dart:typed_data' as _i16;

import 'package:core/core.dart' as _i5;
import 'package:dartz/dartz.dart' as _i3;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/datasources/movie_local_data_source.dart' as _i8;
import 'package:movie/data/datasources/movie_remote_data_source.dart' as _i10;
import 'package:movie/data/models/movie_detail_model.dart' as _i2;
import 'package:movie/data/models/movie_model.dart' as _i11;
import 'package:movie/data/models/movie_table.dart' as _i9;
import 'package:movie/domain/entities/movie.dart' as _i13;
import 'package:movie/domain/entities/movie_detail.dart' as _i14;
import 'package:movie/domain/repositories/movie_repository.dart' as _i12;
import 'package:sqflite/sqflite.dart' as _i7;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieDetailResponse_0 extends _i1.Fake
    implements _i2.MovieDetailResponse {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeResponse_2 extends _i1.Fake implements _i4.Response {}

class _FakeStreamedResponse_3 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i5.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i7.Database?> get database => (super.noSuchMethod(
      Invocation.getter(#database),
      returnValue: Future<_i7.Database?>.value()) as _i6.Future<_i7.Database?>);
  @override
  _i6.Future<int> insertWatchlist(dynamic item) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [item]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlist(dynamic item) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [item]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getItemById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getItemById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistItem() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistItem, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i8.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i9.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i9.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i9.MovieTable?>.value())
          as _i6.Future<_i9.MovieTable?>);
  @override
  _i6.Future<List<_i9.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]))
      as _i6.Future<List<_i9.MovieTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i10.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
          as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<List<_i11.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
      as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<List<_i11.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
      as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<_i2.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i2.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_0()))
          as _i6.Future<_i2.MovieDetailResponse>);
  @override
  _i6.Future<List<_i11.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
          as _i6.Future<List<_i11.MovieModel>>);
  @override
  _i6.Future<List<_i11.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i11.MovieModel>>.value(<_i11.MovieModel>[]))
          as _i6.Future<List<_i11.MovieModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i12.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Either<_i5.Failure, List<_i13.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>.value(
              _FakeEither_1<_i5.Failure, List<_i13.Movie>>())) as _i6
          .Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, List<_i13.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>.value(
              _FakeEither_1<_i5.Failure, List<_i13.Movie>>())) as _i6
          .Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, List<_i13.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>.value(
              _FakeEither_1<_i5.Failure, List<_i13.Movie>>())) as _i6
          .Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, _i14.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i3.Either<_i5.Failure, _i14.MovieDetail>>.value(
              _FakeEither_1<_i5.Failure, _i14.MovieDetail>())) as _i6
          .Future<_i3.Either<_i5.Failure, _i14.MovieDetail>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, List<_i13.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>.value(
              _FakeEither_1<_i5.Failure, List<_i13.Movie>>())) as _i6
          .Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, List<_i13.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>.value(
              _FakeEither_1<_i5.Failure, List<_i13.Movie>>())) as _i6
          .Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, String>> saveWatchlist(
          _i14.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i3.Either<_i5.Failure, String>>.value(
                  _FakeEither_1<_i5.Failure, String>()))
          as _i6.Future<_i3.Either<_i5.Failure, String>>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, String>> removeWatchlist(
          _i14.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i3.Either<_i5.Failure, String>>.value(
                  _FakeEither_1<_i5.Failure, String>()))
          as _i6.Future<_i3.Either<_i5.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i3.Either<_i5.Failure, List<_i13.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>.value(
              _FakeEither_1<_i5.Failure, List<_i13.Movie>>())) as _i6
          .Future<_i3.Either<_i5.Failure, List<_i13.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i15.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i15.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i15.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i15.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i16.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i16.Uint8List>.value(_i16.Uint8List(0)))
          as _i6.Future<_i16.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3()))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
