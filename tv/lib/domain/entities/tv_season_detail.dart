import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/episode.dart';

class TvSeriesSeasonDetail extends Equatable {
  const TvSeriesSeasonDetail({
    required this.episodes,
    required this.id,
    required this.name,
    required this.airDate,
  });

  final String airDate;
  final List<Episode> episodes;
  final String name;
  final int id;

  @override
  List<Object?> get props => [id, name, airDate, episodes];
}
