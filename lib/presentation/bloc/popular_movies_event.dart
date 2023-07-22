import 'package:equatable/equatable.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMoviesEvent extends PopularMoviesEvent {}

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitialState extends PopularMoviesState {}

class PopularMoviesLoadingState extends PopularMoviesState {}

class PopularMoviesLoadedState extends PopularMoviesState {}

class PopularMoviesErrorState extends PopularMoviesState {
  final String message;

  PopularMoviesErrorState(this.message);
}
