import 'package:charts/services/routes.dart';
import 'package:flutter/material.dart';

class LayoutState extends StatelessWidget {
  const LayoutState({Key? key, required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expérience de graphique'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.home),
                      child: const Text('Home')),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.graph),
                      child: const Text('Graphique')),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.keywords),
                      child: const Text('Mot clés')),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.highlighter),
                      child: const Text('Surligneur')),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.cloudWord),
                      child: const Text('Nuage de mots')),
                ],
              ),
            ),
            Expanded(
              child: content
            )
          ],
        ),
      ),
    );
  }
}
