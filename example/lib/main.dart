import 'package:flutter/material.dart';
import 'package:quotable/quotable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuotableDemo(),
    );
  }
}

class QuotableDemo extends StatelessWidget {
  const QuotableDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quotable Demo')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Get Random Quote',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              FutureBuilder<Quote>(
                future: Quotable.getRandom(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    Quote quote = snapshot.data!;

                    return ListTile(
                      title: Text(quote.author),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('quote: ${quote.content}'),
                          Text('tags: ${quote.tags.toString()}'),
                          Text('id: ${quote.id}'),
                        ],
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Get List of Quotes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              FutureBuilder<List<Quote>>(
                future: Quotable.getListQuotes(limit: 2),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    List<Quote> quotes = snapshot.data!;

                    return ListView.separated(
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemCount: quotes.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        Quote quote = quotes[index];
                        return ListTile(
                          title: Text(quote.author),
                          subtitle: Text(quote.content),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Search Quotes ('wisdom')",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              FutureBuilder<List<Quote>>(
                future: Quotable.searchQuotes(query: 'wisdom', limit: 3),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    List<Quote> quotes = snapshot.data!;

                    return ListView.separated(
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemCount: quotes.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        Quote quote = quotes[index];
                        return ListTile(
                          title: Text(quote.author),
                          subtitle: Text(quote.content),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Search Authors ('einstein')",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              FutureBuilder<List<Author>>(
                future: Quotable.searchAuthor(query: 'einstein', limit: 3),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    List<Author> authors = snapshot.data!;

                    return ListView.separated(
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemCount: authors.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        Author author = authors[index];
                        return ListTile(
                          leading: IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () => print(author.link),
                          ),
                          title: Text(author.name),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('- ${author.description}'),
                              Text('- ${author.bio}'),
                              Text('- ${author.slug}'),
                              Text('- ${author.quoteCount.toString()}'),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
