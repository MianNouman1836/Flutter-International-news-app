import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:international_news_app/models/CategoriesNewsModel.dart';
import 'package:international_news_app/models/NewsChannelHeadlinesModel.dart';



class NewsRepository {

  Future<NewsChannelHeadlinesModel> fetchNewsHeadlinesApi (String channelName) async {

    String url = 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=f8841719a2ac4f57b417644f473d3185';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);

    }

    throw Exception('Error');

  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi (String category) async {

    String url = 'https://newsapi.org/v2/everything?q=$category&apiKey=f8841719a2ac4f57b417644f473d3185';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);

    }

    throw Exception('Error');

  }

}