import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/episode.dart';

class EpisodeModel extends Equatable {
  const EpisodeModel(
      {required this.airDate,
      required this.episodeNumber,
      required this.id,
      required this.name,
      required this.overview,
      required this.stillPath,
      required this.seasonNumber});

  final String airDate;
  final int episodeNumber;
  final int seasonNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        seasonNumber: json["season_number"],
        overview: json["overview"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "airDate": airDate,
        "episodeNumber": episodeNumber,
        "seasonNumber": seasonNumber,
        "overview": overview,
        "stillPath": stillPath
      };

  Episode toEntity() {
    return Episode(
        id: id,
        name: name,
        airDate: airDate,
        episodeNumber: episodeNumber,
        seasonNumber: seasonNumber,
        overview: overview,
        stillPath: stillPath);
  }

  @override
  List<Object?> get props =>
      [id, name, airDate, episodeNumber, overview, stillPath, seasonNumber];
}
