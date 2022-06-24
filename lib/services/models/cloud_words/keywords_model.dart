import 'dart:convert';

import 'package:flutter/services.dart';

class AppKeywordsModel {
  const AppKeywordsModel({
    required this.message,
    required this.code,
    required this.startTime,
    required this.endTime,
    required this.result,
  });

  final String message;
  final int code;
  final int startTime;
  final int endTime;
  final Result result;

  factory AppKeywordsModel.fromJson(Map<String, dynamic> json) {
    return AppKeywordsModel(
        message: json['message'],
        code: json['code'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        result: Result.fromJson(json['result'])
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'startTime': startTime,
      'endTime': endTime,
      'result': result,
    };
  }

  static Future<AppKeywordsModel> loadJson() async {
    final contents = await rootBundle.loadString(
      'examples/keywords.json',
    );
    // print((jsonDecode(contents) as Map<String, dynamic>).keys);
    // print((jsonDecode(contents) as Map<String, dynamic>).values);
    return AppKeywordsModel.fromJson(jsonDecode(contents) as Map<String, dynamic>);
  }
}

class Result {
  Result({required this.keywords});
  List<KeywordModel> keywords;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        keywords: (json['keywords'] as List)
            .map((keyword) => KeywordModel.fromJson(keyword))
            .toList()
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'keywords': keywords,
    };
  }
}

class KeywordModel {
  const KeywordModel({
    required this.value,
    required this.refValue,
    required this.contexts,
    required this.score,
    required this.pos,
  });
  
  final String value;
  final String refValue;
  final List<dynamic> contexts;
  final int score;
  final String pos;

  factory KeywordModel.fromJson(Map<String, dynamic> json) {
    return KeywordModel(
      value: json['value'],
      refValue: json['refValue'],
      contexts: json['contexts'],
      score: json['score'],
      pos: json['pos'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'value': value,
      'refValue': refValue,
      'contexts': contexts,
      'score': score,
      'pos': pos,
    };
  }
}
