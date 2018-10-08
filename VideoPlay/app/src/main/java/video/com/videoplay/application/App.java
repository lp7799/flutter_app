package video.com.videoplay.application;

import android.app.Application;

import com.kk.taurus.playerbase.config.PlayerConfig;
import com.kk.taurus.playerbase.config.PlayerLibrary;

public class App extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        //如果您想使用默认的网络状态事件生产者，请添加此行配置。
        //并需要添加权限 android.permission.ACCESS_NETWORK_STATE
        PlayerConfig.setUseDefaultNetworkEventProducer(true);
        //初始化库
        PlayerLibrary.init(this);
    }
}
