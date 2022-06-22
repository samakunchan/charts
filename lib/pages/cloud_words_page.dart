
import 'package:charts/layout/layout.dart';
import 'package:charts/services/models/cloud_words/cloud_words_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';

class CloudWordPage extends StatefulWidget {
  const CloudWordPage({Key? key}) : super(key: key);

  @override
  State<CloudWordPage> createState() => _CloudWordPageState();
}

class _CloudWordPageState extends State<CloudWordPage> {
  late final Future<CloudWordModel>? myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = CloudWordModel.loadCloudWordsJson();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];

    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return FutureBuilder<CloudWordModel>(
      future: myFuture,
        builder: (BuildContext builder, AsyncSnapshot<CloudWordModel> snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            var concepts = snapshot.data?.result.concepts as List<Concept>;

            for (var i = 0; i < concepts.length; i++) {
               if (concepts[i].score > 2) {
                widgets.add(ScatterItem(content: concepts[i], index: i));
              }
            }
            return LayoutState(
              content: Center(
                child: FittedBox(
                  child: Scatter(
                    fillGaps: true,
                    delegate: ArchimedeanSpiralScatterDelegate(ratio: ratio),
                    children: widgets,
                  ),
                ),
              ),
            );
          } else {
            return const LayoutState(
              content: Center(
                child: Text('R'),
              ),
            );
          }
        }
    );
  }
}

class ScatterItem extends StatelessWidget {
  const ScatterItem({Key? key, required this.content, required this.index})
      : super(key: key);
  final Concept content;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
      content.value,
      style: TextStyle(
        fontSize: content.score.toDouble() * 5,
        color: content.score > 13 ?
        Colors.yellow :
        content.score > 10 ?
        Colors.green :
        content.score > 7 ?
        Colors.purple :
        content.score > 5 ?
        Colors.black :
        Colors.blue,
      ),
    );
  }
}
