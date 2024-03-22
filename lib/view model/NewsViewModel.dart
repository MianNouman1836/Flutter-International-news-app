

import 'package:international_news_app/models/CategoriesNewsModel.dart';
import 'package:international_news_app/models/NewsChannelHeadlinesModel.dart';
import 'package:international_news_app/respositries/NewsRepository.dart';

class NewsViewModel {

  final _repo = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsHeadlinesApi (String channelName) async {

    final response = await _repo.fetchNewsHeadlinesApi(channelName);
    return response;

  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi (String category) async {

    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;

  }

}