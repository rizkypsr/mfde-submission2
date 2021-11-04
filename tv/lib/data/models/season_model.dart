import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season.dart';

class SeasonModel extends Equatable {
  const SeasonModel(
      {required this.airDate,
      required this.id,
      required this.name,
      required this.overview,
      required this.posterPath,
      required this.seasonNumber});

  final String? airDate;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        overview: json["name"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Season toEntity() {
    return Season(
        id: id,
        name: name,
        airDate: airDate,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber);
  }

  @override
  List<Object?> get props =>
      [id, name, airDate, overview, posterPath, seasonNumber];
}
