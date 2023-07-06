import 'package:equatable/equatable.dart';

class Tv extends Equatable {
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

  Tv({
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

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  })  : backdropPath = null,
        genreIds = null,
        originalLanguage = null,
        originalName = null,
        popularity = null,
        voteAverage = null,
        voteCount = null;

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
      ];
}
