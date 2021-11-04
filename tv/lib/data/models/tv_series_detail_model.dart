import 'package:equatable/equatable.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.episodeRunTime,
    required this.genres,
    required this.seasons,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final List<SeasonModel> seasons;
  final List<int> episodeRunTime;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        id: json["id"],
        episodeRunTime: json['episode_run_time'].cast<int>(),
        originalName: json["original_name"],
        overview: json["overview"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        backdropPath: backdropPath,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        seasons: seasons.map((season) => season.toEntity()).toList(),
        id: id,
        originalName: originalName,
        overview: overview,
        posterPath: posterPath,
        firstAirDate: firstAirDate,
        name: name,
        voteAverage: voteAverage,
        voteCount: voteCount,
        episodeRunTime: episodeRunTime,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        episodeRunTime,
        originalName,
        overview,
        popularity,
        posterPath,
        name,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfSeasons
      ];
}
