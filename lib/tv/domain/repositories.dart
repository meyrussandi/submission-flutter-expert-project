import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';

abstract class TvRepository{
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
}