import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_event.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-Tv';

  @override
  _WatchlistTvsPageState createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  late WatchlistTvsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<WatchlistTvsBloc>()..add(FetchWatchlistTvsEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    bloc.add(FetchWatchlistTvsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvsBloc, WatchlistTvsState>(
          builder: (context, state) {
            if (state is WatchlistTvsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvsLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = bloc.watchlistTvs[index];
                  return TvCard(tv);
                },
                itemCount: bloc.watchlistTvs.length,
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
