import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

abstract class MovieDetailEvent {}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;

  FetchMovieDetailEvent(this.id);
}

class AddToWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;

  AddToWatchlistEvent(this.movie);
}

class RemoveFromWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveFromWatchlistEvent(this.movie);
}

class CheckWatchlistStatusEvent extends MovieDetailEvent {
  final int id;

  CheckWatchlistStatusEvent(this.id);
}

// States
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {}

class MovieDetailRecommendationState extends MovieDetailState {
  final List<Movie> recommendations;
  MovieDetailRecommendationState({required this.recommendations});

  @override
  List<Object> get props => [recommendations];
}

class MovieDetailErrorState extends MovieDetailState {
  final String message;

  MovieDetailErrorState(this.message);
}
