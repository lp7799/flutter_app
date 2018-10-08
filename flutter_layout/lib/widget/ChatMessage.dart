

import 'package:flutter/material.dart';
import 'package:flutter_layout/Urls/EventObject.dart';
import 'package:flutter_layout/Urls/Shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var _name='M';
  String text;
  String sendMessage;
  String username= "GG";
  final AnimationController animationController;
  ChatMessageState(this.text, this.sendMessage, this.animationController);
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }


  getUserInfo() async {
    var name;
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString(Shared.SP_USER_NAME);
    print("===="+name);
    setState(() {
      username = name;
    });
  }
  @override
  Widget build(BuildContext context) {

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
                  new Text(username, style: Theme
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
              child: new CircleAvatar(child: new Text(username[0])),
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
              child: new CircleAvatar(child: new Text(_name)),
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