import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/popular_movies_bloc.dart';
import '../bloc/popular_movies_event.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  late PopularMoviesBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<PopularMoviesBloc>()..add(FetchPopularMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = bloc.popularMovies[index];
                  return MovieCard(movie);
                },
                itemCount: bloc.popularMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(bloc.message),
              );
            }
          },
        ),
      ),
    );
  }
}
