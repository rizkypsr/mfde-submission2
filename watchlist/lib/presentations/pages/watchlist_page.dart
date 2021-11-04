import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import 'package:watchlist/presentations/cubit/watchlist_cubit.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WatchlistCubit>(context).fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is WatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return movie.mediaType == "movie"
                      ? MovieCard(movie)
                      : TvSeriesCard(TvSeries(
                          backdropPath: movie.backdropPath,
                          genreIds: movie.genreIds,
                          id: movie.id,
                          originalName: movie.originalTitle,
                          overview: movie.overview,
                          popularity: movie.popularity,
                          posterPath: movie.posterPath,
                          firstAirDate: movie.releaseDate,
                          name: movie.title,
                          voteAverage: movie.voteAverage,
                          voteCount: movie.voteCount));
                },
                itemCount: state.movies.length,
              );
            } else {
              return const Center(
                child: Text('Watchlist is Empty'),
              );
            }
          },
        ),
      ),
    );
  }
}
