import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

abstract class MovieListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovieListEvent extends MovieListEvent {}

class FetchPopularMovieListEvent extends MovieListEvent {}

class FetchTopRatedMovieListEvent extends MovieListEvent {}

abstract class MovieListState extends Equatable {
  final int time = DateTime.now().millisecondsSinceEpoch;
  @override
  List<Object?> get props => [time];
}

class MovieListInitialState extends MovieListState {}

class NowPlayingMovieListInitialState extends MovieListState {}

class NowPlayingMovieListLoadingState extends MovieListState {}

class NowPlayingMovieListLoadedState extends MovieListState {
  final List<Movie> movies;
  NowPlayingMovieListLoadedState(this.movies);

  @override
  List<Object?> get props => super.props..add(movies);
}

class NowPlayingMovieListErrorState extends MovieListState {
  final String message;

  NowPlayingMovieListErrorState(this.message);
}

class PopularMovieListInitialState extends MovieListState {}

class PopularMovieListLoadingState extends MovieListState {}

class PopularMovieListLoadedState extends MovieListState {
  final List<Movie> movies;
  PopularMovieListLoadedState(this.movies);

  @override
  List<Object?> get props => super.props..add(movies);
}

class PopularMovieListErrorState extends MovieListState {
  final String message;

  PopularMovieListErrorState(this.message);
}

class TopRatedMovieListInitialState extends MovieListState {}

class TopRatedMovieListLoadingState extends MovieListState {}

class TopRatedMovieListLoadedState extends MovieListState {
  final List<Movie> movies;
  TopRatedMovieListLoadedState(this.movies);

  @override
  List<Object?> get props => super.props..add(movies);
}

class TopRatedMovieListErrorState extends MovieListState {
  final String message;

  TopRatedMovieListErrorState(this.message);
}
