import 'package:ditonton/tv/data/models/tv_model.dart';
import 'package:ditonton/tv/data/models/tv_table.dart';
import 'package:ditonton/tv/domain/entities/tv.dart';

final tTvModel = TvModel(
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    firstAirDate: "2022-08-21",
    genreIds: [10765, 18, 10759],
    id: 94997,
    name: "House of the Dragon",
    originCountry: ["US", "B", "C"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 1.0,
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    voteAverage: 8.5,
    voteCount: 1816);

final tTv = Tv(
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    firstAirDate: "2022-08-21",
    genreIds: [10765, 18, 10759],
    id: 94997,
    name: "House of the Dragon",
    originCountry: ["US", "B", "C"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 1.0,
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    voteAverage: 8.5,
    voteCount: 1816);

final tTvModelList = <TvModel>[tTvModel];
final tTvList = <Tv>[tTv];

final testTvCache = TvTable(
    id: 94997,
    name: "House of the Dragon",
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.");

final testTvFromCache = Tv.watchList(
    id: 94997,
    name: "House of the Dragon",
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.");

final testTvCacheMap = {
  "id": 94997,
  "name": "House of the Dragon",
  "posterPath": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
  "overview":
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm."
};

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
      "overview":
          "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      "popularity": 1.0,
      "poster_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      "vote_average": 8.5,
      "vote_count": 1816
    }
  ]
};
