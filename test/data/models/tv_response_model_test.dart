import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
    genreIds: [9648, 18],
    id: 202250,
    name: "Dirty Linen",
    originalLanguage: "tl",
    originalName: "Dirty Linen",
    overview: "overview",
    popularity: 2797.914,
    posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
    voteAverage: 5,
    voteCount: 13,
  );

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
            "genre_ids": [9648, 18],
            "id": 202250,
            "name": "Dirty Linen",
            "original_language": "tl",
            "original_name": "Dirty Linen",
            "overview": "overview",
            "popularity": 2797.914,
            "poster_path": "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
            "vote_average": 5,
            "vote_count": 13
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
