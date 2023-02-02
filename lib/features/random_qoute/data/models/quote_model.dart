// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import 'dart:convert';

import 'package:quotes_app/features/random_qoute/domain/entities/quote.dart';

QuoteModel quoteFromJson(String str) => QuoteModel.fromJson(json.decode(str));

String quoteToJson(QuoteModel data) => json.encode(data.toJson());

class QuoteModel extends Quote {
  const QuoteModel({
    required String id,
    required String author,
    required String content,
  }) : super(
          author: author,
          id: id,
          content: content,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json["_id"],
        author: json["author"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author,
        "content": content,
      };
}
