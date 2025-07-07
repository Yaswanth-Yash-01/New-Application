import 'dart:convert';

import 'package:blocnews/models/article_model.dart';

import 'package:http/http.dart' as http;

class NewsRepository {
  Future<List<ArticleModel>> fetchNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=b450f9e6c7424f5180f75e42451def8e"));

    var data = jsonDecode(response.body);

    List<ArticleModel> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        ArticleModel _artcileModel = ArticleModel.fromJson(item);
        _articleModelList.add(_artcileModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList; // empty list
    }
  }
}
