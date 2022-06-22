import 'dart:convert';

import 'package:flutter/services.dart';

class KeywordsModel {
  const KeywordsModel({
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

  factory KeywordsModel.fromJson(Map<String, dynamic> json) {
    return KeywordsModel(
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

  static Future<KeywordsModel> loadJson() async {
    final contents = await rootBundle.loadString(
      'examples/keywords.json',
    );
    return KeywordsModel.fromJson(jsonDecode(contents) as Map<String, dynamic>);
  }
}

class Result {
  Result({required this.keywords});
  List<Keyword> keywords;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        keywords: (json['keywords'] as List)
            .map((keyword) => Keyword.fromJson(keyword))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'keywords': keywords,
    };
  }
}

class Keyword {
  const Keyword({
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

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(
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
