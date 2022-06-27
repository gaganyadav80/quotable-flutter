import 'dart:convert';

import 'package:http/http.dart' as http;

import 'author_model.dart';
import 'enums.dart';
import 'quote_model.dart';

class Quotable {
  static const String _baseUrl = 'https://api.quotable.io';
  static const String _random = '/random';
  static const String _quotes = '/quotes';
  static const String _searchAuthors = '/search/authors?query=';
  static const String _searchQuotes = '/search/quotes?query=';

  static Future<Quote> getRandom({
    List<String>? tags,
    int? maxLength,
    int? minLength,
  }) async {
    var url = '$_baseUrl$_random';
    if (tags != null) {
      url += '?tags=${tags.join(',')}';
    }
    if (maxLength != null) {
      if (tags != null) {
        url += '&';
      } else {
        url += '?';
      }
      url += 'max_length=$maxLength';
    }
    if (minLength != null) {
      if (tags != null || maxLength != null) {
        url += '&';
      } else {
        url += '?';
      }
      url += '&min_length=$minLength';
    }

    final response = await http.get(Uri.parse(url));
    return Quote.fromJson(response.body);
  }

  static Future<List<Quote>> getListQuotes({
    List<String>? tags,
    List<String>? authors,
    SortBy sortBy = SortBy.dateAdded,
    Order order = Order.desc,
    int page = 1,
    int limit = 20,
  }) async {
    assert(limit > 0 && limit <= 150, 'Limit must be between 1 and 150');

    var url = '$_baseUrl$_quotes';

    if (tags != null) {
      url += '?tags=${tags.join(',')}';
    }
    if (authors != null) {
      if (tags != null) {
        url += '&';
      } else {
        url += '?';
      }
      url += 'authors=${authors.join(',')}';
    }
    if (tags != null || authors != null) {
      url += '&';
    } else {
      url += '?';
    }
    url += 'sort_by=$sortBy';
    url += '&order=$order';
    url += '&page=$page';
    url += '&limit=$limit';

    final response = await http.get(Uri.parse(url));
    final quotes = List<Map<String, dynamic>>.from(
      (json.decode(response.body) as Map<String, dynamic>)['results'] as List,
    ).map(Quote.fromMap).toList();

    return quotes;
  }

  static Future<List<Quote>> searchQuotes({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    assert(limit > 0 && limit <= 150, 'Limit must be between 1 and 150');

    var url = '$_baseUrl$_searchQuotes$query';
    url += '&page=$page';
    url += '&limit=$limit';

    final response = await http.get(Uri.parse(url));
    final quotes = List<Map<String, dynamic>>.from(
      (json.decode(response.body) as Map<String, dynamic>)['results'] as List,
    ).map(Quote.fromMap).toList();

    return quotes;
  }

  static Future<List<Author>> searchAuthor({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    assert(limit > 0 && limit <= 150, 'Limit must be between 1 and 150');

    var url = '$_baseUrl$_searchAuthors$query';
    url += '&page=$page';
    url += '&limit=$limit';

    final response = await http.get(Uri.parse(url));
    final authors = List<Map<String, dynamic>>.from(
      (json.decode(response.body) as Map<String, dynamic>)['results'] as List,
    ).map(Author.fromMap).toList();

    return authors;
  }
}
