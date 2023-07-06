import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetWatchlistTvs {
  final TvRepository repository;

  GetWatchlistTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTvs();
  }
}
