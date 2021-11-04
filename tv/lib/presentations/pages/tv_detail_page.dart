import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/presentations/cubit/tv_season_detail_cubit.dart';
import 'package:tv/tv.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;

  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvDetailCubit>(context).fetchTvDetail(widget.id);
    BlocProvider.of<TvRecommendationsCubit>(context)
        .fetchTvRecommendations(widget.id);
    BlocProvider.of<TvWatchlistCubit>(context).loadWatchlistStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tvSeries = state.tvSeries;
            return SafeArea(
              child: TvDetailContent(
                tvSeries: tvSeries,
              ),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          }

          return const Text('Tv Series not found');
        },
      ),
    );
  }
}

class TvDetailContent extends StatefulWidget {
  final TvSeriesDetail tvSeries;

  const TvDetailContent({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  @override
  _TvDetailContentState createState() => _TvDetailContentState();
}

class _TvDetailContentState extends State<TvDetailContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: widget.tvSeries.seasons.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            BlocListener<TvWatchlistCubit, TvWatchlistState>(
                              listener: (context, state) {
                                if (state is TvWatchlistMessage) {
                                  final message = state.message;

                                  if (message ==
                                          TvWatchlistCubit
                                              .watchlistAddSuccessMessage ||
                                      message ==
                                          TvWatchlistCubit
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                }
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  final watchlistStatus = context
                                      .read<TvWatchlistCubit>()
                                      .state as TvWatchlistStatus;
                                  if (!watchlistStatus.isAddedToWatchlist) {
                                    context
                                        .read<TvWatchlistCubit>()
                                        .addToWatchlist(widget.tvSeries);
                                  } else {
                                    context
                                        .read<TvWatchlistCubit>()
                                        .removeFromWathlist(widget.tvSeries);
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BlocBuilder<TvWatchlistCubit,
                                        TvWatchlistState>(
                                      builder: (context, state) {
                                        if (state is TvWatchlistStatus) {
                                          return state.isAddedToWatchlist
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add);
                                        } else {
                                          return const Icon(Icons.add);
                                        }
                                      },
                                    ),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Wrap(
                              spacing: 8,
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  _showDuration(
                                      widget.tvSeries.episodeRunTime[0]),
                                ),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                Text(
                                    "${widget.tvSeries.numberOfSeasons.toString()} Seasons"),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                Text(
                                    "${widget.tvSeries.numberOfEpisodes.toString()} Episodes")
                              ],
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            const SizedBox(height: 16),
                            TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                tabs: List<Widget>.generate(
                                    widget.tvSeries.seasons.length,
                                    (index) => Tab(
                                          text: widget
                                              .tvSeries.seasons[index].name,
                                        ))),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 150,
                              child: TabBarView(
                                  controller: _tabController,
                                  children: List<Widget>.generate(
                                      widget.tvSeries.seasons.length,
                                      (index) => EpisodeList(
                                          tvId: widget.tvSeries.id,
                                          seasonNumber: widget.tvSeries
                                              .seasons[index].seasonNumber))),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationsCubit,
                                TvRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvRecommendationsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecommendationsError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else if (state is TvRecommendationsHasData) {
                                  final recommendations = state.result;

                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TV_DETAIL_ROUTE,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class EpisodeList extends StatefulWidget {
  const EpisodeList({Key? key, required this.tvId, required this.seasonNumber})
      : super(key: key);

  final int tvId;
  final int seasonNumber;

  @override
  _EpisodeListState createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvSeasonDetailCubit>(context)
        .fetchTvSeasonDetail(widget.tvId, widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeasonDetailCubit, TvSeasonDetailState>(
      builder: (context, state) {
        if (state is TvSeasonDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeasonDetailError) {
          return Center(child: Text(state.message));
        } else if (state is TvSeasonDetailHasData) {
          final episodes = state.result.episodes;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final episode = episodes[index];
                return Container(
                  width: 250,
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(fit: StackFit.expand, children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Opacity(
                      opacity: 0.25,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        "S${episode.seasonNumber} E${episode.episodeNumber} - ${episode.airDate}",
                        style: kHeading6,
                      ),
                    )
                  ]),
                );
              },
              itemCount: episodes.length);
        } else {
          return Container();
        }
      },
    );
  }
}
