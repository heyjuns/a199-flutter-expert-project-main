import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_event.dart';

import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import '../../domain/usecases/get_watchlist_tv_status.dart';
import '../../domain/usecases/remove_watchlist_tv.dart';
import '../../domain/usecases/save_watchlist_tv.dart';

class TvDetailBloc extends Bloc<TvDetailBloc, TvDetailState> {
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListTvStatus getWatchListTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetTvDetail getTvDetail;

  TvDetailBloc({
    required this.getTvRecommendations,
    required this.getWatchListTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
    required this.getTvDetail,
  }) : super(TvDetailInitialState());
}
