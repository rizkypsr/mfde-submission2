import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

import 'package:tv/tv.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.mediaType}) : super(key: key);

  final String mediaType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (mediaType == 'movie') {
                  context
                      .read<SearchMovieBloc>()
                      .add(OnMovieQueryChanged(query));
                } else {
                  context.read<SearchTvBloc>().add(OnTvQueryChanged(query));
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            SearchResultList(
              mediaType,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultList extends StatelessWidget {
  const SearchResultList(this.mediaType, {Key? key}) : super(key: key);

  final String mediaType;

  @override
  Widget build(BuildContext context) {
    return mediaType == 'movie'
        ? BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              if (state is SearchMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchMovieHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return MovieCard(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              } else if (state is SearchMovieError) {
                return Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          )
        : BlocBuilder<SearchTvBloc, SearchTvState>(
            builder: (context, state) {
              if (state is SearchTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return TvSeriesCard(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              } else if (state is SearchTvError) {
                return Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          );
  }
}
