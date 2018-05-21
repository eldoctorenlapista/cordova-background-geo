package com.marianhello.bgloc.cordova;

import android.content.pm.PackageManager;
import android.support.annotation.NonNull;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONException;

import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;

public class PermissionManager {
    private CordovaInterface cordova;
    private int requestCode = 0;
    private PermissionHandler permissionHandler;
    private static Hashtable<Integer, PermissionRequestListener> permissionResults;
    private static PermissionManager permissionManager;

    private PermissionManager(CordovaInterface cordova) {
        this.cordova = cordova;
        this.permissionHandler = new PermissionHandler();
    }

    private static class PermissionHandler extends CordovaPlugin {
        @Override
        public void onRequestPermissionResult(int requestCode, String[] permissions,
                                              int[] grantResults) throws JSONException {

            if (!permissionResults.containsKey(requestCode)) {
                return;
            }

            PermissionRequestListener listener = permissionResults.get(requestCode);

            for (int r : grantResults) {
                if (r == PackageManager.PERMISSION_DENIED) {
                    listener.onPermissionDenied();
                    return;
                }
            }

            listener.onPermissionGranted();
            permissionResults.remove(requestCode);
        }
    }

    public static PermissionManager getInstance(CordovaInterface cordova) {
        if (permissionManager == null) {
            permissionManager = new PermissionManager(cordova);
            permissionResults = new Hashtable();
        }
        return permissionManager;
    }

    public boolean hasPermissions(@NonNull Collection<String> permissions) {
        Iterator<String> it = permissions.iterator();
        while (it.hasNext()) {
            if (!cordova.hasPermission(it.next())) {
                return false;
            }
        }
        return true;
    }

    public void checkPermissions(@NonNull Collection<String> permissions, @NonNull final PermissionRequestListener listener) {
        if (hasPermissions(permissions)) {
            listener.onPermissionGranted();
        } else {
            requestCode++;
            permissionResults.put(requestCode, listener);
            cordova.requestPermissions(permissionHandler, requestCode, permissions.toArray(new String[0]));
        }
    }

    public interface PermissionRequestListener {
        void onPermissionGranted();
        void onPermissionDenied();
    }
}
