
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_layout/page/Login.dart';
class RegisterLogin extends StatefulWidget {
  @override
  _RegisterLoginState createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin> {
  String _frstName;
  String _password;
  String _oldPassword;
  bool isPasswrod = true;
  var map;
  String _chakan = 'images/chakan.png';
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '注册',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("注册账号"),
            iconTheme: IconThemeData(color: Colors.red),
          ),
          body: new Form(
            key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: new Center(
                    child: new TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            labelText: "手机|邮箱"
                        ),
                        onSaved: (value) {
                          _frstName = value;
                        }
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 20.0),
                  child: new Center(
                    child: new TextFormField(
                        obscureText: isPasswrod,
                        decoration: InputDecoration(
                            suffixIcon: new Container(
                              child: new IconButton(
                                  icon: new Image.asset(
                                    _chakan, fit: BoxFit.cover,),
                                  onPressed: () {
                                    setState(() {
                                      if (isPasswrod) {
                                        _chakan = 'images/chakan1.png';
                                        isPasswrod = false;
                                      } else {
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
                          _password = value;
                        }
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 20.0),
                  child: new Center(
                    child: new TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: new Container(
                              child: new IconButton(
                                  icon: new Image.asset(
                                    _chakan, fit: BoxFit.cover,),
                                  onPressed: () {
                                    setState(() {
                                      if (isPasswrod) {
                                        _chakan = 'images/chakan1.png';
                                        isPasswrod = false;
                                      } else {
                                        isPasswrod = true;
                                        _chakan = 'images/chakan.png';
                                      }
                                    });
                                  }),
                            ),
                            icon: Icon(Icons.enhanced_encryption),
                            labelText: "确认密码"
                        ),
                        onSaved: (value) {
                          _oldPassword = value;
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
                          child: new Text("登录？"),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) =>new Login()));

                          }),
                    ),
                    new RaisedButton(
                        child: new Text("提交"),
                        onPressed: () {
                          // save()：保存Form下的每个TextField
                          _formKey.currentState.save();
                            _getRegister(_frstName, _password, _oldPassword);
                          if(map['errorCode'] == -1){
                            showCenterShortToast("注册失败："+map['errorMsg']);
                          }else {
                            String s = "注册成功！！！你的账号为$_frstName";
                            showCenterShortToast(s);
                          }
                           })
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
  void showCenterShortToast(String s) {
    Fluttertoast.showToast(
        msg:s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
  }
  _getRegister(String name,String password,String oldPassword) async{
        var dio = new Dio();
        dio.options.baseUrl = "http://www.wanandroid.com/user/register";
        FormData formData = new FormData.from({
          "username": name,
          "password":password,
          "repassword":oldPassword,
        });
        Response response = await dio.post("",data:formData);
          map = response.data;
          print("-------RE---------"+response.data.toString());
  }
}