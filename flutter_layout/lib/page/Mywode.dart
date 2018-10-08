import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
class Mywode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return new MywodeState();
  }

}
class MywodeState  extends State<Mywode>{
  VideoPlayerController _controller;
  bool isShow = true;
  var img = [
    'images/da.jpg',
    'images/DVa.jpg',
    'images/lk.jpg',
    'images/sw.jpg',
    'images/t.jpg',
    'images/ts.jpg',
  ];
  @override
  void initState() {
    super.initState();
    _controller = new VideoPlayerController.network(
      'http://live-cdn.xzxwhcb.com/hls/sn88wrar.m3u8',
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
            child: new Chewie(
              _controller,
               showControls: isShow,
              autoInitialize: true,
              autoPlay: false,
            ),
        ),
        new IconButton(icon: new Icon(Icons.autorenew),
            onPressed: (){
              setState(() {
                if(isShow){
                  isShow = false;
                }else{
                  isShow = true;
                }
              });
            }),
        Expanded(
            child:SafeArea(
                top: false,
                bottom: false,
                child: GridView.count(
                  crossAxisCount:3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: 1.3,
                  children:
                    _banners()
                )
            )
        ),
      ],
    );
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
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}