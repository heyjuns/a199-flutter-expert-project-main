import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_event.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  // var _nowPlayingMovies = <Movie>[];
  // List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  // var _popularMovies = <Movie>[];
  // List<Movie> get popularMovies => _popularMovies;

  // var _topRatedMovies = <Movie>[];
  // List<Movie> get topRatedMovies => _topRatedMovies;

  // String _message = '';
  // String get message => _message;

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListInitialState()) {
    on<FetchNowPlayingMovieListEvent>(
      (event, emit) async {
        emit(NowPlayingMovieListLoadingState());
        final result = await getNowPlayingMovies.execute();
        print('FetchNowPlayingMovieListEvent $result');
        result.fold((error) {
          // _message = error.message;
          emit(NowPlayingMovieListErrorState(error.message));
        }, (result) {
          // _nowPlayingMovies = result;
          emit(NowPlayingMovieListLoadedState(result));
        });
      },
    );

    on<FetchPopularMovieListEvent>(
      (event, emit) async {
        emit(PopularMovieListLoadingState());
        final result = await getNowPlayingMovies.execute();
        print('FetchPopularMovieListEvent $result');
        result.fold((error) {
          // _message = error.message;
          emit(PopularMovieListErrorState(error.message));
        }, (result) {
          // _nowPlayingMovies = result;
          emit(PopularMovieListLoadedState(result));
        });
      },
    );

    on<FetchTopRatedMovieListEvent>(
      (event, emit) async {
        emit(TopRatedMovieListLoadingState());
        final result = await getNowPlayingMovies.execute();
        print('FetchTopRatedMovieListEvent $result');
        result.fold((error) {
          // _message = error.message;
          emit(TopRatedMovieListErrorState(error.message));
        }, (result) {
          // _nowPlayingMovies = result;
          emit(TopRatedMovieListLoadedState(result));
        });
      },
    );
  }
}
