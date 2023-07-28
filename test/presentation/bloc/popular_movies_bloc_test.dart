import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_event.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMoviesBloc(
      getPopularMovies: mockGetPopularMovies,
    );
  });

  group('popular Movies list', () {
    test('should emit PopularMoviesInitialState', () {
      expect(bloc.state, PopularMoviesInitialState());
    });
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [PopularMoviesLoadingState, PopularMoviesLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoadingState(),
        PopularMoviesLoadedState(),
      ],
      verify: (bloc) {
        verify(
          mockGetPopularMovies.execute(),
        );
      },
    );
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [PopularMoviesLoadingState, PopularMoviesErrorState] when usecase is error',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoadingState(),
        PopularMoviesErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetPopularMovies.execute(),
        );
      },
    );
  });
}
