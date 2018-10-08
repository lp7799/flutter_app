import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';
class Shared {
  static final String SP_IS_LOGIN = "isLogin";
  static final String SP_USER_NAME = "name";
  static final String SP_COOKIE = "cookie";
  static final String SP_PWD = "passwrod";
  static EventBus eventBus = new EventBus();
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(SP_IS_LOGIN);
    return b != null && b;
  }

  /// 登录成功
  static const EVENT_LOGIN = "event_login";

  /// 退出登录
  static const EVENT_LOGOUT = "event_logout";
}