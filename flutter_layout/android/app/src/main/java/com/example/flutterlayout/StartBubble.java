package com.example.flutterlayout;

import android.app.Activity;
import android.os.Bundle;

public class StartBubble extends Activity {
    @Override
    public void onCreate( Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.bubb_view);
        BubbleView bubbleView = findViewById(R.id.bubble);
    }
}
