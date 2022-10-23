import 'package:flutter/material.dart';

import '../../../core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_now_playing_tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <Tv>[];
  List<Tv> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = "";
  String get message => _message;

  TvListNotifier(
      {required this.getNowPlayingTv,
      required this.getPopularTv,
      required this.getTopRatedTv});

  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold((l) {
      _nowPlayingState = RequestState.Error;
      _message = l.message;
      notifyListeners();
    }, (r) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingTv = r;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTv() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold((fail) {
      _popularState = RequestState.Error;
      _message = fail.message;
      notifyListeners();
    }, (data) {
      _popularState = RequestState.Loaded;
      _popularTv = data;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold((fail) {
      _topRatedState = RequestState.Error;
      _message = fail.message;
      notifyListeners();
    }, (data) {
      _topRatedState = RequestState.Loaded;
      _topRatedTv = data;
      notifyListeners();
    });
  }
}
