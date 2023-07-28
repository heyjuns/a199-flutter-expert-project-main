import 'package:equatable/equatable.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMoviesEvent extends WatchlistMoviesEvent {}

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesInitialState extends WatchlistMoviesState {}

class WatchlistMoviesLoadingState extends WatchlistMoviesState {}

class WatchlistMoviesLoadedState extends WatchlistMoviesState {}

class WatchlistMoviesErrorState extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesErrorState(this.message);
}
