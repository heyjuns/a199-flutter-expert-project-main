import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
  final bool adult;
  final String backdropPath;
  final List<int> episodeRunTime;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TvDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        homepage: json["homepage"] ?? "",
        id: json["id"],
        inProduction: json["in_production"] ?? false,
        languages: List<String>.from(json["languages"].map((x) => x)),
        name: json["name"] ?? "",
        numberOfEpisodes: json["number_of_episodes"] ?? 0,
        numberOfSeasons: json["number_of_seasons"] ?? 0,
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? "",
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        status: json["status"] ?? "",
        type: json["type"] ?? "",
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"] ?? 0,
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'episode_run_time': episodeRunTime,
        'genres': genres.map((genre) => genre.toEntity()).toList(),
        'homepage': homepage,
        'id': id,
        'in_production': inProduction,
        'languages': languages,
        'name': name,
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'seasons': seasons.map((season) => season.toEntity()).toList(),
        'status': status,
        'type': type,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      episodeRunTime: this.episodeRunTime,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
      status: this.status,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        type,
        voteAverage,
        voteCount,
      ];
}
