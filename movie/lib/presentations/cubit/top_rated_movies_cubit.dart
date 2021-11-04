import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit({required this.getTopRatedMovies})
      : super(TopRatedMoviesInitial());

  final GetTopRatedMovies getTopRatedMovies;

  void fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();

    result.fold((failure) async {
      emit(TopRatedMoviesError(failure.message));
    }, (data) async {
      emit(TopRatedMoviesHasData(data));
    });
  }
}
