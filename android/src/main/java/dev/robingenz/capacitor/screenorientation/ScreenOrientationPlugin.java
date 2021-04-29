package dev.robingenz.capacitor.screenorientation;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "ScreenOrientation")
public class ScreenOrientationPlugin extends Plugin {

    private ScreenOrientation implementation;

    @Override
    public void load() {
        implementation = new ScreenOrientation(getBridge());
    }

    @PluginMethod
    public void lock(PluginCall call) {
        String orientation = call.getString("type");
        implementation.lock(orientation);
        call.resolve();
    }

    @PluginMethod
    public void unlock(PluginCall call) {
        implementation.unlock();
        call.resolve();
    }

    @PluginMethod
    public void getCurrentOrientationType(PluginCall call) {
        JSObject ret = new JSObject();
        String orientation = implementation.getCurrentOrientationType();
        ret.put("type", orientation);
        call.resolve(ret);
    }
}
