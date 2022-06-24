import 'dart:collection';
import 'dart:convert';

import 'package:charts/layout/layout.dart';
import 'package:charts/services/models/cloud_words/keywords_model.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class KeywordPage extends StatefulWidget {
  const KeywordPage({Key? key}) : super(key: key);

  @override
  State<KeywordPage> createState() => _KeywordPageState();
}

class _KeywordPageState extends State<KeywordPage> {
  late final Future<AppKeywordsModel>? myFuture;
  String select = 'ALL';

  @override
  void initState() {
    super.initState();
    print(select);
    myFuture = AppKeywordsModel.loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppKeywordsModel>(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<AppKeywordsModel> snapshot) {
        if(snapshot.hasData && snapshot.data != null) {

          List<KeywordModel>? keywords = snapshot.data?.result.keywords;
          keywords?.sort((a, b) => b.score.compareTo(a.score));
          // print(keywords?.asMap().values.map((e) => e.score));

          final int? scoreVerbs = snapshot.data?.result.keywords
              .where((e) => e.pos == 'VERB')
              .map((e) => e.score)
              .reduce((value, element) => value + element);

          return buildKeywords(context, keywords, scoreVerbs);
        } else {
          return const LayoutState(
            content: Center(
              child: Text('...'),
            ),
          );
        }
      },
    );
  }

  Widget buildKeywords(BuildContext context, List<KeywordModel>? arr, int? total) {
    var list = arr!.asMap().entries;
    print(list.take(20).where((element) => element.value.value == 'France').first.value.value);
    return LayoutState(
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 150,
              child: DropdownButtonFormField(
                value: 'ALL',
                elevation: 16,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(value: 'ALL', child: Text('Tous'),),
                  DropdownMenuItem(value: 'VERB', child: Text('Verbes'),),
                  DropdownMenuItem(value: 'NOUN', child: Text('Nom propre'),),
                  DropdownMenuItem(value: 'PROPN', child: Text('Nom communs'),),
                  DropdownMenuItem(value: 'ADJ', child: Text('Adjectifs'),),
                ],
                onChanged: (value) {
                  setState(() {
                    select = value.toString();
                  });
                }
              ),
            ),
            const SizedBox(height: 50,),
            select == 'ADJ' ?
            Column(
              children: [
                const Text('Adjectifs'),
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: charts.PieChart<Object>(
                      [
                        charts.Series<PartModel, int>(
                          id: 'ADJ',
                          domainFn: (PartModel domain, _) => domain.index,
                          measureFn: (PartModel measure, _) => measure.percent,
                          data: list
                              .where((e) => e.value.pos == 'ADJ')
                              .map((e) => PartModel(index: e.key, percent: (e.value.score / geTotal(list, 'ADJ')!) * 100, text: e.value.value))
                              .toList(),
                          labelAccessorFn: (PartModel row, _) => row.text,
                        )
                      ],
                      animate: true,
                      behaviors: [
                        charts.DatumLegend(
                          // desiredMaxRows: 10,
                          position: charts.BehaviorPosition.end,
                          horizontalFirst: false,
                          cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                          showMeasures: false,
                          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
                          // measureFormatter: (num? value) {
                          //   return (value == null && value! >= 4) ? '-' : '${value?.round()}%';
                          // },
                        )
                      ],
                      defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 350,
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.outside,
                            )
                          ]
                      )
                  ),
                ),
              ]
            ):
            select == 'VERB' ?
            Column(
              children: [
                const Text('Verbes'),
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: charts.PieChart<Object>(
                      [
                        charts.Series<PartModel, int>(
                          id: 'VERB',
                          domainFn: (PartModel domain, _) => domain.index,
                          measureFn: (PartModel measure, _) => measure.percent,
                          data: list
                              .where((e) => e.value.pos == 'VERB')
                              .map((e) => PartModel(index: e.key, percent: (e.value.score / geTotal(list, 'VERB')!) * 100, text: e.value.value))
                              .toList(),
                          labelAccessorFn: (PartModel row, _) => row.text,
                        )
                      ],
                      animate: true,
                      defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 350,
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside,
                            ),
                            charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.outside,
                            ),
                          ]
                      )
                  ),
                ),
              ],
            ):
            select == 'NOUN' ?
            Column(
              children: [
                const Text('Nom commun'),
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: charts.PieChart<Object>(
                      [
                        charts.Series<PartModel, int>(
                          id: 'NOUN',
                          domainFn: (PartModel domain, _) => domain.index,
                          measureFn: (PartModel measure, _) => measure.percent,
                          data: list
                              .where((e) => e.value.pos == 'NOUN')
                              .map((e) => PartModel(index: e.key, percent: (e.value.score / geTotal(list, 'NOUN')!) * 100, text: e.value.value))
                              .toList(),
                          labelAccessorFn: (PartModel row, _) => row.text,
                        )
                      ],
                      animate: true,
                      defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 350,
                          arcRendererDecorators: [charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.outside,
                          )]
                      )
                  ),
                ),
              ],
            ):
            select == 'PROPN' ?
            Column(
              children: [
                const Text('Nom propre'),
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: charts.PieChart<Object>(
                      [
                        charts.Series<PartModel, int>(
                          id: 'PROPN',
                          domainFn: (PartModel domain, _) => domain.index,
                          measureFn: (PartModel measure, _) => measure.percent,
                          data: list
                              .where((e) => e.value.pos == 'PROPN')
                              .map((e) => PartModel(index: e.key, percent: (e.value.score / geTotal(list, 'PROPN')!) * 100, text: e.value.value))
                              .toList(),
                          labelAccessorFn: (PartModel row, _) => row.text,
                        )
                      ],
                      animate: true,
                      defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 350,
                          arcRendererDecorators: [charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.outside,
                          )]
                      )
                  ),
                ),
              ],
            ):
            Column(
              children: [
                const Text('Tous'),
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: charts.PieChart<Object>(
                      [
                        charts.Series<PartModel, int>(
                          id: 'ALL',
                          domainFn: (PartModel domain, _) => domain.index,
                          measureFn: (PartModel measure, _) => measure.percent,
                          data: list
                              .take(20)
                              .map((e) => PartModel(index: e.key, percent: (e.value.score / geTotal(list, 'ALL')!) * 100, text: e.value.value))
                              .toList(),
                          labelAccessorFn: (PartModel row, _) => row.text,
                          outsideLabelStyleAccessorFn: (PartModel sales, _) {
                            return charts.TextStyleSpec(color: charts.MaterialPalette.red.shadeDefault);
                          },
                        )
                      ],
                      animate: true,
                      defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 350,
                          arcRendererDecorators: [charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.outside,
                          )]
                      )
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );

  }

  int? geTotal( Iterable<MapEntry<int, KeywordModel>>? list, String pos) {
    return pos == 'ALL' ?
    list
        ?.where((e) => e.value.score >= 20)
        .map((e) => e.value.score)
        .reduce((value, element) => value + element):
    list
        ?.where((e) => e.value.pos == pos)
        .map((e) => e.value.score)
        .reduce((value, element) => value + element);
  }

}


class PartModel {
  final int index;
  final double percent;
  final String text;

  PartModel({required this.index, required this.percent, required this.text});

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(index: json['index'], percent: json['ee'], text: json['text']);
  }
}
