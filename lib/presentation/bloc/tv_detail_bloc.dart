import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail_event.dart';

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

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

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
      final response = await getTvDetail.execute(id);
      response.fold(
        (error) {
          _message = error.message;
          emit(TvDetailErrorState(_message));
        },
        (tvs) {
          _tvDetail = tvs;
          add(FetchTvStatusEvent(id));
        },
      );
    });

    on<FetchTvStatusEvent>((event, emit) async {
      int id = event.id;
      final response = await getWatchListTvStatus.execute(id);
      _isAddedtoWatchlist = response;
      emit(TvDetailLoadedState(response));
    });

    on<RemoveWatchlistTvEvent>((event, emit) async {
      TvDetail tv = event.tv;
      final response = await removeWatchlistTv.execute(tv);
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
