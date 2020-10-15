import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/TabsPage.dart';
import 'package:news_provider/src/services/NewsService.dart';
import 'package:news_provider/src/theme/DarkTheme.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewsService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
        theme: darkTheme,
      ),
    )
  );
}