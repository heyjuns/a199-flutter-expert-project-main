import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  final int? id;
  final String? overview;
  final String? posterPath;
  final String? name;
  final String? backdropPath;
  final List<int>? genreIds;
  final String? originalLanguage;
  final String? originalName;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;

  TvModel({
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        name: json["name"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": genreIds,
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_language": originalLanguage,
        "original_name": originalName,
      };

  Tv toEntity() {
    return Tv(
      id: this.id,
      overview: this.overview,
      posterPath: this.posterPath,
      name: this.name,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      popularity: this.popularity,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        genreIds,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        backdropPath,
      ];
}
