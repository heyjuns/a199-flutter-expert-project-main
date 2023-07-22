import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockTopRatedMovies;

  setUp(() {
    mockTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(
      getTopRatedMovies: mockTopRatedMovies,
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
    expect(topRatedMoviesBloc.state, TopRatedMoviesInitialState());
  });
  group('movie list', () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [MovieListLoadingState, MovieListLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoadingState(),
        TopRatedMoviesLoadedState(),
      ],
      verify: (bloc) {
        verify(
          mockTopRatedMovies.execute(),
        );
      },
    );
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [MovieListLoadingState, MovieListErrorState] when one of usecase is gotten error',
      build: () {
        when(mockTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoadingState(),
        TopRatedMoviesErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockTopRatedMovies.execute(),
        );
      },
    );
  });
}
