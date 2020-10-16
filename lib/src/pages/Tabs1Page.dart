import 'package:flutter/material.dart';
import 'package:news_provider/src/services/NewsService.dart';
import 'package:news_provider/src/widgets/ListNews.dart';
import 'package:provider/provider.dart';

class Tabs1Page extends StatefulWidget {
  @override
  _Tabs1PageState createState() => _Tabs1PageState();
}

class _Tabs1PageState extends State<Tabs1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.length == 0)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListNews(
              news: newsService.headlines,
            ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
