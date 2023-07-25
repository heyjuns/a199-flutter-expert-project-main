import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetailEvent extends TvDetailEvent {
  final int id;
  const FetchTvDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveWatchlistTvEvent extends TvDetailEvent {
  final TvDetail tv;

  const RemoveWatchlistTvEvent(this.tv);

  @override
  List<Object> get props => [tv];
}

class SaveWatchlistTvEvent extends TvDetailEvent {
  final TvDetail tv;

  const SaveWatchlistTvEvent(this.tv);

  @override
  List<Object> get props => [tv];
}

class FetchTvStatusEvent extends TvDetailEvent {
  final int id;
  const FetchTvStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitialState extends TvDetailState {}

class TvDetailLoadingState extends TvDetailState {}

class TvDetailLoadedState extends TvDetailState {
  final bool isWatchlist;

  const TvDetailLoadedState(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}

class TvDetailErrorState extends TvDetailState {
  final String message;

  TvDetailErrorState(this.message);
}
