import 'package:charts/layout/layout.dart';
import 'package:flutter/material.dart';

class HighlighterPage extends StatelessWidget {
  const HighlighterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LayoutState(
        content: Text(
      'Highlighter',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ));
  }
}
