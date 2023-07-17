import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailErrorState extends MovieDetailState {
  final String message;

  MovieDetailErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailLoadedState extends MovieDetailState {
  final List<Tv> result;

  MovieDetailLoadedState(this.result);

  @override
  List<Object> get props => [result];
}
