import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list_event.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_now_playing_tvs.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTvs getNowPlayingTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  var _nowPlayingTvs = <Tv>[];
  List<Tv> get nowPlayingTvs => _nowPlayingTvs;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  String _message = '';
  String get message => _message;

  TvListBloc({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  }) : super(TvListInitialState()) {
    on<FetchAllTvListEvent>(_onFetchAllTvList);
  }
  Future<void> _onFetchAllTvList(
    FetchAllTvListEvent event,
    Emitter<TvListState> emit,
  ) async {
    emit(TvListLoadingState());
    try {
      final nowPlayingResult = await getNowPlayingTvs.execute();
      final popularResult = await getPopularTvs.execute();
      final topRatedResult = await getTopRatedTvs.execute();

      nowPlayingResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (tvs) => _nowPlayingTvs = tvs,
      );
      popularResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (tvs) => _popularTvs = tvs,
      );
      topRatedResult.fold(
        (error) {
          _message = error.message;
          throw error;
        },
        (tvs) => _topRatedTvs = tvs,
      );

      emit(TvListLoadedState());
    } catch (e) {
      emit(TvListErrorState(_message));
    }
  }
}
