package com.marianhello;

import com.marianhello.bgloc.Config;
import com.marianhello.bgloc.cordova.ConfigMapper;
import com.marianhello.bgloc.data.HashMapLocationTemplate;
import com.marianhello.bgloc.data.LinkedHashSetLocationTemplate;
import com.marianhello.bgloc.data.LocationTemplate;

import junit.framework.Assert;

import org.json.JSONException;
import org.json.JSONObject;
import org.junit.Test;

import java.util.HashMap;
import java.util.LinkedHashSet;

/**
 * Created by finch on 15.12.2017.
 */

public class ConfigMapperTest {
    @Test
    public void testDefaultToJSONObject() {
        Config config = Config.getDefault();
        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals(config.getStationaryRadius(), jConfig.getDouble("stationaryRadius"), 0f);
            Assert.assertEquals(config.getDistanceFilter().intValue(), jConfig.getInt("distanceFilter"));
            Assert.assertEquals(config.getDesiredAccuracy().intValue(), jConfig.getInt("desiredAccuracy"));
            Assert.assertEquals(config.isDebugging().booleanValue(), jConfig.getBoolean("debug"));
            Assert.assertEquals(config.getNotificationTitle(), jConfig.getString("notificationTitle"));
            Assert.assertEquals(config.getNotificationText(), jConfig.getString("notificationText"));
            Assert.assertEquals(config.getStopOnTerminate().booleanValue(), jConfig.getBoolean("stopOnTerminate"));
            Assert.assertEquals(config.getStartOnBoot().booleanValue(), jConfig.getBoolean("startOnBoot"));
            Assert.assertEquals(config.getLocationProvider().intValue(), jConfig.getInt("locationProvider"));
            Assert.assertEquals(config.getInterval().intValue(), jConfig.getInt("interval"));
            Assert.assertEquals(config.getFastestInterval().intValue(), jConfig.getInt("fastestInterval"));
            Assert.assertEquals(config.getActivitiesInterval().intValue(), jConfig.getInt("activitiesInterval"));
            Assert.assertEquals(config.getNotificationIconColor(), jConfig.getString("notificationIconColor"));
            Assert.assertEquals(config.getLargeNotificationIcon(), jConfig.getString("notificationIconLarge"));
            Assert.assertEquals(config.getSmallNotificationIcon(), jConfig.getString("notificationIconSmall"));
            Assert.assertEquals(config.getStartForeground().booleanValue(), jConfig.getBoolean("startForeground"));
            Assert.assertEquals(config.getStopOnStillActivity().booleanValue(), jConfig.getBoolean("stopOnStillActivity"));
            Assert.assertEquals(config.getUrl(), jConfig.getString("url"));
            Assert.assertEquals(config.getSyncUrl(), jConfig.getString("syncUrl"));
            Assert.assertEquals(config.getSyncThreshold().intValue(), jConfig.getInt("syncThreshold"));
            Assert.assertEquals(new JSONObject(config.getHttpHeaders()).toString(), jConfig.getJSONObject("httpHeaders").toString());
            Assert.assertEquals(config.getMaxLocations().intValue(), jConfig.getInt("maxLocations"));
            Assert.assertEquals(JSONObject.NULL, jConfig.get("postTemplate"));
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }

    @Test
    public void testNullHashMapTemplateToJSONObject() {
        Config config = new Config();
        LocationTemplate tpl = new HashMapLocationTemplate(null);
        config.setTemplate(tpl);

        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals(JSONObject.NULL, jConfig.get("postTemplate"));
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }

    @Test
    public void testEmptyHashMapTemplateToJSONObject() {
        Config config = new Config();
        HashMap map = new HashMap();
        LocationTemplate tpl = new HashMapLocationTemplate(map);
        config.setTemplate(tpl);

        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals("{}", jConfig.get("postTemplate").toString());
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }

    @Test
    public void testHashMapTemplateToJSONObject() {
        Config config = new Config();
        HashMap map = new HashMap();
        map.put("foo", "bar");
        map.put("pretzels", 123);
        LocationTemplate tpl = new HashMapLocationTemplate(map);
        config.setTemplate(tpl);

        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals("{\"foo\":\"bar\",\"pretzels\":123}", jConfig.get("postTemplate").toString());
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }

    @Test
    public void testNullLinkedHashSetTemplateToJSONObject() {
        Config config = new Config();
        LocationTemplate tpl = new LinkedHashSetLocationTemplate(null);
        config.setTemplate(tpl);

        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals(JSONObject.NULL, jConfig.get("postTemplate"));
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }

    @Test
    public void testEmptyLinkedHashSetTemplateToJSONObject() {
        Config config = new Config();
        LinkedHashSet set = new LinkedHashSet();
        LocationTemplate tpl = new LinkedHashSetLocationTemplate(set);
        config.setTemplate(tpl);

        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals("[]", jConfig.get("postTemplate").toString());
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }

    @Test
    public void testLinkedHashSetTemplateToJSONObject() {
        Config config = new Config();
        LinkedHashSet set = new LinkedHashSet();
        set.add("foo");
        set.add(123);
        LocationTemplate tpl = new LinkedHashSetLocationTemplate(set);
        config.setTemplate(tpl);

        try {
            JSONObject jConfig = ConfigMapper.toJSONObject(config);
            Assert.assertEquals("[\"foo\",123]", jConfig.get("postTemplate").toString());
        } catch (JSONException e) {
            Assert.fail(e.getMessage());
        }
    }
}
