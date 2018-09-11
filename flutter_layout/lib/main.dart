import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout/ImgPage.dart';
import 'package:flutter_layout/page/Find.dart';
import 'package:flutter_layout/page/Index.dart';
import 'package:flutter_layout/page/Mywode.dart';
import 'package:flutter_layout/widget/MyDrawer.dart';
//入口
void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
     return new MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '福利', '谈天说地', '我的直播'];
  var _body;
  @override
  Widget build(BuildContext context) {
    initDate();

    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.purple
      ),
      title: '超级APP',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(appBarTitles[_tabIndex]
          ,style: new TextStyle(color: Colors.white),),
        iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: _body,
        bottomNavigationBar: new CupertinoTabBar(
          items:<BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1),
                title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2),
                title: getTabTitle(2)),
            new BottomNavigationBarItem(
                icon: getTabIcon(3),
                title: getTabTitle(3)),
          ],
          currentIndex: _tabIndex,
          onTap: (index){
            setState(() {
              _tabIndex = index;
            });
          },

        ),
        drawer: new MyDrawer(),
      ),

    );
  }


  Text  getTabTitle(int i) {
    return new Text(
      appBarTitles[i],
    );
  }

  Image getTabIcon(int i) {
    if(i == _tabIndex){
      return tabImages[i][1];
    }
    return tabImages[i][0];
  }
  void initDate(){
   _body = new IndexedStack(
      children: <Widget>[
        new Index(),
        new ImgPage(),
        new Find(),
        new Mywode()
      ],
      index: _tabIndex,
    );
    if (tabImages == null) {
       tabImages = [
        [
          getTabImage('images/ic_nav_news_normal.png'),
          getTabImage('images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('images/ic_nav_tweet_normal.png'),
          getTabImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('images/ic_nav_discover_normal.png'),
          getTabImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('images/ic_nav_my_normal.png'),
          getTabImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }
  }
  // 传入图片路径，返回一个Image组件
  Image getTabImage(String path) {
  return new Image.asset(path,width: 20.0,height: 20.0,fit: BoxFit.cover,);
  }
}
