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
  TargetPlatform _platform;
  VideoPlayerController _controller;
  bool isShow = true;
  @override
  void initState() {
    super.initState();
    _controller = new VideoPlayerController.network(
      'http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8',
    );

  }
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new IconButton(icon: new Icon(Icons.autorenew),
            onPressed: (){
              setState(() {
                _controller.initialize();
                print("----"+isShow.toString());
               if(isShow){
                 isShow = false;
               }else{
                 isShow = true;
               }
              });
            }),
        new Expanded(
            child: new Chewie(
              _controller,
               showControls: isShow,
              autoPlay:  true,
              // materialProgressColors: new ChewieProgressColors(
              //   playedColor: Colors.red,
              //   handleColor: Colors.blue,
              //   backgroundColor: Colors.grey,
              //   bufferedColor: Colors.lightGreen,
              // ),
              // placeholder: new Container(
              //   color: Colors.grey,
              // ),
              // autoInitialsszqaQize: true,
            ),
        ),
      ],
    );
  }
}