import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
