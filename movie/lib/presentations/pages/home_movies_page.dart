import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentations/cubit/now_playing_movies_cubit.dart';
import 'package:movie/presentations/cubit/popular_movies_cubit.dart';

class HomeMoviesPage extends StatefulWidget {
  const HomeMoviesPage({Key? key}) : super(key: key);

  @override
  State<HomeMoviesPage> createState() => _HomeMoviesPageState();
}

class _HomeMoviesPageState extends State<HomeMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NowPlayingMoviesCubit>(context).fetchNowPlayingMovies();
    BlocProvider.of<PopularMoviesCubit>(context).fetchPopularMovies();
    BlocProvider.of<TopRatedMoviesCubit>(context).fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SEARCH_ROUTE,
                arguments: "movie",
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesCubit, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListHasData) {
                    return MovieList(state.result);
                  } else if (state is MovieListError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('No Movies Found'),
                    );
                  }
                },
              ),
              BuildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
              ),
              BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularMoviesError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text('No Movies Found'),
                      ),
                    );
                  }
                },
              ),
              BuildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE),
              ),
              BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('No Movies Found'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
