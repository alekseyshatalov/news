import 'dart:convert';

import 'package:news/data/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:news/utils/constants.dart';

enum Endpoints {
  all,
  hot,
}

class ArticlesRepository {
  static Future<List<Article>> loadHot(int page) async =>
      _load(Endpoints.hot, page);

  static Future<List<Article>> loadAll(int page) async =>
      _load(Endpoints.all, page);

  static Future<List<Article>> _load(Endpoints type, int page) async {
    List<Article> result = [];
    String endpoint = type == Endpoints.all ? 'everything' : 'top-headlines';

    http.Response response = await http.get(
      Uri.parse(
        '$apiUrl$endpoint?q=google&apiKey=$apiKey&pageSize=$pageSize&page=$page',
      ),
    );

    try {
      dynamic articles = jsonDecode(response.body)['articles'];
      for (dynamic article in articles) {
        result.add(
          Article(
            article['url'],
            article['urlToImage'],
            article['title'],
            article['description'],
            article['content'],
          ),
        );
      }
    } catch (_) {
      return result;
    }

    return result;
  }
}
