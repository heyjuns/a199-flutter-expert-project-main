import 'package:equatable/equatable.dart';

abstract class WatchlistTvsEvent extends Equatable {
  const WatchlistTvsEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTvsEvent extends WatchlistTvsEvent {}

abstract class WatchlistTvsState extends Equatable {
  const WatchlistTvsState();

  @override
  List<Object> get props => [];
}

class WatchlistTvsInitialState extends WatchlistTvsState {}

class WatchlistTvsLoadingState extends WatchlistTvsState {}

class WatchlistTvsLoadedState extends WatchlistTvsState {}

class WatchlistTvsErrorState extends WatchlistTvsState {
  final String message;

  WatchlistTvsErrorState(this.message);
}
