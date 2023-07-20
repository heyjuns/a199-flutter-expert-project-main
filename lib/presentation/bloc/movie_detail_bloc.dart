import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movies => _movieRecommendations;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  String _message = '';
  String get message => _message;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitialState()) {
    on<FetchMovieDetailEvent>(
      (event, emit) async {
        int id = event.id;
        emit(MovieDetailLoadingState());
        final detailResult = await getMovieDetail.execute(id);
        final recommendationResult = await getMovieRecommendations.execute(id);
        detailResult.fold(
          (failure) {
            _message = failure.message;
            emit(MovieDetailErrorState(failure.message));
          },
          (movie) {
            emit(MovieDetailLoadingState());
            _movie = movie;

            emit(MovieDetailLoadedState(movie: movie));
            recommendationResult.fold(
              (failure) {
                emit(MovieDetailErrorState(failure.message));
              },
              (movies) {
                _movieRecommendations = movies;
                MovieDetailRecommendationState(recommendations: movies);
              },
            );
          },
        );
      },
    );

    on<CheckWatchlistStatusEvent>(
      (event, emit) async {
        int id = event.id;
        final result = await getWatchListStatus.execute(id);
        _isAddedtoWatchlist = result;
        print(_isAddedtoWatchlist);
      },
    );

    on<AddToWatchlistEvent>(
      (event, emit) async {
        MovieDetail movie = event.movie;
        final result = await saveWatchlist.execute(movie);
        result.fold(
          (failure) async {
            _watchlistMessage = failure.message;
          },
          (successMessage) async {
            _watchlistMessage = successMessage;
          },
        );
        add(CheckWatchlistStatusEvent(movie.id));
      },
    );

    on<RemoveFromWatchlistEvent>(
      (event, emit) async {
        MovieDetail movie = event.movie;
        final result = await removeWatchlist.execute(movie);
        result.fold(
          (failure) async {
            _watchlistMessage = failure.message;
          },
          (successMessage) async {
            _watchlistMessage = successMessage;
          },
        );
        add(CheckWatchlistStatusEvent(movie.id));
      },
    );
  }
}
