import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv/data/models/tv_model.dart';
import 'package:ditonton/tv/data/models/tv_table.dart';
import 'package:ditonton/tv/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repositoryImpl;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = TvRepositoryImpl(
        remoteDataSource: mockTvRemoteDataSource,
        localDataSource: mockTvLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  final tTvModel = TvModel(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2, 3],
      id: 121,
      name: "House of the Dragon",
      originCountry: ["A", "B", "C"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      voteAverage: 1,
      voteCount: 1);

  final tTv = Tv(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2, 3],
      id: 121,
      name: "House of the Dragon",
      originCountry: ["A", "B", "C"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      voteAverage: 1,
      voteCount: 1);

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  final testTvCache = TvTable(
      id: 121,
      name: "House of the Dragon",
      posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      overview: "overview");

  final testTvFromCache = Tv.watchList(
      id: 121,
      name: "House of the Dragon",
      posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      overview: "overview");

  group("tv on air", () {
    group("ketika terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("seharusnya mengecek jika device terhubung ke internet", () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => []);
        //act
        await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockNetworkInfo.isConnected);
      });
      test("seharusnya mengembalikan data list of TV dari remote ketika sukses",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          "seharusnya menyimpan data ke local jika berhasil mengambil data dari remote",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        //actt
        await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        verify(mockTvLocalDataSource.cacheNowPlayingTv([testTvCache]));
      });

      test("seharusnya mengembalikan failure ketika gagal mendapatkan data",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getNowPlayingTv())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvRemoteDataSource.getNowPlayingTv());
        expect(result, equals(Left(ServerFailure(""))));
      });
    });

    group("ketika tidak terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("seharusnya mengembalikan data dari lokal jika ada", () async {
        //arrange
        when(mockTvLocalDataSource.getCacheNowPlayingTv())
            .thenAnswer((_) async => [testTvCache]);

        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvLocalDataSource.getCacheNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test(
          "seharusnya mengembalikan exception cachefailure ketika tidak ada data dicache",
          () async {
        //arrange
        when(mockTvLocalDataSource.getCacheNowPlayingTv())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repositoryImpl.getNowPlayingTv();
        //assert
        verify(mockTvLocalDataSource.getCacheNowPlayingTv());
        expect(result, Left(CacheFailure("No Cache")));
      });
    });
  });

  group("tv popular", () {
    group("ketika terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("seharusnya mengecek jika device terhubung ke internet", () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv()).thenAnswer((_) async => []);
        //act
        await repositoryImpl.getPopularTv();
        //assert
        verify(mockNetworkInfo.isConnected);
      });
      test("seharusnya mengembalikan data list of TV dari remote ketika sukses",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => tTvModelList);
        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvRemoteDataSource.getPopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          "seharusnya menyimpan data ke local jika berhasil mengambil data dari remote",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => tTvModelList);
        //actt
        await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvRemoteDataSource.getPopularTv());
        verify(mockTvLocalDataSource.cachePopularTv([testTvCache]));
      });

      test("seharusnya mengembalikan failure ketika gagal mendapatkan data",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getPopularTv())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvRemoteDataSource.getPopularTv());
        expect(result, equals(Left(ServerFailure(""))));
      });
    });

    group("ketika tidak terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("seharusnya mengembalikan data dari lokal jika ada", () async {
        //arrange
        when(mockTvLocalDataSource.getCachePopularTv())
            .thenAnswer((_) async => [testTvCache]);

        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvLocalDataSource.getCachePopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test(
          "seharusnya mengembalikan exception cachefailure ketika tidak ada data dicache",
          () async {
        //arrange
        when(mockTvLocalDataSource.getCachePopularTv())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repositoryImpl.getPopularTv();
        //assert
        verify(mockTvLocalDataSource.getCachePopularTv());
        expect(result, Left(CacheFailure("No Cache")));
      });
    });
  });

  group("tv top rated", () {
    group("ketika terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("seharusnya mengecek jika device terhubung ke internet", () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => []);
        //act
        await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockNetworkInfo.isConnected);
      });
      test("seharusnya mengembalikan data list of TV dari remote ketika sukses",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => tTvModelList);
        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvRemoteDataSource.getTopRatedTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          "seharusnya menyimpan data ke local jika berhasil mengambil data dari remote",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => tTvModelList);
        //actt
        await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvRemoteDataSource.getTopRatedTv());
        verify(mockTvLocalDataSource.cacheTopRatedTv([testTvCache]));
      });

      test("seharusnya mengembalikan failure ketika gagal mendapatkan data",
          () async {
        //arrange
        when(mockTvRemoteDataSource.getTopRatedTv())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvRemoteDataSource.getTopRatedTv());
        expect(result, equals(Left(ServerFailure(""))));
      });
    });

    group("ketika tidak terhubung ke internet", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("seharusnya mengembalikan data dari lokal jika ada", () async {
        //arrange
        when(mockTvLocalDataSource.getCacheTopRatedTv())
            .thenAnswer((_) async => [testTvCache]);

        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvLocalDataSource.getCacheTopRatedTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test(
          "seharusnya mengembalikan exception cachefailure ketika tidak ada data dicache",
          () async {
        //arrange
        when(mockTvLocalDataSource.getCacheTopRatedTv())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repositoryImpl.getTopRatedTv();
        //assert
        verify(mockTvLocalDataSource.getCacheTopRatedTv());
        expect(result, Left(CacheFailure("No Cache")));
      });
    });
  });
}
