import 'package:flutter/material.dart';
import 'package:news_provider/src/services/NewsService.dart';
import 'package:news_provider/src/widgets/ListNews.dart';
import 'package:provider/provider.dart';

class Tabs1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: ListNews(news: newsService.headlines,),
    );
  }
}
