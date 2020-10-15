import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/Tabs1Page.dart';
import 'package:news_provider/src/services/NewsService.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _BottomNav(),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);
    final newsService = Provider.of<NewsService>(context);

    return BottomNavigationBar(
        currentIndex: navigationModel.currentPage,
        onTap: (i) => navigationModel.currentPage = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Para ti"),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: "Encabezados")
        ]
    );
  }
}


class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tabs1Page(),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get currentPage => this._currentPage;

  set currentPage(int page) {
    this._currentPage = page;
    _pageController.animateToPage(
        page, duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}







