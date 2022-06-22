import 'dart:convert';

import 'package:charts/layout/layout.dart';
import 'package:charts/services/models/cloud_words/keywords_model.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class KeywordPage extends StatefulWidget {
  const KeywordPage({Key? key}) : super(key: key);

  @override
  State<KeywordPage> createState() => _KeywordPageState();
}

class _KeywordPageState extends State<KeywordPage> {
  late final Future<KeywordsModel>? myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = KeywordsModel.loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<KeywordsModel>(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<KeywordsModel> snapshot) {
        // snapshot.data?.result.keywords
        //     .where((e) => e.pos != 'VERB')
        //     .forEach((e) => print(encoder.convert(e)));

        // print('ALL: ${snapshot.data?.result.keywords
        //     .reduce((value, element) => Keyword(value: 'value', refValue: 'refValue', contexts: ['contexts'], score: (value.score + element.score), pos: 'pos')).score}');

        // print('VERB: ${snapshot.data?.result.keywords
        //     .where((e) => e.pos == 'VERB')
        //     .reduce((value, element) => Keyword(value: 'value', refValue: 'refValue', contexts: ['contexts'], score: (value.score + element.score), pos: 'pos')).score}');

        // print('PROPN: ${snapshot.data?.result.keywords
        //     .where((e) => e.pos == 'PROPN')
        //     .reduce((value, element) => Keyword(value: 'value', refValue: 'refValue', contexts: ['contexts'], score: (value.score + element.score), pos: 'pos')).score}');
        //
        // print('NOUN: ${snapshot.data?.result.keywords
        //     .where((e) => e.pos == 'NOUN')
        //     .reduce((value, element) => Keyword(value: 'value', refValue: 'refValue', contexts: ['contexts'], score: (value.score + element.score), pos: 'pos')).score}');
        //
        // print('ADJ: ${snapshot.data?.result.keywords
        //     .where((e) => e.pos == 'ADJ')
        //     .reduce((value, element) => Keyword(value: 'value', refValue: 'refValue', contexts: ['contexts'], score: (value.score + element.score), pos: 'pos')).score}');

        // final verbs = snapshot.data?.result.keywords.where((e) => (e.pos == 'VERB'));
        final Iterable<MapEntry<int, Keyword>>? verbs = snapshot.data?.result.keywords.asMap().entries.where((e) => e.value.pos == 'VERB');
        // print(snapshot.data?.result.toJson()['keywords']);

        final int? scoreVerbs = snapshot.data?.result.keywords
            .where((e) => e.pos == 'VERB')
            .reduce((value, element) => Keyword(value: 'value', refValue: 'refValue', contexts: ['contexts'], score: (value.score + element.score), pos: 'pos'))
            .score;
        return buildVerb(context, verbs, scoreVerbs);

        return LayoutState(
            content: SizedBox(
              width: 350,
              height: 350,
              child: charts.PieChart<Object>(
                  [
                    charts.Series<Map<String, dynamic>, int>(
                      id: 'VERB',
                      domainFn: (Map<String, dynamic> sales, _) => sales['yolo'] as int,
                      measureFn: (Map<String, dynamic> sales, _) => sales['test'] as int,
                      data: [
                        {'yolo' : 0, 'test': 50},
                        {'yolo' : 1, 'test': 50},
                      ],
                      // Set a label accessor to control the text of the arc label.
                      labelAccessorFn: (Map<String, dynamic> row, _) => 'test',
                    )
                  ],
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(arcWidth: 1000, arcRendererDecorators: [charts.ArcLabelDecorator()])
              ),
            )
        );
      },
    );

  }

  Widget buildVerb(BuildContext context, Iterable<MapEntry<int, Keyword>>? list, int? total) {
    return LayoutState(
        content: SizedBox(
          width: 550,
          height: 550,
          child: charts.PieChart<Object>(
              [
                charts.Series<Map<String, dynamic>, int>(
                  id: 'VERB',
                  domainFn: (Map<String, dynamic> domain, _) => domain['a'],
                  measureFn: (Map<String, dynamic> measure, _) => measure['b'],
                  data: list!.map((e) => {
                    'a': e.key,
                    'b': (e.value.score / total!) * 100,
                    'c': e.value.value
                  }).toList(),
                  labelAccessorFn: (Map<String, dynamic> row, _) => row['c'],
                )
              ],
              animate: true,
              defaultRenderer: charts.ArcRendererConfig(arcWidth: 350, arcRendererDecorators: [charts.ArcLabelDecorator()])
          ),
        )
    );
  }
}


class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
