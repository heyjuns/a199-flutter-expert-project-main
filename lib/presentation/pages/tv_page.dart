import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list_event.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tv.dart';

class TvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv';
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  late TvListBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TvListBloc>()..add(FetchAllTvListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvListLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvListLoadedState) {
                    return TvList(bloc.nowPlayingTvs);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvListLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvListLoadedState) {
                    return TvList(bloc.popularTvs);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvListLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvListLoadedState) {
                    return TvList(bloc.topRatedTvs);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
