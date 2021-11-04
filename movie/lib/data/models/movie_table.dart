import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

class MovieTable extends Equatable {
  const MovieTable(
      this.id, this.title, this.posterPath, this.overview, this.mediaType);

  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String mediaType;

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      movie.id, movie.title, movie.posterPath, movie.overview, "movie");

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
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

  Movie toEntity() => Movie.watchlist(
      id: id,
      overview: overview,
      posterPath: posterPath,
      title: title,
      mediaType: mediaType);

  @override
  List<Object?> get props => [id, title, posterPath, overview, mediaType];
}
