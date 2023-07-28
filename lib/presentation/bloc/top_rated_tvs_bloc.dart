import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs_event.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs getTopRatedTvs;

  String _message = '';
  get message => _message;

  List<Tv> _topRatedTvs = [];
  get topRatedTvs => _topRatedTvs;

  TopRatedTvsBloc({required this.getTopRatedTvs})
      : super(TopRatedTvsInitialState()) {
    on<FetchTopRatedTvsEvent>(_onFetchTopRatedTvs);
  }
  Future<void> _onFetchTopRatedTvs(
    FetchTopRatedTvsEvent event,
    Emitter<TopRatedTvsState> emit,
  ) async {
    emit(TopRatedTvsLoadingState());
    try {
      final topRatedResult = await getTopRatedTvs.execute();

      topRatedResult.fold(
        (error) {
          _message = error.message;
          emit(TopRatedTvsErrorState(_message));
        },
        (tvs) {
          _topRatedTvs = tvs;
          emit(TopRatedTvsLoadedState());
        },
      );
    } catch (e) {
      _message = 'something went wrong :(';
      emit(TopRatedTvsErrorState(e.toString()));
    }
  }
}
