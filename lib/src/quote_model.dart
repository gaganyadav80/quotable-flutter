// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  const Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.length,
    required this.tags,
  });

  final String id;
  final String content;
  final String author;
  final int length;
  final List<String> tags;

  @override
  String toString() {
    return 'DailyQuotes(_id: $id, content: $content, author: $author, length: $length, tags: $tags)';
  }

  @override
  List<Object> get props {
    return [id, content, author, length, tags];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'content': content,
      'author': author,
      'length': length,
      'tags': tags,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: (map['_id'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      author: (map['author'] ?? '') as String,
      length: (map['length'] ?? '') as int,
      tags: List<String>.from(map['tags'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) =>
      Quote.fromMap(json.decode(source) as Map<String, dynamic>);
}
