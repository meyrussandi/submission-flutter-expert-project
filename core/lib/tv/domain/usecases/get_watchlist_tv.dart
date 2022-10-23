import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetWatchListTv {
  final TvRepository tvRepository;

  GetWatchListTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getWatchlistTv();
  }
}
