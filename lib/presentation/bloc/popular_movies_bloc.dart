import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';

import '../../domain/entities/movie.dart';
import 'popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  String _message = '';
  get message => _message;

  List<Movie> _popularMovies = [];
  get popularMovies => _popularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesInitialState()) {
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
  }
  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoadingState());
    try {
      final popularResult = await getPopularMovies.execute();

      popularResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (movies) => _popularMovies = movies,
      );

      emit(PopularMoviesLoadedState());
    } catch (e) {
      emit(PopularMoviesErrorState(_message));
    }
  }
}
