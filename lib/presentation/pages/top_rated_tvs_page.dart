import 'package:ditonton/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs_event.dart';
import 'package:ditonton/presentation/widgets/Tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  late TopRatedTvsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TopRatedTvsBloc>()..add(FetchTopRatedTvsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
          builder: (context, state) {
            if (state is TopRatedTvsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvsLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = bloc.topRatedTvs[index];
                  return TvCard(tv);
                },
                itemCount: bloc.topRatedTvs.length,
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
