import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

import '../repositories/tv_repository.dart';

class GetTvWatchListStatus {
  final TvRepository repository;

  GetTvWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isInWatchList(id);
  }
}
