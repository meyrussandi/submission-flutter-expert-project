import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';
import 'package:ditonton/tv/domain/repositories/tv_repository.dart';

class GetWatchListTv {
  final TvRepository tvRepository;

  GetWatchListTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getWatchlistTv();
  }
}
