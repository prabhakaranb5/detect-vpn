package com.outsystems.vpndetection;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class VPNDetectionPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("detectVPN")) {
            this.detectVPN(callbackContext);
            return true;
        }
        return false;
    }

    private void detectVPN(CallbackContext callbackContext) {
        PluginResult result = new PluginResult(PluginResult.Status.OK,checkForVPNConnectivity());
        callbackContext.sendPluginResult(result);
    }

    private boolean checkForVPNConnectivity(){
        ConnectivityManager cm = (ConnectivityManager)cordova.getActivity().getSystemService(Context.CONNECTIVITY_SERVICE);
        Network[] networks = cm.getAllNetworks();
    
        for(int i = 0; i < networks.length; i++) {
            NetworkCapabilities caps = cm.getNetworkCapabilities(networks[i]);
            if (caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN)){
                return true;
            }
        }
    
        return false;
    }
}
