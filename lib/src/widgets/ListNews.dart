import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:news_provider/src/models/NewsModels.dart';
import 'package:news_provider/src/theme/DarkTheme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;

  ListNews({this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, i) {
        return _New(article: news[i], index: i);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article article;
  final int index;

  _New({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTop(
          article: article,
          index: index,
        ),
        _CardTitle(
          article: article,
        ),
        _CardImage(article: article),
        _CardBody(article: article),

        _CardButtons(),

        SizedBox(height: 10,),
        Divider(),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            fillColor: darkTheme.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: (){},
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 20,),
          RawMaterialButton(
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: (){},
            child: Icon(Icons.more),
          ),

        ],
      ),
    );
  }
}


class _CardBody extends StatelessWidget {

  final Article article;

  _CardBody({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((article.description != null) ? article.description : ""),
    );
  }
}


class _CardImage extends StatelessWidget {
  final Article article;

  _CardImage({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (article.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/images/giphy.gif'),
                  image: NetworkImage(article.urlToImage),
                )
              : Image(
                  image: AssetImage('assets/images/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _CardTop extends StatelessWidget {
  final Article article;
  final int index;

  _CardTop({@required this.article, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "${index + 1}",
            style: TextStyle(color: darkTheme.accentColor),
          ),
          Text(
            "${article.source.name}",
            style: TextStyle(color: darkTheme.accentColor),
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article article;

  _CardTitle({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
