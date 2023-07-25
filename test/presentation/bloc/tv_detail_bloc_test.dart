import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvRecommendations,
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
  GetTvDetail,
])
void main() {
  late TvDetailBloc bloc;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockGetTvDetail mockGetTvDetail;
  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetTvDetail = MockGetTvDetail();

    bloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListTvStatus: mockGetWatchListTvStatus,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    );
  });

  group('TvDetailBloc', () {
    test('initial state should be init', () {
      expect(bloc.state, TvDetailInitialState());
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [TvListLoadingState, TvListLoadedState(true)] when get Tv detail success and status watchlist true',
      build: () {
        when(mockGetTvDetail.execute(1))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetWatchListTvStatus.execute(1)).thenAnswer((_) async => true);
        when(mockGetTvRecommendations.execute(1))
            .thenAnswer((_) async => Right(testTvList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTvDetailEvent(1)),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailLoadedState(true),
      ],
      verify: (bloc) {
        verify(
          mockGetTvDetail.execute(1),
        );
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [TvListLoadingState, TvDetailErrorState] when get Tv detail failed',
      build: () {
        when(mockGetTvDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('')));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTvDetailEvent(1)),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailErrorState(''),
      ],
      verify: (bloc) {
        verify(
          mockGetTvDetail.execute(1),
        );
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [TvListLoadingState, TvListLoadedState(false)] when get Tv detail success and status watchlist false',
      build: () {
        when(mockGetTvDetail.execute(1))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetWatchListTvStatus.execute(1))
            .thenAnswer((_) async => false);
        when(mockGetTvRecommendations.execute(1))
            .thenAnswer((_) async => Right(testTvList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTvDetailEvent(1)),
      expect: () => [
        TvDetailLoadingState(),
        TvDetailLoadedState(false),
      ],
      verify: (bloc) {
        verify(
          mockGetTvDetail.execute(1),
        );
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [TvDetailWatchlistState, TvListLoadedState(true)] when save watchlist',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchListTvStatus.execute(1))
            .thenAnswer((_) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistTvEvent(testTvDetail)),
      expect: () => [
        TvDetailWatchlistState(),
        TvDetailLoadedState(false),
      ],
      verify: (bloc) {
        verify(
          mockSaveWatchlistTv.execute(testTvDetail),
        );
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [TvDetailWatchlistState, TvListLoadedState(false)] when save watchlist',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(mockGetWatchListTvStatus.execute(1))
            .thenAnswer((_) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTvEvent(testTvDetail)),
      expect: () => [
        TvDetailWatchlistState(),
        TvDetailLoadedState(false),
      ],
      verify: (bloc) {
        verify(
          mockRemoveWatchlistTv.execute(testTvDetail),
        );
      },
    );
  });
}
