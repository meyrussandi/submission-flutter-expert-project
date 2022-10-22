import 'package:dartz/dartz.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';
import 'package:ditonton/tv/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class SearchTv {
  final TvRepository tvRepository;
  SearchTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return tvRepository.searchTv(query);
  }
}
