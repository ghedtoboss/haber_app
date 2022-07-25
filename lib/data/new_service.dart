import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/articles.dart';
import '../models/news.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    String api =
        'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=0002834b74c04acd987883986ea38f96';

    final Uri url = Uri.parse(api);
    final response = await http.post(url);

    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
