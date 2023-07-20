import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
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
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be init', () {
    expect(movieDetailBloc.state, MovieDetailInitialState());
  });

  final tId = 1;

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
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail and Recommendation', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieDetailLoadingState, MovieDetailLoadedState] when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetailEvent(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailLoadedState(),
      ],
      verify: (bloc) {
        verifyInOrder([
          mockGetMovieDetail.execute(tId),
          mockGetMovieRecommendations.execute(tId)
        ]);
      },
    );
  });

  group('watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(CheckWatchlistStatusEvent(1)),
      expect: () => [MovieDetailLoadedState()],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(1));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlistEvent(testMovieDetail)),
      expect: () => [
        MovieDetailLoadedState(),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistEvent(testMovieDetail)),
      expect: () => [
        MovieDetailLoadedState(),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}
