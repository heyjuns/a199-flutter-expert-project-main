import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvsBloc bloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    bloc = WatchlistTvsBloc(
      getWatchlistTvs: mockGetWatchlistTvs,
    );
  });

  group('watchlist tvs list', () {
    test('should emit WatchlistTvsInitialState', () {
      expect(bloc.state, WatchlistTvsInitialState());
    });
    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'Should emit [WatchlistTvsLoadingState, WatchlistTvsLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvsEvent()),
      expect: () => [
        WatchlistTvsLoadingState(),
        WatchlistTvsLoadedState(),
      ],
      verify: (bloc) {
        verify(
          mockGetWatchlistTvs.execute(),
        );
      },
    );
    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'Should emit [WatchlistTvsLoadingState, WatchlistTvsErrorState] when usecase is error',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvsEvent()),
      expect: () => [
        WatchlistTvsLoadingState(),
        WatchlistTvsErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetWatchlistTvs.execute(),
        );
      },
    );
  });
}
