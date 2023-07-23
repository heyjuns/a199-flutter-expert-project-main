import 'package:equatable/equatable.dart';

abstract class TopRatedTvsEvent extends Equatable {
  const TopRatedTvsEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedTvsEvent extends TopRatedTvsEvent {}

abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class TopRatedTvsInitialState extends TopRatedTvsState {}

class TopRatedTvsLoadingState extends TopRatedTvsState {}

class TopRatedTvsLoadedState extends TopRatedTvsState {}

class TopRatedTvsErrorState extends TopRatedTvsState {
  final String message;

  TopRatedTvsErrorState(this.message);
}
