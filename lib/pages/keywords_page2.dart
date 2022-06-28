
import 'package:charts/layout/layout.dart';
import 'package:charts/services/models/keywords/keywords_model.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class KeywordPage2 extends StatefulWidget {
  const KeywordPage2({Key? key}) : super(key: key);

  @override
  State<KeywordPage2> createState() => _KeywordPageState();
}

class _KeywordPageState extends State<KeywordPage2> {
  late final Future<AppKeywordsModel>? myFuture;
  String select = 'ALL';

  @override
  void initState() {
    super.initState();
    // print(select);
    myFuture = AppKeywordsModel.loadJson();
  }
  @override
  Widget build(BuildContext context) {
    // return _buildDefaultPieChart();

    return FutureBuilder<AppKeywordsModel>(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<AppKeywordsModel> snapshot) {
        if(snapshot.hasData && snapshot.data != null) {
          
          List<KeywordModel>? keywords = snapshot.data?.result.keywords
              .where((element) => element.pos != 'PUNCT')
              .toList();
          keywords?.sort((a, b) => b.score.compareTo(a.score));

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
                    Padding(padding: const EdgeInsets.only(top: 100), child: _buildDefaultPieChart(keywords, 'ADJ'),):
                    select == 'VERB' ?
                    Padding(padding: const EdgeInsets.only(top: 100), child: _buildDefaultPieChart(keywords, 'VERB'),):
                    select == 'NOUN' ?
                    Padding(padding: const EdgeInsets.only(top: 100), child: _buildDefaultPieChart(keywords, 'NOUN'),):
                    select == 'PROPN' ?
                    Padding(padding: const EdgeInsets.only(top: 100), child: _buildDefaultPieChart(keywords, 'PROPN'),):
                    Padding(padding: const EdgeInsets.only(top: 100), child: _buildDefaultPieChart(keywords, 'ALL'),)
                  ],
                ),
              )
          );
        } else {
          return const LayoutState(
            content: Center(
              child: Text('...'),
            )
          );
        }
      },
    );
  }

  /// Returns the circular  chart with pie series.
  SfCircularChart _buildDefaultPieChart(List<KeywordModel>? keywords, String filter) {
    return SfCircularChart(
      series: _getDefaultPieSeries(keywords, filter),
      legend: Legend(
        isVisible: true,
        // position: LegendPosition.right,
        // alignment: ChartAlignment.near,
        title: LegendTitle(text: 'Légende', textStyle: const TextStyle(fontSize: 20))
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        // format: 'point.y',
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
          return Padding(
            padding: const EdgeInsets.all(10),
              child: Text(
                'Mot-clé: ${data.x} \nLu: ${data.secondSeriesYValue} fois \nType: ${data.thirdSeriesYValue}',
                style: const TextStyle(color: Colors.white),
              )
          );
        }
      ),
    );
  }

  /// Returns the pie series.
  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries(List<KeywordModel>? keywords, String filter) {
    var list = keywords!;
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          explode: true,
          radius: '150%',
          explodeOffset: '10%',
          animationDuration: 500,
          pointRenderMode: PointRenderMode.segment,
          dataSource: filter == 'ALL' ?
            list
              .take(20)
              .map((e) => ChartSampleData(
                x: e.value,
                y: e.score,
                text: e.value,
                secondSeriesYValue: e.contexts.length,
                thirdSeriesYValue: e.pos
              )
            ).toList()
              :
            list
              .where((element) => element.pos == filter)
              .take(20)
              .map((e) => ChartSampleData(
                x: e.value,
                y: e.score,
                text: e.value
              )
            ).toList(),
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            showCumulativeValues: true,
            labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings: ConnectorLineSettings(type: ConnectorType.curve, length: '15%'),
          )
      ),
    ];
  }


}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
        this.y,
        this.xValue,
        this.yValue,
        this.secondSeriesYValue,
        this.thirdSeriesYValue,
        this.pointColor,
        this.size,
        this.text,
        this.open,
        this.close,
        this.low,
        this.high,
        this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final String? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}