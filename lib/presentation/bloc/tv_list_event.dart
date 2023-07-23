import 'package:equatable/equatable.dart';

abstract class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTvListEvent extends TvListEvent {}

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class TvListInitialState extends TvListState {}

class TvListLoadingState extends TvListState {}

class TvListLoadedState extends TvListState {}

class TvListErrorState extends TvListState {
  final String message;

  TvListErrorState(this.message);
}
