import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetMovieDetail mockGetMovieDetail;
  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetMovieDetail = MockGetMovieDetail();

    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('MovieDetailBloc', () {
    test('initial state should be init', () {
      expect(bloc.state, MovieDetailInitialState());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieListLoadingState, MovieListLoadedState(true)] when get Movie detail success and status watchlist true',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetailEvent(1)),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailLoadedState(true),
      ],
      verify: (bloc) {
        verify(
          mockGetMovieDetail.execute(1),
        );
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieListLoadingState, MovieDetailErrorState] when get Movie detail failed',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('')));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetailEvent(1)),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailErrorState(''),
      ],
      verify: (bloc) {
        verify(
          mockGetMovieDetail.execute(1),
        );
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieListLoadingState, MovieListLoadedState(false)] when get Movie detail success and status watchlist false',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetailEvent(1)),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailLoadedState(false),
      ],
      verify: (bloc) {
        verify(
          mockGetMovieDetail.execute(1),
        );
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieDetailWatchlistState, MovieListLoadedState(true)] when save watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistMovieEvent(testMovieDetail)),
      expect: () => [
        MovieDetailLoadedState(false),
      ],
      verify: (bloc) {
        verify(
          mockSaveWatchlist.execute(testMovieDetail),
        );
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieDetailWatchlistState, MovieListLoadedState(false)] when save watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistMovieEvent(testMovieDetail)),
      expect: () => [
        MovieDetailLoadedState(false),
      ],
      verify: (bloc) {
        verify(
          mockRemoveWatchlist.execute(testMovieDetail),
        );
      },
    );
  });
}
