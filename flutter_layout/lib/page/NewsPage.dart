import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_webview/flutter_plugin_webview.dart';
import 'package:flutter_plugin_webview/webview_scaffold.dart';
class NewsPage extends StatefulWidget{
  String url;
  String superChapterName;

  NewsPage(this.url, this.superChapterName);

  @override
  State<StatefulWidget> createState() => new NewsPageState(url,superChapterName);
}
/**
 * 一个webview 显示网页
 *
 */
class NewsPageState extends State<NewsPage> {
  String id;
  String superChapterName;
  NewsPageState(this.id, this.superChapterName);
  bool loaded = false;
  final webviewPlugin = WebViewPlugin.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewPlugin.onStateChanged.listen((WebViewState state){
      print("state: ${state.event}");
      if (state.event ==  WebViewEventLoadFinished) {
        // 加载完成
        setState(() {
          loaded = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    webviewPlugin.launch(
       id,
        rect: new Rect.fromLTWH(
          0.0,
          0.0,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ));
    List<Widget> titleContent = [];
    titleContent.add(new Text(superChapterName, style: new TextStyle(color: Colors.white),));
    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0));
    return
      new WebViewScaffold(
          url: id,
          appBar: new AppBar(
            title:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: titleContent,
            ),
          ),
      );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    webviewPlugin.close();
    webviewPlugin.dispose();
    super.dispose();
  }
}