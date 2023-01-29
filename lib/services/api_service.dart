import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_api_app/model/article_model.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<List<Article>> getArticle(int index) async {
    DateTime dateToday = new DateTime.now();
    String date = dateToday.toString().substring(0, 10);

    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
    };
    final queryParameters2 = {
      'q': 'education',
      'from': date,
      'sortBy': 'popularity',
      'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
    };

    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final uri2 = Uri.https(endPointUrl, "/v2/everything", queryParameters2);

    final links = {
      'url0': Uri.https(endPointUrl, "/v2/top-headlines", {
        'country': 'us',
        'from': date,
        'sortBy': 'popularity',
        'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
      }),
      'url1': Uri.https(endPointUrl, "/v2/everything", {
        'q':'technology',
        'from': date,
        'sortBy': 'popularity',
        'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
      }),
      'url2': Uri.https(endPointUrl, "/v2/everything", {
        'q':'weather',
        'from': date,
        'sortBy': 'popularity',
        'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
      }),
      'url3': Uri.https(endPointUrl, "/v2/everything", {
        'q':'education',
        'from': date,
        'sortBy': 'popularity',
        'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
      }),
      'url4': Uri.https(endPointUrl, "/v2/everything", {
        'q':'art',
        'from': date,
        'sortBy': 'popularity',
        'apiKey': 'e02f1b6629a64ef3b3a3c57000b01848'
      }),
    };

    final link = 'url' + index.toString();
    //print(links[link]);

    final response = await client.get(links[link]);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
