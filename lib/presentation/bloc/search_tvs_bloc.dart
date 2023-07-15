import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/search_tvs_event.dart';
import 'package:rxdart/rxdart.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTvs searchTvs;
  SearchTvsBloc(this.searchTvs) : super(SearchTvsEmpty()) {
    on<OnQueryTvsChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvsLoading());
        final result = await searchTvs.execute(query);

        result.fold((failure) {
          emit(SearchTvsError(failure.message));
        }, (data) {
          emit(SearchTvsHasData(data));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
