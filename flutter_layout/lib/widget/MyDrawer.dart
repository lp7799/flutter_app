import 'package:flutter/material.dart';
import 'package:flutter_layout/Urls/LoginEvent.dart';
import 'package:flutter_layout/Urls/Shared.dart';
import 'package:flutter_layout/page/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new MyDawerState();
}
class MyDawerState extends State<MyDrawer>{
  var username;
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      Shared.isLogin().then((isLogin){
        setState(() {
          this.isLogin=isLogin;
        });
      });
   Shared.eventBus.on(LoginEvent).listen((data){
       this.isLogin = true;
   });
  }
  @override
  Widget build(BuildContext context) {
        if(!isLogin) {
          return new ConstrainedBox(
              constraints: const BoxConstraints.expand(width: 280.0),
              child: new Material(
                  elevation: 10.0,
                  child: new Center(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new IconButton(icon: new Image.asset(
                            "images/tx.jpg", fit: BoxFit.cover,),
                              onPressed: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (cxt) => new Login()));
                              }),
                        ),
                        new Text("点击头像登录")
                      ],
                    ),
                  )

              )
          );
        }
  }

  _login() async {
    // 打开登录页并处理登录成功的回调
    final result = await Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (context) {
      return new Login();
    }));
    // result为"refresh"代表登录成功
    if (result != null && result == "login") {
      // 刷新用户信息
      getUserInfo();
      // 通知动弹页面刷新
    Shared.eventBus.fire(new LoginEvent());
    }
  }

   getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
        username = sp.getString(Shared.SP_USER_NAME);

  }
}