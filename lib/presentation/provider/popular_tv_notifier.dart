import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class PopularTvsNotifier extends ChangeNotifier {
  final GetPopularTvs getPopulartv;

  PopularTvsNotifier(this.getPopulartv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopulartvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopulartv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
