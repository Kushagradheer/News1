import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/helper.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/view/newsTile_view.dart';

import 'categoryTile_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<NewsModel> newsArticle = [];

  bool _loading = true;

  void getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    newsArticle = newsClass.newsModel;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
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
                      //Categories
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 90,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return CategoryTiles(
                                  imgUrl: categories[index].imgUrl,
                                  categoryName: categories[index].categoryName,
                                );
                              }),
                        ),

                        //NEws Articles

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: ListView.builder(
                              itemCount: newsArticle.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return NewsTiles(
                                  urlToImage: newsArticle[index].urlToImage,
                                  title: newsArticle[index].title,
                                  description: newsArticle[index].description,
                                  url: newsArticle[index].url,
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

class CategoryTiles extends StatelessWidget {
  String imgUrl;
  String categoryName;

  CategoryTiles({@required this.imgUrl, @required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryTileView(
                      categoryNewsTitle: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CachedNetworkImage(
                imageUrl: imgUrl,
                width: 100,
                height: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      backgroundColor: Colors.black45,
                    ),
                  ),
                ],
              ),
            ],
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
