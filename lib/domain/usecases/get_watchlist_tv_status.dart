import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchListTvStatus {
  final TvRepository _repository;

  GetWatchListTvStatus(this._repository);

  Future<bool> execute(int id) async {
    return _repository.isAddedToWatchlist(id);
  }
}
