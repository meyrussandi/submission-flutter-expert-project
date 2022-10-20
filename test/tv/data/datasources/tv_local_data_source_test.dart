import 'package:ditonton/common/exception.dart';
import 'package:ditonton/tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/tv/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_object.dart';

void main() {
  late TvLocalDataSourceImpl localDataSource;
  late MockTvDatabaseHelper databaseHelper;

  setUp(() {
    databaseHelper = MockTvDatabaseHelper();
    localDataSource = TvLocalDataSourceImpl(tvDatabaseHelper: databaseHelper);
  });

  group("on air tv", () {
    test("seharusnya memanggil database helper unntuk menyimpan data",
        () async {
      //arrange
      when(databaseHelper.clearCache('now playing')).thenAnswer((_) async => 1);
      //act
      await localDataSource.cacheNowPlayingTv([testTvCache]);

      //assert
      verify(databaseHelper.clearCache('now playing'));
      verify(
          databaseHelper.insertCacheTransaction([testTvCache], 'now playing'));
    });

    test("seharusnya mengembalikan list of tv jika ada", () async {
      //arrange
      when(databaseHelper.getCacheTvList('now playing'))
          .thenAnswer((_) async => [testTvCacheMap]);
      //act
      final result = await localDataSource.getCacheNowPlayingTv();
      //assert
      expect(result, [testTvCache]);
    });

    test("seharusnya mengembalikan cache exception jika tidak ada", () async {
      //arrange
      when(databaseHelper.getCacheTvList('now playing'))
          .thenAnswer((_) async => []);
      //act
      final call = localDataSource.getCacheNowPlayingTv();
      //assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group("popular tv", () {
    test("seharusnya memanggil database helper unntuk menyimpan data",
        () async {
      //arrange
      when(databaseHelper.clearCache('popular')).thenAnswer((_) async => 1);
      //act
      await localDataSource.cachePopularTv([testTvCache]);

      //assert
      verify(databaseHelper.clearCache('popular'));
      verify(databaseHelper.insertCacheTransaction([testTvCache], 'popular'));
    });

    test("seharusnya mengembalikan list of tv jika ada", () async {
      //arrange
      when(databaseHelper.getCacheTvList('popular'))
          .thenAnswer((_) async => [testTvCacheMap]);
      //act
      final result = await localDataSource.getCachePopularTv();
      //assert
      expect(result, [testTvCache]);
    });

    test("seharusnya mengembalikan cache exception jika tidak ada", () async {
      //arrange
      when(databaseHelper.getCacheTvList('popular'))
          .thenAnswer((_) async => []);
      //act
      final call = localDataSource.getCachePopularTv();
      //assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group("top rated tv", () {
    test("seharusnya memanggil database helper unntuk menyimpan data",
        () async {
      //arrange
      when(databaseHelper.clearCache('toprated')).thenAnswer((_) async => 1);
      //act
      await localDataSource.cacheTopRatedTv([testTvCache]);

      //assert
      verify(databaseHelper.clearCache('toprated'));
      verify(databaseHelper.insertCacheTransaction([testTvCache], 'toprated'));
    });

    test("seharusnya mengembalikan list of tv jika ada", () async {
      //arrange
      when(databaseHelper.getCacheTvList('toprated'))
          .thenAnswer((_) async => [testTvCacheMap]);
      //act
      final result = await localDataSource.getCacheTopRatedTv();
      //assert
      expect(result, [testTvCache]);
    });

    test("seharusnya mengembalikan cache exception jika tidak ada", () async {
      //arrange
      when(databaseHelper.getCacheTvList('toprated'))
          .thenAnswer((_) async => []);
      //act
      final call = localDataSource.getCacheTopRatedTv();
      //assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
