import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season(
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

  @override
  List<Object?> get props =>
      [airDate, id, name, overview, posterPath, seasonNumber];
}
