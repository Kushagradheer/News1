import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/news_model.dart';
import 'newsTile_view.dart';

class CategoryTileView extends StatefulWidget {
  final String categoryNewsTitle;
  CategoryTileView({this.categoryNewsTitle});

  @override
  _CategoryTileViewState createState() => _CategoryTileViewState();
}

class _CategoryTileViewState extends State<CategoryTileView> {
  List<NewsModel> categorizedNewsArticle = [];

  bool _loading = true;

  void getCategoryNews() async {
    CategorizedNews categorizedNews = CategorizedNews();
    await categorizedNews.getNews(widget.categoryNewsTitle);
    categorizedNewsArticle = categorizedNews.newsModel;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("NewsApp Flutter"),
          foregroundColor: Colors.lightBlue[150],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        //NEws Articles
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: ListView.builder(
                              itemCount: categorizedNewsArticle.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return NewsTiles(
                                  urlToImage:
                                      categorizedNewsArticle[index].urlToImage,
                                  title: categorizedNewsArticle[index].title,
                                  description:
                                      categorizedNewsArticle[index].description,
                                  url: categorizedNewsArticle[index].url,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class NewsTiles extends StatelessWidget {
  final String title, description, urlToImage, url;

  NewsTiles(
      {@required this.title,
      @required this.description,
      @required this.urlToImage,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsTileView(
              webViewNewsUrl: url,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Image.network(urlToImage),
            Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
