<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This package (unofficial) uses a free and opensource quotation API called [Quotable](https://github.com/lukePeavey/quotable).

## Features

Get a random quote, list of quotes or search them as query by quotes and authors. You can also use tags to filter quotes and sort or order them as per the parameters.

<img width="230" alt="Screenshot 2022-06-27 at 19 20 52" src="https://user-images.githubusercontent.com/47142137/176159935-c2a8b6ba-c607-4bd8-aecd-1fc3ba44c2e1.png">

## Getting started

- Quote Model
```dart
Quote({
    String id,
    String content,
    String author,
    int length,
    List<String> tags,
});
```

- Author Model
```dart
Author({
    String id,
    String bio,
    String description,
    String link,
    String name,
    String slug,
    int quoteCount,
});
```

- Get Quotes from Quotable Repository
```dart
Future<Quote> Quotable.getRandom({
    List<String>? tags, 
    int? maxLength, 
    int? minLength,
});

Future<List<Quote>> Quotable.getListQuotes({
    List<String>? tags,
    List<String>? authors,
    SortBy sortBy = SortBy.dateAdded,
    Order order = Order.desc,
    int page = 1,
    int limit = 20,
})

Future<List<Quote>> Quotable.searchQuotes({
    required String query,
    int page = 1,
    int limit = 20,
})

Future<List<Author>> Quotable.searchAuthor({
    required String query,
    int page = 1,
    int limit = 20,
})
```

If you are confused about `page` and `limit` or how they work together then read [this](https://github.com/lukePeavey/quotable#list-quotes) table.

## Usage

```dart
// get random - Quote()
void main() async {
    Quote quoteRamdon = await Quotable.getRandom();
    List<Quote> listQuotes = await Quotable.getListQuotes(limit: 5);
    List<Quote> queryQuote = await Quotable.searchQuotes(query: 'wisdom', limit: 5);
    List<Author> queryAuthor = await Quotable.searchAuthor(query: 'einstein');
}
```

## Additional information

If you find any issues or want to contribute then please feel free to open an issues or a discussion [here](https://github.com/gaganyadav80/quotable-flutter/)
