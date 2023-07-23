import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetailEvent extends TvDetailEvent {}

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitialState extends TvDetailState {}

class TvDetailLoadingState extends TvDetailState {}

class TvDetailLoadedState extends TvDetailState {}

class TvDetailErrorState extends TvDetailState {
  final String message;

  TvDetailErrorState(this.message);
}
