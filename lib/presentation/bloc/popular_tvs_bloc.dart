import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvs_event.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_popular_tv.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs getPopularTvs;

  String _message = '';
  get message => _message;

  List<Tv> _popularTvs = [];
  get popularTvs => _popularTvs;

  PopularTvsBloc({required this.getPopularTvs})
      : super(PopularTvsInitialState()) {
    on<FetchPopularTvsEvent>(_onFetchPopularTvs);
  }
  Future<void> _onFetchPopularTvs(
    FetchPopularTvsEvent event,
    Emitter<PopularTvsState> emit,
  ) async {
    emit(PopularTvsLoadingState());
    final popularResult = await getPopularTvs.execute();

    popularResult.fold(
      (error) {
        _message = error.message;
        emit(PopularTvsErrorState(_message));
      },
      (tvs) {
        _popularTvs = tvs;
        emit(PopularTvsLoadedState());
      },
    );
  }
}
