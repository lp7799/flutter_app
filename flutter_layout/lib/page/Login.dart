
import 'package:flutter_layout/Urls/AppCookie.dart';
import 'package:flutter_layout/Urls/EventObject.dart';
import 'package:flutter_layout/Urls/Shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_layout/page/RegisterLogin.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return new LoginState();
  }

}

class LoginState extends State<Login> {
  String _lastName;
  String _psssword;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isPasswrod = true;
  String _chakan = 'images/chakan.png';
  var map;
  @override
  Widget build(BuildContext context) {
     return new MaterialApp(
       title: '登录',
       home: new Scaffold(
         appBar: new AppBar(
           title: new Text('登录or验证'),
           iconTheme: new IconThemeData(color: Colors.white),
         ),
         body: new Form(
           key: _formKey,
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Padding(
                 padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                 child: new Center(
                   child:  new TextFormField(
                       decoration: InputDecoration(
                           icon: Icon(Icons.account_circle),
                           labelText: "用户名"
                       ),
                       onSaved: (value) {
                         _lastName = value;
                       }
                   ),
                 ),
               ),
                new Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 20.0),
                  child: new Center(
                    child: new TextFormField(
                        obscureText: isPasswrod,
                        decoration: InputDecoration(
                          suffixIcon: new Container(
                            child: new IconButton(
                                icon: new Image.asset(_chakan,fit: BoxFit.cover,),
                                onPressed: (){
                              setState(() {
                                if(isPasswrod){
                                  _chakan = 'images/chakan1.png';
                                  isPasswrod = false;
                                }else{
                                  isPasswrod = true;
                                  _chakan = 'images/chakan.png';
                                }
                              });
                            }),
                          ),
                            icon: Icon(Icons.enhanced_encryption),
                            labelText: "密码"
                        ),
                        onSaved: (value) {
                          _psssword  = value;
                        }
                    ),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: new RaisedButton(
                          child: new Text("注册？"),
                          onPressed:(){
                            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) =>new RegisterLogin()));
                          }),
                    ),
                    new RaisedButton(
                        child: new Text("提交"),
                        onPressed:(){
                          // save()：保存Form下的每个TextField
                          _formKey.currentState.save();
                          getLogin(_lastName,_psssword);

                        })
                  ],
                )
             ],
           ),
         ),
       ),
     );
  }
  getStaet(Map map){
    if(map['errorCode'] == 0){
      showCenterShortToast("登录成功");
      Shared.eventBus.fire(EventObject(Shared.EVENT_LOGIN,''));
      Navigator.pop(context,"login");
    }else{
      var s = "登录失败："+map['errorMsg'];
      showCenterShortToast(s);
    }
  }
  getLogin(String name,String pwd ) async{
    var dio = new Dio();
    dio.options.baseUrl = "http://www.wanandroid.com/user/login";
    FormData formData = new FormData.from({
      "username": name,
      "password": pwd,
    });
    Response response = await dio.post("",data:formData);
    map = response.data;
    SharedPreferences sp = await SharedPreferences.getInstance();
    //保存cookie
   var  cookie = response.headers['set-cookie'];
    if(cookie !=null){
      AppCookie.APP_COOKIE = cookie.toString();
      print('--- AppCookie.APP_COOKIE---'+ AppCookie.APP_COOKIE.toString());
      await sp.setString(AppCookie.COOKIE,cookie.toString());
      print("保存cookie成功$cookie");
      getStaet(response.data);
    }

    //保存用户信息
    if(response.data != null){
      await sp.setBool(Shared.SP_IS_LOGIN, true);
      await sp.setString(Shared.SP_USER_NAME, map['data']['username']);
      await sp.setString(Shared.SP_PWD, map['data']['password']);
    }
  }
  void showCenterShortToast(String s) {
    Fluttertoast.showToast(
        msg:s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1
    );
  }
}