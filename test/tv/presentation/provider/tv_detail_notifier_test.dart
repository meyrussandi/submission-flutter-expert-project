import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/tv/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/tv/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/tv/domain/usecases/save_wacthlist_tv.dart';
import 'package:ditonton/tv/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../presentation/provider/movie_detail_notifier_test.mocks.dart';
import '../../dummy_data/dummy_object.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveWatchListTv,
  RemoveWatchListTv,
  GetWatchListTv
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecomendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveWatchListTv mockSaveWatchlistTv;
  late MockRemoveWatchListTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockGetTvRecomendations = MockGetTvRecommendations();
    mockSaveWatchlistTv = MockSaveWatchListTv();
    mockRemoveWatchlistTv = MockRemoveWatchListTv();
    provider = TvDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecomendations,
        getTvWatchListStatus: mockGetTvWatchListStatus,
        saveWatchListTv: mockSaveWatchlistTv,
        removeWatchListTv: mockRemoveWatchlistTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1399;

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecomendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  group("get Tv Detail", () {
    test("seharusnya dapet data dari usecase", () async {
      //arrange
      _arrangeUsecase();
      //act
      await provider.fetchTvDetail(tId);
      //assert
      verify(mockGetTvDetail.execute(tId));
    });

    test("seharusnnya merubah state loading ketika mengambil data", () {
      //arrange
      _arrangeUsecase();
      //act
      provider.fetchTvDetail(tId);
      //assert
      expect(provider.tvDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test(
        "seharusnnya mengisi tvdetail dengan data ketika berhasil mengambil data",
        () async {
      //arrange
      _arrangeUsecase();
      //act
      await provider.fetchTvDetail(tId);
      //assert
      expect(provider.tvDetailState, RequestState.Loaded);
      expect(provider.tvDetail, testTvDetail);
      expect(listenerCallCount, 3);
    });
  });

  group("recommendations tv", () {
    test("seharusnya dapet data dari usecase gettvrecommendations", () async {
      //arrange
      _arrangeUsecase();
      //act
      await provider.fetchTvDetail(tId);
      //assert
      verify(mockGetTvRecomendations.execute(tId));
      expect(provider.tvRecommendations, tTvList);
    });

    test(
        "seharusnnya merubah state recommendation loading ketika mengambil data",
        () {
      //arrange
      _arrangeUsecase();
      //act
      provider.fetchTvDetail(tId);
      //assert
      expect(provider.tvRecommendationsState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test(
        "seharusnnya mengisi tvrecommendations dengan data ketika berhasil mengambil data",
        () async {
      //arrange
      _arrangeUsecase();
      //act
      await provider.fetchTvDetail(tId);
      //assert
      expect(provider.tvRecommendationsState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvList);
      expect(listenerCallCount, 3);
    });
  });

  group('Watchlist Tv', () {
    test('seharu7snya mengembalikan status whactlisttv', () async {
      // arrange
      when(mockGetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isInWatchList, true);
    });

    test('seharusnya seave tv ke watchlist sudah digunakan', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('seharusmnya menghapus tv detail dari data watchlist sudah digunakan',
        () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTv(testTvDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test(
        'seharusnya update whatclist tv status ketika sukses menambahkan ke watchlist',
        () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      verify(mockGetTvWatchListStatus.execute(testTvDetail.id));
      expect(provider.isInWatchList, true);
      expect(provider.tvWatchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test(
        'seharusnya update whatclist tv status ketika gagal menambahkan ke watchlist',
        () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      expect(provider.tvWatchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('seharusnya mengembalikan error jketika gagal mendapatkan data',
        () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvDetailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
