import 'package:equatable/equatable.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMoviesEvent extends TopRatedMoviesEvent {}

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesInitialState extends TopRatedMoviesState {}

class TopRatedMoviesLoadingState extends TopRatedMoviesState {}

class TopRatedMoviesLoadedState extends TopRatedMoviesState {}

class TopRatedMoviesErrorState extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesErrorState(this.message);
}
