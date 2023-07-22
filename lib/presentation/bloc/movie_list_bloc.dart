import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_event.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  String _message = '';
  String get message => _message;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListInitialState()) {
    on<FetchAllMovieListEvent>(_onFetchAllMovieList);
  }
  Future<void> _onFetchAllMovieList(
    FetchAllMovieListEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoadingState());
    try {
      final nowPlayingResult = await getNowPlayingMovies.execute();
      final popularResult = await getPopularMovies.execute();
      final topRatedResult = await getTopRatedMovies.execute();

      nowPlayingResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (movies) => _nowPlayingMovies = movies,
      );
      popularResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (movies) => _popularMovies = movies,
      );
      topRatedResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (movies) => _topRatedMovies = movies,
      );

      emit(MovieListLoadedState());
    } catch (e) {
      emit(MovieListErrorState(_message));
    }
  }
}
