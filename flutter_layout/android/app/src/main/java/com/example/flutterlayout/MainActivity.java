package com.example.flutterlayout;


import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import static android.content.ContentValues.TAG;


public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.io/battery";
  private Context context;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
//    setMethodCallHandler在此通道上接收方法调用的回调

    GeneratedPluginRegistrant.registerWith(this);

    //获取Fragment管理器
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
//                通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可

                if (methodCall.method.equals("getBatteryLevel")) {
                    Log.d(TAG,"------flutt宽和高+"+methodCall.arguments.toString());
                   Toast.makeText(MainActivity.this,"这是Android的方法",Toast.LENGTH_SHORT).show();
                    Intent  intent = new Intent(MainActivity.this,StartBubble.class);
                    startActivity(intent);
                    result.success("success");
                  //FragmentTransaction ts = getSupportFragmentManager().beginTransaction();
                } else {
                  result.notImplemented();
                }

              }
            }
    );
  }

}