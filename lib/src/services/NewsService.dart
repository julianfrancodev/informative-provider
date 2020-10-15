import 'package:flutter/material.dart';
import 'package:news_provider/src/models/NewsModels.dart';

import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = '6610f55cc2774ebebe712963da2f0acc';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async{
    final url =
        "${_URL_NEWS}/top-headlines?apiKey=${_API_KEY}&country=co";

    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
