// Mocks generated by Mockito 5.3.2 from annotations
// in core/test/tv/presentation/pages/popular_tv_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:core/core.dart' as _i7;
import 'package:core/tv/domain/entities/tv.dart' as _i6;
import 'package:core/tv/domain/usecases/get_now_playing_tv.dart' as _i2;
import 'package:core/tv/domain/usecases/get_popular_tv.dart' as _i3;
import 'package:core/tv/domain/usecases/get_top_rated_tv.dart' as _i4;
import 'package:core/tv/presentation/provider/tv_list_notifier.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetNowPlayingTv_0 extends _i1.SmartFake
    implements _i2.GetNowPlayingTv {
  _FakeGetNowPlayingTv_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetPopularTv_1 extends _i1.SmartFake implements _i3.GetPopularTv {
  _FakeGetPopularTv_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTopRatedTv_2 extends _i1.SmartFake implements _i4.GetTopRatedTv {
  _FakeGetTopRatedTv_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvListNotifier extends _i1.Mock implements _i5.TvListNotifier {
  MockTvListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingTv get getNowPlayingTv => (super.noSuchMethod(
        Invocation.getter(#getNowPlayingTv),
        returnValue: _FakeGetNowPlayingTv_0(
          this,
          Invocation.getter(#getNowPlayingTv),
        ),
      ) as _i2.GetNowPlayingTv);
  @override
  _i3.GetPopularTv get getPopularTv => (super.noSuchMethod(
        Invocation.getter(#getPopularTv),
        returnValue: _FakeGetPopularTv_1(
          this,
          Invocation.getter(#getPopularTv),
        ),
      ) as _i3.GetPopularTv);
  @override
  _i4.GetTopRatedTv get getTopRatedTv => (super.noSuchMethod(
        Invocation.getter(#getTopRatedTv),
        returnValue: _FakeGetTopRatedTv_2(
          this,
          Invocation.getter(#getTopRatedTv),
        ),
      ) as _i4.GetTopRatedTv);
  @override
  List<_i6.Tv> get nowPlayingTv => (super.noSuchMethod(
        Invocation.getter(#nowPlayingTv),
        returnValue: <_i6.Tv>[],
      ) as List<_i6.Tv>);
  @override
  _i7.RequestState get nowPlayingState => (super.noSuchMethod(
        Invocation.getter(#nowPlayingState),
        returnValue: _i7.RequestState.Empty,
      ) as _i7.RequestState);
  @override
  List<_i6.Tv> get popularTv => (super.noSuchMethod(
        Invocation.getter(#popularTv),
        returnValue: <_i6.Tv>[],
      ) as List<_i6.Tv>);
  @override
  _i7.RequestState get popularState => (super.noSuchMethod(
        Invocation.getter(#popularState),
        returnValue: _i7.RequestState.Empty,
      ) as _i7.RequestState);
  @override
  List<_i6.Tv> get topRatedTv => (super.noSuchMethod(
        Invocation.getter(#topRatedTv),
        returnValue: <_i6.Tv>[],
      ) as List<_i6.Tv>);
  @override
  _i7.RequestState get topRatedState => (super.noSuchMethod(
        Invocation.getter(#topRatedState),
        returnValue: _i7.RequestState.Empty,
      ) as _i7.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchNowPlayingTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchNowPlayingTv,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchPopularTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularTv,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchTopRatedTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedTv,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
