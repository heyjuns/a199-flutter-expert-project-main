import 'package:ditonton/presentation/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvs_event.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  late PopularTvsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<PopularTvsBloc>()..add(FetchPopularTvsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvsBloc, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvsLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = bloc.popularTvs[index];
                  return TvCard(tv);
                },
                itemCount: bloc.popularTvs.length,
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
