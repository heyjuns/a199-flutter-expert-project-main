import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvsBloc bloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    bloc = TopRatedTvsBloc(
      getTopRatedTvs: mockGetTopRatedTvs,
    );
  });

  group('top rated tvs list', () {
    test('should emit TopRatedTvsInitialState', () {
      expect(bloc.state, TopRatedTvsInitialState());
    });
    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [TopRatedTvsLoadingState, TopRatedTvsLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvsEvent()),
      expect: () => [
        TopRatedTvsLoadingState(),
        TopRatedTvsLoadedState(),
      ],
      verify: (bloc) {
        verify(
          mockGetTopRatedTvs.execute(),
        );
      },
    );
    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [TopRatedTvsLoadingState, TopRatedTvsErrorState] when usecase is error',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvsEvent()),
      expect: () => [
        TopRatedTvsLoadingState(),
        TopRatedTvsErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetTopRatedTvs.execute(),
        );
      },
    );
  });
}
