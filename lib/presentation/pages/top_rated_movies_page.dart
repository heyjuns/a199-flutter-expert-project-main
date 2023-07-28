import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_event.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  late TopRatedMoviesBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TopRatedMoviesBloc>()..add(FetchTopRatedMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = bloc.topRatedMovies[index];
                  return MovieCard(movie);
                },
                itemCount: bloc.topRatedMovies.length,
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
