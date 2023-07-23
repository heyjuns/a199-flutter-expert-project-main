import 'package:equatable/equatable.dart';

abstract class PopularTvsEvent extends Equatable {
  const PopularTvsEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularTvsEvent extends PopularTvsEvent {}

abstract class PopularTvsState extends Equatable {
  const PopularTvsState();

  @override
  List<Object> get props => [];
}

class PopularTvsInitialState extends PopularTvsState {}

class PopularTvsLoadingState extends PopularTvsState {}

class PopularTvsLoadedState extends PopularTvsState {}

class PopularTvsErrorState extends PopularTvsState {
  final String message;

  PopularTvsErrorState(this.message);
}
