import 'package:tv/data/models/tv_series_table.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';

const testTvSeriesTable =
    TvSeriesTable(1, 'title', 'posterPath', 'overview', 'tv');

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'mediaType': "tv"
};

final testTvSeries = TvSeries(
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  genreIds: const [18, 9648],
  id: 557,
  originalName: 'Pretty Little Liars',
  overview:
      'A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.',
  popularity: 37.882356,
  posterPath: '/esN3gWb1P091xExLddD2nh4zmi3.jpg',
  firstAirDate: '2015-05-27',
  name: 'Spider-Man',
  voteAverage: 7.5,
  voteCount: 133,
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'releaseDate',
  episodeRunTime: [120],
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  seasons: [
    Season(
        airDate: 'airDate',
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1)
  ],
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvSeriesSeasonDetail = TvSeriesSeasonDetail(
  id: 1,
  name: 'title',
  episodes: [
    Episode(
        airDate: "airDate",
        id: 1,
        name: "name",
        overview: "overview",
        stillPath: "stillPath",
        episodeNumber: 1,
        seasonNumber: 1)
  ],
  airDate: 'airDate',
);
