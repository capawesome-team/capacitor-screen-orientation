package dev.robingenz.capacitor.screenorientation;

import android.content.pm.ActivityInfo;
import android.view.Surface;

import com.getcapacitor.Bridge;

public class ScreenOrientation {

    private Bridge bridge;

    ScreenOrientation(Bridge bridge) {
        this.bridge = bridge;
    }

    public void lock(String type) {
        switch (type) {
            case ScreenOrientationType.LANDSCAPE:
                bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE);
                break;
            case ScreenOrientationType.LANDSCAPE_PRIMARY:
                bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                break;
            case ScreenOrientationType.LANDSCAPE_SECONDARY:
                bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE);
                break;
            case ScreenOrientationType.PORTRAIT:
                bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT);
                break;
            case ScreenOrientationType.PORTRAIT_PRIMARY:
                bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
                break;
            case ScreenOrientationType.PORTRAIT_SECONDARY:
                bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT);
                break;
        }
    }

    public void unlock() {
        bridge.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_USER);
    }

    public String getCurrentOrientationType() {
        int rotation = bridge.getActivity().getWindowManager().getDefaultDisplay().getRotation();
        switch (rotation) {
            case Surface.ROTATION_90:
                return ScreenOrientationType.LANDSCAPE_PRIMARY;
            case Surface.ROTATION_180:
                return ScreenOrientationType.PORTRAIT_SECONDARY;
            case Surface.ROTATION_270:
                return ScreenOrientationType.LANDSCAPE_SECONDARY;
            default:
                return ScreenOrientationType.PORTRAIT_PRIMARY;
        }
    }
}
