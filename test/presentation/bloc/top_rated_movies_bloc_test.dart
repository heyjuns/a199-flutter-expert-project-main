import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMoviesBloc(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  group('top rated Movies list', () {
    test('should emit TopRatedMoviesInitialState', () {
      expect(bloc.state, TopRatedMoviesInitialState());
    });
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [TopRatedMoviesLoadingState, TopRatedMoviesLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoadingState(),
        TopRatedMoviesLoadedState(),
      ],
      verify: (bloc) {
        verify(
          mockGetTopRatedMovies.execute(),
        );
      },
    );
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [TopRatedMoviesLoadingState, TopRatedMoviesErrorState] when usecase is error',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoadingState(),
        TopRatedMoviesErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetTopRatedMovies.execute(),
        );
      },
    );
  });
}
