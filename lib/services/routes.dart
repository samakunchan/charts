import 'package:charts/pages/cloud_words_page.dart';
import 'package:charts/pages/graph_page.dart';
import 'package:charts/pages/highlighter_page.dart';
import 'package:charts/pages/home_page.dart';
import 'package:charts/pages/keywords_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String graph = '/graph';
  static const String keywords = '/keywords';
  static const String highlighter = '/highlighter';
  static const String cloudWord = '/cloud-words';

  Route<dynamic> generateRoute(RouteSettings settings) {
    final List<String> parametrizedName =
        settings.name?.split('?') ?? <String>[];
    final name = (parametrizedName.isNotEmpty)
        ? parametrizedName[0]
        : settings.name ?? '';

    switch (name) {
      case home:
        return PageRouteBuilder<MyHomePage>(
          settings: settings,
          pageBuilder: (_, __, ___) => const MyHomePage(
            title: 'Expérience de graph',
          ),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case graph:
        return PageRouteBuilder<GraphPage>(
          settings: settings,
          pageBuilder: (_, __, ___) => const GraphPage(),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              ScaleTransition(scale: animation, child: child),
        );
      case keywords:
        return PageRouteBuilder<KeywordPage>(
          settings: settings,
          pageBuilder: (_, __, ___) => KeywordPage(),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(opacity: animation, child: child),
          //     SlideTransition(
          //       position: Tween<Offset>(
          //         begin: const Offset(-1.0, 0.0),
          //         end: Offset.zero,
          //       ).animate(animation),
          //   child: child,
          // ),
        );
      case highlighter:
        return PageRouteBuilder<HighlighterPage>(
          settings: settings,
          pageBuilder: (_, __, ___) => const HighlighterPage(),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      case cloudWord:
        return PageRouteBuilder<CloudWordPage>(
          settings: settings,
          pageBuilder: (_, __, ___) => const CloudWordPage(),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(opacity: animation, child: child),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
