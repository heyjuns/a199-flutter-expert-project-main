import 'package:bloc/bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies.dart';
import 'watchlist_movies_event.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  String _message = '';
  get message => _message;

  List<Movie> _watchlistMovies = [];
  get watchlistMovies => _watchlistMovies;

  WatchlistMoviesBloc({required this.getWatchlistMovies})
      : super(WatchlistMoviesInitialState()) {
    on<FetchWatchlistMoviesEvent>(_onFetchWatchlistMovies);
  }
  Future<void> _onFetchWatchlistMovies(
    FetchWatchlistMoviesEvent event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(WatchlistMoviesLoadingState());
    final watchlistResult = await getWatchlistMovies.execute();

    watchlistResult.fold(
      (error) {
        _message = error.message;
        emit(WatchlistMoviesErrorState(_message));
      },
      (movies) {
        _watchlistMovies = movies;
        emit(WatchlistMoviesLoadedState());
      },
    );
  }
}
