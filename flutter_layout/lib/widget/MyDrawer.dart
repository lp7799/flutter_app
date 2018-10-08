
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout/Urls/AppCookie.dart';
import 'package:flutter_layout/Urls/EventObject.dart';
import 'package:flutter_layout/Urls/Shared.dart';
import 'package:flutter_layout/page/Login.dart';
import 'package:flutter_layout/widget/SigPaint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget{
  final String usename;
  const MyDrawer({Key key, this.usename}) : super(key: key);

 @override
  State<StatefulWidget> createState() => new MyDawerState();
}
class MyDawerState extends State<MyDrawer>{
  var _appCookie = AppCookie.APP_COOKIE;
  static const platform = const MethodChannel("samples.flutter.io/battery");
    List<double> list=[];
  Future<Null> _getBatteryLevel() async {
          list.add(MediaQuery.of(context).size.width);
          list.add(MediaQuery.of(context).size.height);
    try {
//      在通道上调用此方法
      final String result = await platform.invokeMethod("getBatteryLevel",list);
      print("-----$result");
    } on PlatformException catch (e) {
      print("error:"+e.message);
    }
  }
   @override
  void initState() {
    // TODO: implement initState
      super.initState();
      Shared.eventBus.on<EventObject>().listen((data){
        if(this.mounted){
          if(data.key == Shared.EVENT_LOGIN){
            setState(() {
                _appCookie =AppCookie.APP_COOKIE;
            });
          }
        }
      });
  }


  @override
  Widget build(BuildContext context) {
          if( _appCookie == null || _appCookie.isEmpty) {
            return
              new Container(
                width: MediaQuery.of(context).size.width-50,
                child: new Material(
                      elevation: 10.0,
                      child: new Center(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300.0,
                              color: Colors.cyan,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                    new  GestureDetector(
                                        child: new ClipOval(
                                          child: new FadeInImage.assetNetwork(
                                            placeholder: "images/da.jpg",//预览图
                                            fit: BoxFit.cover,
                                            image:"images/da.jpg",
                                            width: 120.0,
                                            height: 120.0,
                                          ),
                                        ),
                                      onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>new Login()));
                                      },
                                      ),
                                      new Container(
                                          margin: const EdgeInsets.only(top: 12.0),
                                          child: new Text("请点击头像登录",
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0
                                          ),
                                          ))
                                    ],
                                  )

                            ),

                          ],
                        ),
                      )
                ),
              );
          }else{
            return
              new Container(
                width: MediaQuery.of(context).size.width-50,
                child: new Material(
                  child: Center(
                    child: new Column(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: <Widget>[
                        new Stack(
                          alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              new Image.asset("images/da.jpg",fit: BoxFit.cover,),
                             new Text(widget.usename,
                             style: TextStyle(color: Colors.white,
                             fontSize: 24.0
                             ),
                             ),
                            ],
                         ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new CircleAvatar(
                            maxRadius: 50.0,
                            minRadius: 16.0,
                            child: new Text(widget.usename[0],
                              style: new TextStyle(
                                fontSize:60.0,
                              ),
                            ),
                          ),
                        ),
                        new OutlineButton(
                            child: new Text("涂鸦一下"),
                            onPressed:(){
                              Navigator.of(context).push(MaterialPageRoute(builder:(ctx) =>new SigPaint()));
                            }),
                        new OutlineButton(
                            child: new Text("toast"),
                            onPressed: _getBatteryLevel),
                        new FlatButton(onPressed: (){
                          logout();
                          Navigator.of(context).pop();
                        }, child: new Text("悄悄退出")),
                      ],
                    ),
                  ),
                ),
              );
          }
  }


  void logout() async{
  //清除用户和cookie信息
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.remove(AppCookie.COOKIE);
  sp.remove(Shared.SP_USER_NAME);
  sp.remove(Shared.SP_PWD);
  AppCookie.APP_COOKIE = "";
  setState(() {
    _appCookie = "";
  });
  Fluttertoast.showToast(
      msg: "退出登录成功",
      gravity: ToastGravity.CENTER,
      bgcolor: "#99000000",
      textcolor: '#ffffff');
  AppCookie.APP_COOKIE = '';
  Shared.eventBus.fire(EventObject(Shared.EVENT_LOGOUT, ""));
}
}