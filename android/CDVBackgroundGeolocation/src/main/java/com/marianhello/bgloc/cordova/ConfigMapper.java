package com.marianhello.bgloc.cordova;

import com.marianhello.bgloc.Config;
import com.marianhello.bgloc.data.HashMapLocationTemplate;
import com.marianhello.bgloc.data.LocationTemplateFactory;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by finch on 29.11.2017.
 */

public class ConfigMapper {
    public static Config fromJSONObject (JSONObject jObject) throws JSONException {
        Config config = new Config();

        if (jObject.has("stationaryRadius")) {
            config.setStationaryRadius(jObject.getDouble("stationaryRadius"));
        }
        if (jObject.has("distanceFilter")) {
            config.setDistanceFilter(jObject.getInt("distanceFilter"));
        }
        if (jObject.has("desiredAccuracy")) {
            config.setDesiredAccuracy(jObject.getInt("desiredAccuracy"));
        }
        if (jObject.has("debug")) {
            config.setDebugging(jObject.getBoolean("debug"));
        }
        if (jObject.has("notificationTitle")) {
            config.setNotificationTitle(jObject.getString("notificationTitle"));
        }
        if (jObject.has("notificationText")) {
            config.setNotificationText(jObject.getString("notificationText"));
        }
        if (jObject.has("stopOnTerminate")) {
            config.setStopOnTerminate(jObject.getBoolean("stopOnTerminate"));
        }
        if (jObject.has("startOnBoot")) {
            config.setStartOnBoot(jObject.getBoolean("startOnBoot"));
        }
        if (jObject.has("locationProvider")) {
            config.setLocationProvider(jObject.getInt("locationProvider"));
        }
        if (jObject.has("interval")) {
            config.setInterval(jObject.getInt("interval"));
        }
        if (jObject.has("fastestInterval")) {
            config.setFastestInterval(jObject.getInt("fastestInterval"));
        }
        if (jObject.has("activitiesInterval")) {
            config.setActivitiesInterval(jObject.getInt("activitiesInterval"));
        }
        if (jObject.has("notificationIconColor")) {
            config.setNotificationIconColor(jObject.getString("notificationIconColor"));
        }
        if (jObject.has("notificationIconLarge")) {
            config.setLargeNotificationIcon(jObject.getString("notificationIconLarge"));
        }
        if (jObject.has("notificationIconSmall")) {
            config.setSmallNotificationIcon(jObject.getString("notificationIconSmall"));
        }
        if (jObject.has("startForeground")) {
            config.setStartForeground(jObject.getBoolean("startForeground"));
        }
        if (jObject.has("stopOnStillActivity")) {
            config.setStopOnStillActivity(jObject.getBoolean("stopOnStillActivity"));
        }
        if (jObject.has("url")) {
            config.setUrl(jObject.getString("url"));
        }
        if (jObject.has("syncUrl")) {
            config.setSyncUrl(jObject.getString("syncUrl"));
        }
        if (jObject.has("syncThreshold")) {
            config.setSyncThreshold(jObject.getInt("syncThreshold"));
        }
        if (jObject.has("httpHeaders")) {
            config.setHttpHeaders(jObject.getJSONObject("httpHeaders"));
        }
        if (jObject.has("maxLocations")) {
            config.setMaxLocations(jObject.getInt("maxLocations"));
        }
        if (jObject.has("postTemplate")) {
            if (jObject.isNull("postTemplate")) {
                config.setTemplate(new HashMapLocationTemplate(null));
            } else {
                Object postTemplate = jObject.get("postTemplate");
                config.setTemplate(LocationTemplateFactory.fromJSONReverted(postTemplate));
            }
        }

        return config;
    }

    public static JSONObject toJSONObject(Config config) throws JSONException {
        JSONObject json = new JSONObject();
        json.put("stationaryRadius", config.getStationaryRadius());
        json.put("distanceFilter", config.getDistanceFilter());
        json.put("desiredAccuracy", config.getDesiredAccuracy());
        json.put("debug", config.isDebugging());
        json.put("notificationTitle", config.getNotificationTitle());
        json.put("notificationText", config.getNotificationText());
        json.put("notificationIconLarge", config.getLargeNotificationIcon());
        json.put("notificationIconSmall", config.getSmallNotificationIcon());
        json.put("notificationIconColor", config.getNotificationIconColor());
        json.put("stopOnTerminate", config.getStopOnTerminate());
        json.put("startOnBoot", config.getStartOnBoot());
        json.put("startForeground", config.getStartForeground());
        json.put("locationProvider", config.getLocationProvider());
        json.put("interval", config.getInterval());
        json.put("fastestInterval", config.getFastestInterval());
        json.put("activitiesInterval", config.getActivitiesInterval());
        json.put("stopOnStillActivity", config.getStopOnStillActivity());
        json.put("url", config.getUrl());
        json.put("syncUrl", config.getSyncUrl());
        json.put("syncThreshold", config.getSyncThreshold());
        json.put("httpHeaders", new JSONObject(config.getHttpHeaders()));
        json.put("maxLocations", config.getMaxLocations());
        json.put("postTemplate", new JSONObject(config.getTemplate().toString()));

        return json;
    }
}
