import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail_event.dart';

import '../../domain/entities/tv.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListTvStatus getWatchListTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetTvDetail getTvDetail;
  String _message = '';
  get message => _message;

  late TvDetail _tvDetail;
  get tvDetail => _tvDetail;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  List<Tv> _tvRecommendations = [];
  get tvRecommendations => _tvRecommendations;

  TvDetailBloc({
    required this.getTvRecommendations,
    required this.getWatchListTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
    required this.getTvDetail,
  }) : super(TvDetailInitialState()) {
    on<FetchTvDetailEvent>((event, emit) async {
      emit(TvDetailLoadingState());

      int id = event.id;
      await Future.wait([
        getTvDetail.execute(id),
        getTvRecommendations.execute(id),
      ]).then((response) {
        response[0].fold(
          (error) {
            _message = error.message;
            emit(TvDetailErrorState(_message));
          },
          (tvs) {
            _tvDetail = tvs as TvDetail;
            add(FetchTvStatusEvent(id));
          },
        );
        response[1].fold(
          (error) {
            _message = error.message;
            emit(TvDetailErrorState(_message));
          },
          (tvRecommendations) {
            _tvRecommendations = tvRecommendations as List<Tv>;
          },
        );
      }).whenComplete(() {
        emit(TvDetailLoadedState(isAddedToWatchlist));
      });
    });

    on<FetchTvRecommendationEvent>(
      (event, emit) async {
        int id = event.id;
        final response = await getTvRecommendations.execute(id);
        response.fold(
          (error) {
            _message = error.message;
            emit(TvDetailErrorState(_message));
          },
          (tvRecommendations) {
            _tvRecommendations = tvRecommendations;
          },
        );
      },
    );

    on<FetchTvStatusEvent>((event, emit) async {
      int id = event.id;
      final response = await getWatchListTvStatus.execute(id);
      _isAddedToWatchlist = response;
      emit(TvDetailLoadedState(isAddedToWatchlist));
    });

    on<RemoveWatchlistTvEvent>((event, emit) async {
      TvDetail tv = event.tv;
      final response = await removeWatchlistTv.execute(tv);
      print(response);
      await response.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
          add(FetchTvStatusEvent(tv.id));
        },
      );
    });

    on<SaveWatchlistTvEvent>((event, emit) async {
      TvDetail tv = event.tv;
      final response = await saveWatchlistTv.execute(tv);
      print(response);
      await response.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
          add(FetchTvStatusEvent(tv.id));
        },
      );
    });
  }
}
