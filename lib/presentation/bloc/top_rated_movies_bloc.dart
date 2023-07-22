import 'package:bloc/bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import 'top_rated_movies_event.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  String _message = '';
  get message => _message;

  List<Movie> _topRatedMovies = [];
  get topRatedMovies => _topRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesInitialState()) {
    on<FetchTopRatedMoviesEvent>(_onFetchTopRatedMovies);
  }
  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(TopRatedMoviesLoadingState());
    try {
      final topRatedResult = await getTopRatedMovies.execute();

      topRatedResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (movies) => _topRatedMovies = movies,
      );

      emit(TopRatedMoviesLoadedState());
    } catch (e) {
      emit(TopRatedMoviesErrorState(_message));
    }
  }
}
