import 'dart:convert';
import 'package:covid19_tracker/utilities/app_colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:covid19_tracker/models/covid_news.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  COVIDNews news;
  Future<void> _fetchNewsAPI() async {
    final networkService = NetworkService(APIService.newsURL, {});
    final response = await networkService.fetchData();
    if (response.statusCode == 200) {
      setState(() {
        news = COVIDNews.fromJson(jsonDecode(response.body));
      });
    }
  }

  @override
  void initState() {
    _fetchNewsAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'News',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: news == null
          ? Center(
              child: SpinKitFadingFour(
                color: AppColors.teal,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, index) {
                  final article = news.articles[index];
                  String formattedDate = DateFormat("dd MMM yyyy").format(
                    DateTime.parse(article.publishedAt ?? ""),
                  );
                  return Column(
                    children: <Widget>[
                      Divider(color: Colors.white),
                      GestureDetector(
                        onTap: () async {
                          // if (article.url == null) {
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Image.network(
                                  article.urlToImage ?? "",
                                  // height: 150,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${article.title}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${article.author ?? ""}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                    ),
                                    Text(
                                      '$formattedDate',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
