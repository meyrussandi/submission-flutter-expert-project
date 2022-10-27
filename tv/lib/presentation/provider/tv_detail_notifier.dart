import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_recomendations.dart';
import '../../domain/usecases/get_tv_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist_tv.dart';
import '../../domain/usecases/save_wacthlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  var _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;
  var _tvRecommendationsState = RequestState.Empty;
  RequestState get tvRecommendationsState => _tvRecommendationsState;

  var _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  late List<Tv> _tvRecommendations;
  List<Tv> get tvRecommendations => _tvRecommendations;

  bool _isInTvWatchList = false;
  bool get isInWatchList => _isInTvWatchList;

  TvDetailNotifier(
      {required this.getTvDetail,
      required this.getTvRecommendations,
      required this.getTvWatchListStatus,
      required this.saveWatchListTv,
      required this.removeWatchListTv});

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchListTv removeWatchListTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    _tvRecommendationsState = RequestState.Loading;

    notifyListeners();

    final result = await getTvDetail.execute(id);
    final resultRecommendations = await getTvRecommendations.execute(id);
    result.fold((fail) {
      _tvDetailState = RequestState.Error;
      _message = fail.message;
      notifyListeners();
    }, (data) {
      _tvDetail = data;
      notifyListeners();

      resultRecommendations.fold((l) {
        _tvRecommendationsState = RequestState.Error;
        _message = l.message;
      }, (r) {
        _tvRecommendationsState = RequestState.Loaded;
        _tvRecommendations = r;
      });

      _tvDetailState = RequestState.Loaded;
      notifyListeners();
    });
  }

  String _tvWatchlistMessage = '';
  String get tvWatchlistMessage => _tvWatchlistMessage;

  Future<void> addWatchlistTv(TvDetail tv) async {
    final result = await saveWatchListTv.execute(tv);

    await result.fold(
      (failure) async {
        _tvWatchlistMessage = failure.message;
      },
      (successMessage) async {
        _tvWatchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlistTv(TvDetail tv) async {
    final result = await removeWatchListTv.execute(tv);

    await result.fold(
      (failure) async {
        _tvWatchlistMessage = failure.message;
      },
      (successMessage) async {
        _tvWatchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchListStatus.execute(id);
    _isInTvWatchList = result;
    notifyListeners();
  }
}
