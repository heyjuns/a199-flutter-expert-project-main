import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;
  const FetchMovieDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class FetchMovieRecommendationEvent extends MovieDetailEvent {
  final int id;
  const FetchMovieRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveWatchlistMovieEvent extends MovieDetailEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovieEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class SaveWatchlistMovieEvent extends MovieDetailEvent {
  final MovieDetail movie;

  const SaveWatchlistMovieEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class FetchMovieStatusEvent extends MovieDetailEvent {
  final int id;
  const FetchMovieStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final bool isWatchlist;

  const MovieDetailLoadedState(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}

class MovieDetailErrorState extends MovieDetailState {
  final String message;

  MovieDetailErrorState(this.message);
}
