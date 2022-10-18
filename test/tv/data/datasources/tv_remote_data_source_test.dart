import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("get on air tv", () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('tv/dummy_data/on_the_air.json')))
        .tvList;

    test("seharusnya mengembalikan list of tv model ketika codenya 200",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('tv/dummy_data/on_the_air.json'), 200));
      //act
      final result = await dataSource.getNowPlayingTv();
      //assert
      expect(result, equals(tTvList));
    });

    test(
        "seharusnya mengembalikan server exception ketika codenya 404 atau yg lainnya",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getNowPlayingTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
