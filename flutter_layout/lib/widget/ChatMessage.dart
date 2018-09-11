

import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({this.text,this.newMessage,this.animationController});
     String text;
     String newMessage;
  final AnimationController animationController;

  @override
  State<StatefulWidget> createState() {
   return new ChatMessageState(text,newMessage,animationController);
  }

  }
class ChatMessageState extends State<ChatMessage> {
  var _name='张三';
  String text;
  String sendMessage;
  final AnimationController animationController;
  ChatMessageState(this.text, this.sendMessage, this.animationController);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("------text:$text----message:$sendMessage--------------");
    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          sMessage(),//发送的消息界面
          jSmessage()//对话的消息
        ],
      );

  }
  Widget sMessage(){
    return  new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut), //new
      axisAlignment: 0.0, //new
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(_name, style: Theme
                      .of(context)
                      .textTheme
                      .subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  ),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            )
          ],
        ),
      ),
    );
  }
  Widget jSmessage(){
    return  new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut), //new
      axisAlignment: 0.0, //new
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name, style: Theme
                      .of(context)
                      .textTheme
                      .subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(sendMessage),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}

}