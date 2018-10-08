
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_layout/Urls/EventObject.dart';
import 'package:flutter_layout/Urls/Shared.dart';
import 'package:flutter_layout/page/Login.dart';
import 'package:flutter_layout/widget/ChatMessage.dart';

class Find extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
        return new FindState();
  }
}

class FindState extends State<Find> with  TickerProviderStateMixin{
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  var newMessage;
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    Shared.eventBus.on<EventObject>().listen((data){
      if(this.mounted){
          if(data.key == Shared.EVENT_LOGIN){
            setState(() {
              isLogin = true;
            });
          }else if(data.key == Shared.EVENT_LOGOUT){
            setState(() {
              isLogin = false;
            });

          }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(isLogin) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
                color: Theme
                    .of(context)
                    .cardColor),
            child: _buildTextComposer(), //modified
          ),
        ],
      );
    }else{
      return new GestureDetector(
        child: new Center(
          child: new Text("少侠去登录后来调戏我吧",
          style: new TextStyle(
            fontSize: 24.0
          ),
          ),
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>new Login()));
        },
      );
    }
  }
  //输入框和一个带图片的button
  Widget _buildTextComposer() {
    return new IconTheme(                                            //new
      data: new IconThemeData(color: Theme.of(context).accentColor), //new
      child: new Container(                                     //modified
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "发送消息"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () {
                    getChat(_textController.text);
                 }
                  ),
            ),
          ],
        ),
      ),                                                             //new
    );
  }
  void _handleSubmitted (String text) async{
    _textController.clear();  //每次输入后清空输入框内容
    ChatMessage message = new ChatMessage(
      text: text,
      newMessage: newMessage,
      animationController: new AnimationController(                  //new
        duration: new Duration(milliseconds: 700),                   //new
        vsync: this,                                                 //new
      ),                                                             //new
    );  //聊天内容                                                          //new
    setState(() {
      _messages.insert(_messages.length, message);//更新聊天数据
    });
    message.animationController.forward();                           //new
  }
  getChat(String s) async {
    var _url = "http://open.drea.cc/chat/get?keyWord=$s&userName=drea_bbs";
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(_url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var jsonBody = await response.transform(utf8.decoder).join();
      var data = json.decode(jsonBody);
      var map = data['data'];
      setState(() {
        if(data['isSuccess']){
          newMessage= map['reply'];
        }else{
          newMessage= data['message'];
        }
      });
      _handleSubmitted(_textController.text);//异步操作不能更新数据 所以放这
    }
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();//清空动画
    super.dispose();
  }

}