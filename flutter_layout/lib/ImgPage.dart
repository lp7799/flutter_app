
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout/Img.dart';


class ImgPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ImaPageState();
  }
}
class ImaPageState  extends State<ImgPage> with AutomaticKeepAliveClientMixin{
  ScrollController _controller = new ScrollController();
  List<Img> newimg = [];
  int cot=0;
  ImaPageState(){
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        // scroll to bottom, get next page data
        print("load more ... ");
        cot++;
        getData(false);
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(false);
  }

  @override
  Widget build(BuildContext context) {
    return
        new  RefreshIndicator(
             child: new GridView.count(
               crossAxisCount: 2,
              mainAxisSpacing: 1.0,

          controller: _controller,
          children: imgs(),
        ),
        onRefresh: _pullToRefresh,

    );
  }

  Future<Null> _pullToRefresh() async {

   getData(false);
    return null;
  }

  imgs() {
    List<Widget> widgets = [];
    for (int i = 0; i < newimg.length; i++) {
      Img img = newimg[i];
      if (img.url == null) {
          return new Center(
            child: new Text('加载失败'),
          );
      } else {
        var imgurl = new Image.network(
          img.url,  fit: BoxFit.cover,);
        var card = new Card(
          child: imgurl,
          color: Colors.white,
        );

        widgets.add(card);
      }
    }
    return widgets;
  }

  getData(bool b) async {
    var httpClient = new HttpClient();
    var url = "https://www.apiopen.top/meituApi?page=$cot";
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonBody = await response.transform(utf8.decoder).join();

      print(jsonBody);
      setState(() {
        newimg = Img.decodeData(jsonBody);
      });
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if(notification is ScrollEndNotification){
      //下滑到最底部
      if(notification.metrics.extentAfter==0.0){
        cot +=1;
        getData(false);
        imgs();
      }
      //滑动到最顶部
      if(notification.metrics.extentBefore==0.0){
      }
    }
    return false;
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
