import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.episodeRunTime,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final List<int> episodeRunTime;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        episodeRunTime,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
        voteAverage,
        voteCount,
      ];
}
