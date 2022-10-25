import 'package:core/core.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/tv/presentation/pages/popular_tv_page.dart';
import 'package:core/tv/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([TvListNotifier])
void main() {
  late MockTvListNotifier mockTvListNotifier;

  setUp(() {
    mockTvListNotifier = MockTvListNotifier();
  });

  Widget _makeTesttableWidget(Widget body) {
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockTvListNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      "seharusnya halaman menampilkan loading ketika sedang mendapatkan data",
      (WidgetTester tester) async {
    when(mockTvListNotifier.popularState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFind = find.byType(Center);

    await tester.pumpWidget(_makeTesttableWidget(PopularTvPage()));

    expect(centerFind, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya halaman menampilkan data list tv popular ketika berhasil mendapatkan data",
      (WidgetTester tester) async {
    when(mockTvListNotifier.popularState).thenReturn(RequestState.Loaded);
    when(mockTvListNotifier.popularTv).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTesttableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      "seharusnya menampilkan pesan error ketika gagal mendapatkan data",
      (WidgetTester tester) async {
    when(mockTvListNotifier.popularState).thenReturn(RequestState.Error);
    when(mockTvListNotifier.message).thenReturn("Error Message");

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTesttableWidget(PopularTvPage()));
    expect(textFinder, findsOneWidget);
  });
}
