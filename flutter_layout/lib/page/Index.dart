import 'dart:_http';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:flutter_layout/Urls/Article.dart';
import 'package:flutter_layout/Urls/Urls.dart';
import 'package:flutter_layout/page/NewsPage.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>new IndexState();

}
class IndexState extends State<Index> {
  List<Article> list = [];
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);
  var page=0;
  var img = [
    'images/da.jpg',
    'images/DVa.jpg',
    'images/lk.jpg',
    'images/sw.jpg',
    'images/t.jpg',
    'images/ts.jpg',
  ];
  ScrollController _controller = new ScrollController();
  IndexState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && list.length < 20) {
        // scroll to bottom, get next page data
        print("load more ... ");
        page++;
        getNewList();
      }
    });
  }
  @override
  void initState() {
    super.initState();
    getNewList();
  }
  @override
  Widget build(BuildContext context) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        new Container(
          alignment: Alignment.center,
          height: 180.0,
          child: new BannerView(  //用了一个banner的插件
              _banners()
          ),
        ),
          new Expanded(
              flex: 1,
              child:  new  RefreshIndicator(
                child: new ListView(
                  controller: _controller,
                  children: articleListView(),
                ),
                onRefresh: _pullToRefresh,
              ),)
        ],
      );
  }
  Future<Null> _pullToRefresh() async {
    getNewList();
    return null;
  }
  List<Widget> _banners() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < img.length; i++) {
      list.add(getImgs(img[i]));
    }
    return list;
  }
  Image getImgs(String path) {
    return new Image.asset(path, fit: BoxFit.cover,);
  }
  getNewList() async {
    var httpClient = new HttpClient();
    var articleUrl = "${Urls.INDEX}$page/json";
    print("-------URL--------$articleUrl");
    var request = await httpClient.getUrl(Uri.parse(articleUrl));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonBody = await response.transform(utf8.decoder).join();
          print("---------jsonBody---------------"+jsonBody);
        setState(() {
            list = Article.getArticle(jsonBody);
        });
      }
    }
  articleListView() {
    List<Widget> widgets = [];
    for(var i=0;i<list.length;i++){
      Article article = list[i];
      if(article != null) {
        var titleRow = new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(article.title, style: titleTextStyle),
            )
          ],
        );
        var timeRow = new Row(
          children: <Widget>[
            new Container(
              width: 20.0,
              height: 20.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFECECEC),
                image: new DecorationImage(
                    image: new NetworkImage(article.envelopePic), fit: BoxFit.cover),
                border: new Border.all(
                  color: const Color(0xFFECECEC),
                  width: 2.0,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: new Text(
                article.niceDate,
                style: subtitleStyle,
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text(article.chapterName, style: subtitleStyle),
                ],
              ),
            )
          ],
        );
        var thumbImgUrl = article.envelopePic;
        var thumbImg = new Container(
          margin: const EdgeInsets.all(10.0),
          width: 100.0,
          height: 80.0,
          decoration: new BoxDecoration(
            //shape: BoxShape.circle,
            color: const Color(0xFFECECEC),
            image: new DecorationImage(
                image: new ExactAssetImage('images/da.jpg'),
                fit: BoxFit.cover),
            border: new Border.all(
              color: const Color(0xFFECECEC),
              width: 2.0,
            ),
          ),
        );
        if (thumbImgUrl != null && thumbImgUrl.length > 0) {
          thumbImg = new Container(
            margin: const EdgeInsets.all(10.0),
            width: 100.0,
            height: 80.0,
            decoration: new BoxDecoration(
             // shape: BoxShape.circle,
              color: const Color(0xFFECECEC),
              image: new DecorationImage(
                  image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),
              border: new Border.all(
                color: const Color(0xFFECECEC),
                width: 2.0,
              ),
            ),
          );
        }
        var row = new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    titleRow,
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                      child: timeRow,
                    )
                  ],
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new Container(
                width: 100.0,
                height: 80.0,
                color: const Color(0xFFECECEC),
                child: new Center(
                  child: thumbImg,
                ),
              ),
            )
          ],
        );
        var _g = new GestureDetector(
          onTap: (){
            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
              return new NewsPage(article.link,article.chapterName);
            }));
          },
          child: row,
        );

        widgets.add(_g);
      }
    }
    return widgets;
  }
}