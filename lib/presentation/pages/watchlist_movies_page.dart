import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/watchlist_movies_bloc.dart';
import '../bloc/watchlist_movies_event.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  late WatchlistMoviesBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<WatchlistMoviesBloc>()
      ..add(FetchWatchlistMoviesEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    bloc.add(FetchWatchlistMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = bloc.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: bloc.watchlistMovies.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
