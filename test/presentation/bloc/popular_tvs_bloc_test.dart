import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvs_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvsBloc bloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    bloc = PopularTvsBloc(
      getPopularTvs: mockGetPopularTvs,
    );
  });

  group('popular tvs list', () {
    test('should emit PopularTvsInitialState', () {
      expect(bloc.state, PopularTvsInitialState());
    });
    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [PopularTvsLoadingState, PopularTvsLoadedState] when all usecase is gotten successfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvsEvent()),
      expect: () => [
        PopularTvsLoadingState(),
        PopularTvsLoadedState(),
      ],
      verify: (bloc) {
        verify(
          mockGetPopularTvs.execute(),
        );
      },
    );
    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [PopularTvsLoadingState, PopularTvsErrorState] when usecase is error',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvsEvent()),
      expect: () => [
        PopularTvsLoadingState(),
        PopularTvsErrorState('Server Failure'),
      ],
      verify: (bloc) {
        verify(
          mockGetPopularTvs.execute(),
        );
      },
    );
  });
}
