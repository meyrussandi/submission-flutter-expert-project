import 'package:core/core.dart';
import 'package:core/tv/domain/usecases/get_now_playing_tv.dart';
import 'package:core/tv/domain/usecases/get_popular_tv.dart';
import 'package:core/tv/domain/usecases/get_top_rated_tv.dart';
import 'package:core/tv/presentation/provider/tv_list_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListNotifier provider;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TvListNotifier(
        getNowPlayingTv: mockGetNowPlayingTv,
        getPopularTv: mockGetPopularTv,
        getTopRatedTv: mockGetTopRatedTv)
      ..addListener(() {
        //maksudnya brp kali notifyListeners() dipanggil
        listenerCallCount += 1;
      });
  });

  group("now playing tv", () {
    test("initialState harusnya empty", () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test("seharusnya mengembalikan data dari usecase", () async {
      //arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      //act
      provider.fetchNowPlayingTv();
      //assert
      verify(mockGetNowPlayingTv.execute());
    });

    test("seharusnya mengubah state jadi loading ketika mengambil data", () {
      //arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      //act
      provider.fetchNowPlayingTv();
      //assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test(
        "seharusnya mengubah tv (kosong jadi isi / update) ketika mendapatkan data berhasil",
        () async {
      //arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      //act
      await provider.fetchNowPlayingTv();
      //assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test("seharusnya mengembalikan error ketika tidak berhasil", () async {
      //arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchNowPlayingTv();
      //assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group("now popular tv", () {
    test("initialState harusnya empty", () {
      expect(provider.popularState, equals(RequestState.Empty));
    });

    test("seharusnya mengembalikan data dari usecase", () async {
      //arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      //act
      provider.fetchPopularTv();
      //assert
      verify(mockGetPopularTv.execute());
    });

    test("seharusnya mengubah state jadi loading ketika mengambil data", () {
      //arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      //act
      provider.fetchPopularTv();
      //assert
      expect(provider.popularState, RequestState.Loading);
    });

    test(
        "seharusnya mengubah tv (kosong jadi isi / update) ketika mendapatkan data berhasil",
        () async {
      //arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      //act
      await provider.fetchPopularTv();
      //assert
      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test("seharusnya mengembalikan error ketika tidak berhasil", () async {
      //arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchPopularTv();
      //assert
      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group("top rated tv", () {
    test("initialState harusnya empty", () {
      expect(provider.topRatedState, equals(RequestState.Empty));
    });

    test("seharusnya mengembalikan data dari usecase", () async {
      //arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      //act
      provider.fetchTopRatedTv();
      //assert
      verify(mockGetTopRatedTv.execute());
    });

    test("seharusnya mengubah state jadi loading ketika mengambil data", () {
      //arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      //act
      provider.fetchTopRatedTv();
      //assert
      expect(provider.topRatedState, RequestState.Loading);
    });

    test(
        "seharusnya mengubah tv (kosong jadi isi / update) ketika mendapatkan data berhasil",
        () async {
      //arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      //act
      await provider.fetchTopRatedTv();
      //assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test("seharusnya mengembalikan error ketika tidak berhasil", () async {
      //arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      //act
      await provider.fetchTopRatedTv();
      //assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
