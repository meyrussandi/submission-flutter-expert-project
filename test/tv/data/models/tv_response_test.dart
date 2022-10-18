import 'dart:convert';

import 'package:ditonton/tv/data/models/tv_model.dart';
import 'package:ditonton/tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      firstAirDate: "2022-08-21",
      genreIds: [10765, 18, 10759],
      id: 94997,
      name: "House of the Dragon",
      originCountry: ["US", "B", "C"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "Overview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 8.5,
      voteCount: 1816);

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group("fromJson", () {
    test("seharusnya mengembalikan model dari json", () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('tv/dummy_data/on_the_air.json'));

      //act
      final result = TvResponse.fromJson(jsonMap);
      //assert
      expect(result, tTvResponseModel);
    });
  });

  group("toJson", () {
    test("seharusnya mengambalikan json map", () async {
      //arrange

      //act
      final result = tTvResponseModel.toJson();
      //assert
      final expectJsonMap = {
        "results": [
          {
            "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
            "first_air_date": "2022-08-21",
            "genre_ids": [10765, 18, 10759],
            "id": 94997,
            "name": "House of the Dragon",
            "origin_country": ["US", "B", "C"],
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "posterPath",
            "vote_average": 8.5,
            "vote_count": 1816
          }
        ]
      };
      expect(result, expectJsonMap);
    });
  });
}
