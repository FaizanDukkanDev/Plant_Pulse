import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/data/farm/models/News.dart';
import 'package:plantpulse/data/farm/resources/repository.dart';
import 'package:plantpulse/ui/widgets/news_customWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Widget/newsCard.dart';
import 'bloc/bloc.dart';

class HomePage extends StatelessWidget {
  Widget _headerNews(Article article) {
    return Builder(
      builder: (context) {
        return InkWell(
            onTap: () {},
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Hero(
                  tag: 'headerImage',
                  child: customImage(article.urlToImage),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10, bottom: 20, top: 20),
                  color: Colors.black26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(article.title,
                          style: AppTheme.appTheme.textTheme.titleMedium!
                              .copyWith(color: Theme.of(context).colorScheme.onSurface)),
                      Text(article.getTime(),
                          style:
                              AppTheme.appTheme.textTheme.titleMedium!.copyWith(color: Theme.of(context).disabledColor))
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget _body(
    BuildContext context,
    List<Article> list, {
    required String type,
  }) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            // '${type.toUpperCase()} NEWS',
            'type NEWS',
            style: AppTheme.appTheme.textTheme.titleMedium!.copyWith(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 10.0,
          shadowColor: Colors.grey,
          pinned: true,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => NewsCard(
                      artical: list[index],
                      type: 'type.toUpperCase()',
                    ),
                // childCount: list.length
                childCount: 5
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     systemNavigationBarColor: Theme.of(context).backgroundColor,
    //     statusBarColor: Theme.of(context).backgroundColor));
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<NewsBloc>(
        create: (context) => NewsBloc(repository: Repository()),
  child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state == null) {
            return Center(child: Text('Null block'));
          }
          if (state is Failure) {
            return Center(child: Text('Something went wrong'));
          }
          if (state is Loaded) {
            if (state?.items.isEmpty ??true) {
              return Text('No content avilable');
            } else {
              return _body(context, state.items, type: state.type);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
),
    );
  }
}
