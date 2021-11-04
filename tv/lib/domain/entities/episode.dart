import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  const Episode(
      {required this.id,
      required this.name,
      required this.airDate,
      required this.overview,
      required this.stillPath,
      required this.episodeNumber,
      required this.seasonNumber});

  final String airDate;
  final int episodeNumber;
  final int seasonNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;

  @override
  List<Object?> get props =>
      [airDate, id, name, overview, stillPath, episodeNumber, seasonNumber];
}
