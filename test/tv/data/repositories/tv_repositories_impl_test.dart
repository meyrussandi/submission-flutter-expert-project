import 'package:ditonton/tv/data/models/tv_model.dart';
import 'package:ditonton/tv/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late TvRepositoryImpl repositoryImpl;
  late MockTvRemoteDataSource mockTvRemoteDataSource;

  setUp((){
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repositoryImpl = TvRepositoryImpl(remoteDataSource: mockTvRemoteDataSource);
  });

  final tTvModel = TvModel(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2, 3],
      id: 1,
      name: "name",
      originCountry: ["A", "B", "C"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  final tTv = Tv(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2, 3],
      id: 1,
      name: "name",
      originCountry: ["A", "B", "C"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];
  
  group("tv on air", (){
    test("seharusnya mengembalikan data dari remote ketika sukses", ()async{
      //arrange
      when(mockTvRemoteDataSource.getNowPlayingTv()).thenAnswer((_)async => tTvModelList);
      //act
      final result = await repositoryImpl.getNowPlayingTv();
      //assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      final resultList = result.getOrElse(()=>[]);
      expect(resultList, tTvList);
    });
  });
}