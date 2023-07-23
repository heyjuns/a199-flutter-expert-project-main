import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late TvListBloc bloc;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    bloc = TvListBloc(
      getNowPlayingTvs: mockGetNowPlayingTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    );
  });

  test('initial state should be init', () {
    expect(bloc.state, TvListInitialState());
  });
  group('Tv list', () {
    blocTest<TvListBloc, TvListState>(
      'Should emit [TvListLoadingState, TvListLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAllTvListEvent()),
      expect: () => [
        TvListLoadingState(),
        TvListLoadedState(),
      ],
      verify: (bloc) {
        verifyInOrder([
          mockGetNowPlayingTvs.execute(),
          mockGetPopularTvs.execute(),
          mockGetTopRatedTvs.execute(),
        ]);
      },
    );
    blocTest<TvListBloc, TvListState>(
      'Should emit [TvListLoadingState, TvListErrorState] when one of usecase is gotten error',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAllTvListEvent()),
      expect: () => [
        TvListLoadingState(),
        TvListErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verifyInOrder([
          mockGetNowPlayingTvs.execute(),
          mockGetPopularTvs.execute(),
          mockGetTopRatedTvs.execute(),
        ]);
      },
    );
  });
}
