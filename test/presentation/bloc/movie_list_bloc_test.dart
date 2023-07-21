import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  test('initial state should be init', () {
    expect(movieListBloc.state, MovieListInitialState());
  });
  group('now playing movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [NowPlayingMovieListLoadingState, NowPlayingMovieListLoadedState] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieListEvent()),
      expect: () => [
        NowPlayingMovieListLoadingState(),
        NowPlayingMovieListLoadedState(tMovieList),
      ],
      verify: (bloc) {
        verify(
          mockGetNowPlayingMovies.execute(),
        );
      },
    );
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [NowPlayingMovieListLoadingState, NowPlayingMovieListErrorState] when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieListEvent()),
      expect: () => [
        NowPlayingMovieListLoadingState(),
        NowPlayingMovieListErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetNowPlayingMovies.execute(),
        );
      },
    );
  });

  group('Popular movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [PopularMovieListLoadingState, PopularMovieListLoadedState] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovieListEvent()),
      expect: () => [
        PopularMovieListLoadingState(),
        PopularMovieListLoadedState(tMovieList),
      ],
      verify: (bloc) {
        verify(
          mockGetPopularMovies.execute(),
        );
      },
    );
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [PopularMovieListLoadingState, PopularMovieListErrorState] when data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovieListEvent()),
      expect: () => [
        PopularMovieListLoadingState(),
        PopularMovieListErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetPopularMovies.execute(),
        );
      },
    );
  });

  group('Top Rated movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [TopRatedMovieListLoadingState, TopRatedMovieListLoadedState] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovieListEvent()),
      expect: () => [
        TopRatedMovieListLoadingState(),
        TopRatedMovieListLoadedState(tMovieList),
      ],
      verify: (bloc) {
        verify(
          mockGetTopRatedMovies.execute(),
        );
      },
    );
    blocTest<MovieListBloc, MovieListState>(
      'Should emit [TopRatedMovieListLoadingState, TopRatedMovieListErrorState] when data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovieListEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedMovieListLoadingState(),
        TopRatedMovieListErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetTopRatedMovies.execute(),
        );
      },
    );
  });
}
