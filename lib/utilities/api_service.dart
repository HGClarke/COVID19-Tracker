class APIService {
  static const covidStatsHeaders = {
    "Subscription-Key": "36b106f0492a462bbb5d886135f70033",
    "Cache-Control": "no-cache"
  };
  static const newsURL =
      "https://newsapi.org/v2/top-headlines?q=coronavirus&sortBy=publishedAt&apiKey=8f98d1cbb7224ac59b3b0b05ef5f99d8&pageSize=20&country=us";
  static const baseDataURL = "https://api.smartable.ai/coronavirus/stats/";
}
