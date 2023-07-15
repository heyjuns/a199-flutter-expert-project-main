import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/search_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tvs_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late SearchTvsBloc searchTvsBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvsBloc = SearchTvsBloc(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(searchTvsBloc.state, SearchTvsEmpty());
  });

  final tquery = 'breaking';
  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tquery))
          .thenAnswer((_) async => Right(testTvList));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvsChanged(tquery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchTvsLoading(), SearchTvsHasData(testTvList)],
    verify: (bloc) => verify(mockSearchTvs.execute(tquery)),
  );
}
