import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/presentations/cubit/now_playing_tv_cubit.dart';
import 'package:tv/presentations/cubit/popular_tv_cubit.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/presentations/cubit/watchlist_cubit.dart';
import 'package:watchlist/watchlist.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>(
            create: (_) => di.locator<NowPlayingMoviesCubit>()),
        BlocProvider<PopularMoviesCubit>(
            create: (_) => di.locator<PopularMoviesCubit>()),
        BlocProvider<TopRatedMoviesCubit>(
            create: (_) => di.locator<TopRatedMoviesCubit>()),
        BlocProvider<MovieDetailCubit>(
            create: (_) => di.locator<MovieDetailCubit>()),
        BlocProvider<MovieRecommendationsCubit>(
            create: (_) => di.locator<MovieRecommendationsCubit>()),
        BlocProvider<MovieWatchlistCubit>(
            create: (_) => di.locator<MovieWatchlistCubit>()),
        BlocProvider<WatchlistCubit>(
            create: (_) => di.locator<WatchlistCubit>()),
        BlocProvider<NowPlayingTvCubit>(
            create: (_) => di.locator<NowPlayingTvCubit>()),
        BlocProvider<PopularTvCubit>(
            create: (_) => di.locator<PopularTvCubit>()),
        BlocProvider<TopRatedTvCubit>(
            create: (_) => di.locator<TopRatedTvCubit>()),
        BlocProvider<TvDetailCubit>(create: (_) => di.locator<TvDetailCubit>()),
        BlocProvider<TvRecommendationsCubit>(
            create: (_) => di.locator<TvRecommendationsCubit>()),
        BlocProvider<TvSeasonDetailCubit>(
            create: (_) => di.locator<TvSeasonDetailCubit>()),
        BlocProvider<SearchMovieCubit>(
            create: (_) => di.locator<SearchMovieCubit>()),
        BlocProvider<SearchTvCubit>(create: (_) => di.locator<SearchTvCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviesPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MOVIE_PAGE_ROUTE:
              return MaterialPageRoute(builder: (_) => const HomeMoviesPage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => const PopularTvPage());
            case TV_PAGE_ROUTE:
              return CupertinoPageRoute(builder: (_) => const HomeTvPage());
            case TOP_RATED_MOVIE_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case TOP_RATED_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              final mediaType = settings.arguments as String;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        mediaType: mediaType,
                      ),
                  settings: settings);
            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
