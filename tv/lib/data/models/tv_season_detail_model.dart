import 'package:equatable/equatable.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';

class TvSeasonDetailResponse extends Equatable {
  const TvSeasonDetailResponse({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodes,
  });

  final String airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final int id;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailResponse(
          name: json["name"],
          episodes: List<EpisodeModel>.from(
              json["episodes"].map((x) => EpisodeModel.fromJson(x))),
          id: json["id"],
          airDate: json["air_date"]);

  Map<String, dynamic> toJson() => {
        "airDate": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "id": id,
      };

  TvSeriesSeasonDetail toEntity() {
    return TvSeriesSeasonDetail(
      airDate: airDate,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name, airDate, episodes];
}
