import 'package:ditonton/tv/data/datasources/db/database_helper.dart';

import '../../../common/exception.dart';
import '../models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<void> cacheNowPlayingTv(List<TvTable> tvList);
  Future<List<TvTable>> getCacheNowPlayingTv();
  Future<void> cachePopularTv(List<TvTable> tvList);
  Future<List<TvTable>> getCachePopularTv();
  Future<void> cacheTopRatedTv(List<TvTable> tvList);
  Future<List<TvTable>> getCacheTopRatedTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper tvDatabaseHelper;

  TvLocalDataSourceImpl({required this.tvDatabaseHelper});
  @override
  Future<void> cacheNowPlayingTv(List<TvTable> tvList) async {
    await tvDatabaseHelper.clearCache("now playing");
    await tvDatabaseHelper.insertCacheTransaction(tvList, 'now playing');
  }

  @override
  Future<List<TvTable>> getCacheNowPlayingTv() async {
    final result = await tvDatabaseHelper.getCacheTvList('now playing');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularTv(List<TvTable> tvList) async {
    await tvDatabaseHelper.clearCache("popular");
    await tvDatabaseHelper.insertCacheTransaction(tvList, 'popular');
  }

  @override
  Future<List<TvTable>> getCachePopularTv() async {
    final result = await tvDatabaseHelper.getCacheTvList('popular');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedTv(List<TvTable> tvList) async {
    await tvDatabaseHelper.clearCache("toprated");
    await tvDatabaseHelper.insertCacheTransaction(tvList, 'toprated');
  }

  @override
  Future<List<TvTable>> getCacheTopRatedTv() async {
    final result = await tvDatabaseHelper.getCacheTvList('toprated');
    if (result.length > 0) {
      return result.map((e) => TvTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
