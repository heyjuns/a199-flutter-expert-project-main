import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_event.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_watchlist_tv.dart';

class WatchlistTvsBloc extends Bloc<WatchlistTvsEvent, WatchlistTvsState> {
  final GetWatchlistTvs getWatchlistTvs;

  String _message = '';
  get message => _message;

  List<Tv> _watchlistTvs = [];
  get watchlistTvs => _watchlistTvs;

  WatchlistTvsBloc({required this.getWatchlistTvs})
      : super(WatchlistTvsInitialState()) {
    on<FetchWatchlistTvsEvent>(_onFetchWatchlistTvs);
  }
  Future<void> _onFetchWatchlistTvs(
    FetchWatchlistTvsEvent event,
    Emitter<WatchlistTvsState> emit,
  ) async {
    emit(WatchlistTvsLoadingState());
    final watchlistResult = await getWatchlistTvs.execute();

    watchlistResult.fold(
      (error) {
        _message = error.message;
        emit(WatchlistTvsErrorState(_message));
      },
      (tvs) {
        _watchlistTvs = tvs;
        emit(WatchlistTvsLoadedState());
      },
    );
  }
}
