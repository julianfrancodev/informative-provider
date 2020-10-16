import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/CategoryModel.dart';
import 'package:news_provider/src/models/NewsModels.dart';

import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = '6610f55cc2774ebebe712963da2f0acc';

class NewsService with ChangeNotifier {

  bool _isLoading = true;

  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyballBall, "sports"),
    Category(FontAwesomeIcons.memory, "technology "),
  ];

  Map<String, List<Article>> categoryArticle = {};


  NewsService() {
    this.getTopHeadlines();
    categories.forEach((item) {
      this.categoryArticle[item.name] = List();
    });
  }

  List<Article> get getCategoryArticlesSelected =>
      this.categoryArticle[this._selectedCategory];

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String category) {
    this.getArticlesByCategory(category);
    this._isLoading = true;

    this._selectedCategory = category;
    notifyListeners();
  }

  getTopHeadlines() async {
    final url = "${_URL_NEWS}/top-headlines?apiKey=${_API_KEY}&country=co";

    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticle[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticle[category];
    }

    final url =
        "${_URL_NEWS}/top-headlines?apiKey=${_API_KEY}&country=co&category=${category}";

    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticle[category].addAll(newsResponse.articles);
    this._isLoading = false;

    notifyListeners();
  }
}
