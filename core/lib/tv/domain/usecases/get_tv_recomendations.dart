import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return repository.getTvRecommendations(id);
  }
}
