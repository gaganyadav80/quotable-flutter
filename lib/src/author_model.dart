import 'dart:convert';

import 'package:equatable/equatable.dart';

class Author extends Equatable {
  const Author({
    required this.id,
    required this.bio,
    required this.description,
    required this.link,
    required this.name,
    required this.slug,
    required this.quoteCount,
  });

  final String id;
  final String bio;
  final String description;
  final String link;
  final String name;
  final String slug;
  final int quoteCount;

  @override
  List<Object> get props {
    return [id, bio, description, link, name, slug, quoteCount];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'bio': bio,
      'description': description,
      'link': link,
      'name': name,
      'slug': slug,
      'quoteCount': quoteCount,
    };
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: (map['_id'] ?? '') as String,
      bio: (map['bio'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      link: (map['link'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      slug: (map['slug'] ?? '') as String,
      quoteCount: (map['quoteCount'] ?? '') as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) =>
      Author.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Authors(_id: $id, bio: $bio, description: $description, link: $link, name: $name, slug: $slug, quoteCount: $quoteCount)';
  }
}
