import 'dart:convert';

import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';
import '../../dummy_data/dummy_object.dart';

void main() {
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
      expect(result, expectJsonMap);
    });
  });
}
