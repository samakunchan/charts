import 'package:charts/pages/cloud_words_page.dart';
import 'package:charts/pages/graph_page.dart';
import 'package:charts/pages/highlighter_page.dart';
import 'package:charts/pages/home_page.dart';
import 'package:charts/pages/keywords_page.dart';
import 'package:charts/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routes().generateRoute,
      // routes: {
      //   '/keywords': (context) => const KeywordPage(),
      //   '/cloud-words': (context) => const CloudWordPage(),
      //   '/highlighter': (context) => const HighlighterPage(),
      //   '/graph': (context) => const GraphPage(),
      //   '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      // },
      // initialRoute: '/',
    );
  }
}
