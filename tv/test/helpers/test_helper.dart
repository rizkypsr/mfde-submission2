import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  DatabaseHelper,
  TvSeriesLocalDataSource,
  TvSeriesRemoteDataSource,
  TvSeriesRepository
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
