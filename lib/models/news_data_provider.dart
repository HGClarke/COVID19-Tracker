import 'package:covid19_tracker/models/covid_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsProvider extends ChangeNotifier {
  COVIDNews _news;

  bool get hasData => _news != null;

  static NewsProvider of(context, {listen: false}) {
    return Provider.of<NewsProvider>(context, listen: listen);
  }

  void setNews(COVIDNews news) {
    _news = news;
    notifyListeners();
  }

  void resetNews() {
    _news = null;
    notifyListeners();
  }
}
