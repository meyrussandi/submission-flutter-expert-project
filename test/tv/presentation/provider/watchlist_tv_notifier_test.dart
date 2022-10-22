import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/tv/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/tv/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([GetWatchListTv])
void main() {
  late WatchlistTvNotifier provider;
  late MockGetWatchListTv mockGetWatchListTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTv = MockGetWatchListTv();
    provider = WatchlistTvNotifier(
      getWatchListTv: mockGetWatchListTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('seharusnya mengubah tv data ketika berhasil', () async {
    // arrange
    when(mockGetWatchListTv.execute())
        .thenAnswer((_) async => Right([testTvFromCache]));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTv, [testTvFromCache]);
    expect(listenerCallCount, 2);
  });

  test('seharusnya mengembalikan error ketika gagal', () async {
    // arrange
    when(mockGetWatchListTv.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
