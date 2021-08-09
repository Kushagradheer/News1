import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<NewsModel> newsModel = [];

  String url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=049723ac33dc41098cd6e9ea48f385b8";

  Future<void> getNews() async {
    http.Response response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['content'] != null) {
          NewsModel news123 = NewsModel(
              title: element['title'],
              author: element['source']['name'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              url: element['url'],
              content: element['content']);
          newsModel.add(news123);
        }
      });
    }
  }
}

class CategorizedNews {
  List<NewsModel> newsModel = [];

  Future<void> getNews(String categoryNewsAPI) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$categoryNewsAPI&apiKey=049723ac33dc41098cd6e9ea48f385b8";

    http.Response response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['content'] != null) {
          NewsModel news123 = NewsModel(
              title: element['title'],
              author: element['source']['name'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              url: element['url'],
              content: element['content']);
          newsModel.add(news123);
        }
      });
    }
  }
}
