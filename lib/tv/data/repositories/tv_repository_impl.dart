import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';
import 'package:ditonton/tv/domain/repositories.dart';

class TvRepositoryImpl implements TvRepository{
  final TvRemoteDataSource remoteDataSource;

  TvRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async{
   try{
     final result = await remoteDataSource.getNowPlayingTv();
     return Right(result.map((e) => e.toEntity()).toList());
   }on ServerException{
     return Left(ServerFailure(''));
   }on SocketException{
     return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() {
    // TODO: implement getPopularTv
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() {
    // TODO: implement getTopRatedTv
    throw UnimplementedError();
  }

}