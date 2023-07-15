import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class SearchTvsEvent extends Equatable {
  const SearchTvsEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTvsChanged extends SearchTvsEvent {
  final String query;

  OnQueryTvsChanged(this.query);

  @override
  List<Object> get props => [query];
}

abstract class SearchTvsState extends Equatable {
  const SearchTvsState();

  @override
  List<Object> get props => [];
}

class SearchTvsEmpty extends SearchTvsState {}

class SearchTvsLoading extends SearchTvsState {}

class SearchTvsError extends SearchTvsState {
  final String message;

  SearchTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvsHasData extends SearchTvsState {
  final List<Tv> result;

  SearchTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}
