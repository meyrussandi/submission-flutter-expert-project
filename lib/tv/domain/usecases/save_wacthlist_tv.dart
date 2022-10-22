import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv/domain/entities/tv_detail.dart';
import 'package:ditonton/tv/domain/repositories/tv_repository.dart';

class SaveWatchListTv {
  final TvRepository tvRepository;

  SaveWatchListTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return tvRepository.saveWatchListTv(tvDetail);
  }
}
