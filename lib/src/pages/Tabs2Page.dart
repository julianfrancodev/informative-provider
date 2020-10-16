import 'package:flutter/material.dart';
import 'package:news_provider/src/models/CategoryModel.dart';
import 'package:news_provider/src/services/NewsService.dart';
import 'package:news_provider/src/widgets/ListNews.dart';
import 'package:provider/provider.dart';

class Tabs2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListCategories(),
            (newsService.isLoading)
                ? Expanded(
                    child: ListNews(
                    news: newsService.getCategoryArticlesSelected,
                  ))
                : Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
          ],
        ),
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final categoryName = categories[index].name;
          return Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(category: categories[index]),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '${categoryName[0].toUpperCase()}${categoryName.substring(1)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  _CategoryButton({@required this.category});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? Colors.red
              : Colors.black45,
        ),
      ),
    );
  }
}
