import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';

class TvSeriesTable extends Equatable {
  const TvSeriesTable(
      this.id, this.title, this.posterPath, this.overview, this.mediaType);

  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String mediaType;

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TvSeriesTable(
      tvSeries.id, tvSeries.name, tvSeries.posterPath, tvSeries.overview, "tv");

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
        map['id'],
        map['title'],
        map['posterPath'],
        map['overview'],
        map['mediaType'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'mediaType': mediaType
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview, mediaType];
}
