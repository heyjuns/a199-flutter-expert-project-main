import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMovieListEvent extends MovieListEvent {}

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitialState extends MovieListState {}

class MovieListLoadingState extends MovieListState {}

class MovieListLoadedState extends MovieListState {}

class MovieListErrorState extends MovieListState {
  final String message;

  MovieListErrorState(this.message);
}
