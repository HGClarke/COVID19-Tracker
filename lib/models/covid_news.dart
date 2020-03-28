class COVIDNews {
  int totalResults;
  List<Article> articles;

  COVIDNews({this.totalResults, this.articles});

  COVIDNews.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = List<Article>();
      json['articles'].forEach((v) {
        articles.add(Article.fromJson(v));
      });
    }
  }
}

class Article {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;

  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  });

  Article.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
  }
}
