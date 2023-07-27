import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail_event.dart';

import '../../domain/entities/movie.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetMovieDetail getMovieDetail;
  String _message = '';
  get message => _message;

  late MovieDetail _movieDetail;
  get movieDetail => _movieDetail;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  List<Movie> _movieRecommendations = [];
  get movieRecommendations => _movieRecommendations;

  MovieDetailBloc({
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getMovieDetail,
  }) : super(MovieDetailInitialState()) {
    on<FetchMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoadingState());

      int id = event.id;
      final responseDetail = await getMovieDetail.execute(id);
      final responseRecommendations = await getMovieRecommendations.execute(id);
      responseDetail.fold(
        (error) {
          _message = error.message;
          emit(MovieDetailErrorState(_message));
        },
        (movies) {
          _movieDetail = movies;
          add(FetchMovieStatusEvent(id));
        },
      );
      responseRecommendations.fold(
        (error) {
          _message = error.message;
          emit(MovieDetailErrorState(_message));
        },
        (movieRecommendations) {
          _movieRecommendations = movieRecommendations;
        },
      );
    });

    on<FetchMovieStatusEvent>((event, emit) async {
      int id = event.id;
      final response = await getWatchListStatus.execute(id);
      _isAddedToWatchlist = response;
      emit(MovieDetailLoadedState(isAddedToWatchlist));
    });

    on<RemoveWatchlistMovieEvent>((event, emit) async {
      MovieDetail movie = event.movie;
      final response = await removeWatchlist.execute(movie);
      print(response);
      await response.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
          add(FetchMovieStatusEvent(movie.id));
        },
      );
    });

    on<SaveWatchlistMovieEvent>((event, emit) async {
      MovieDetail movie = event.movie;
      final response = await saveWatchlist.execute(movie);
      print(response);
      await response.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
          add(FetchMovieStatusEvent(movie.id));
        },
      );
    });
  }
}
