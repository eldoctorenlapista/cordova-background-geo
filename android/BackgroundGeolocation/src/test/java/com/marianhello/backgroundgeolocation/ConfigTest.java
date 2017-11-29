package com.marianhello.backgroundgeolocation;

import android.test.suitebuilder.annotation.SmallTest;

import com.marianhello.bgloc.Config;

import junit.framework.Assert;

import org.junit.Test;

import java.util.HashMap;

/**
 * Created by finch on 29.11.2017.
 */

@SmallTest
public class ConfigTest {
    @Test
    public void testEmptyConfig() {
        Config config = new Config();

        Assert.assertFalse(config.hasStationaryRadius());
        Assert.assertFalse(config.hasDistanceFilter());
        Assert.assertFalse(config.hasDesiredAccuracy());
        Assert.assertFalse(config.hasDebug());
        Assert.assertFalse(config.hasNotificationTitle());
        Assert.assertFalse(config.hasNotificationText());
        Assert.assertFalse(config.hasStopOnTerminate());
        Assert.assertFalse(config.hasStartOnBoot());
        Assert.assertFalse(config.hasLocationProvider());
        Assert.assertFalse(config.hasInterval());
        Assert.assertFalse(config.hasFastestInterval());
        Assert.assertFalse(config.hasActivitiesInterval());
        Assert.assertFalse(config.hasNotificationIconColor());
        Assert.assertFalse(config.hasLargeNotificationIcon());
        Assert.assertFalse(config.hasSmallNotificationIcon());
        Assert.assertFalse(config.hasStartForeground());
        Assert.assertFalse(config.hasStopOnStillActivity());
        Assert.assertFalse(config.hasUrl());
        Assert.assertFalse(config.hasSyncUrl());
        Assert.assertFalse(config.hasSyncThreshold());
        Assert.assertFalse(config.hasHttpHeaders());
        Assert.assertFalse(config.hasMaxLocations());
    }

    @Test
    public void testDefaultConfig() {
        Config config = Config.getDefault();

        Assert.assertEquals(config.getStationaryRadius(), 50f);
        Assert.assertEquals(config.getDistanceFilter().intValue(), 500);
        Assert.assertEquals(config.getDesiredAccuracy().intValue(), 100);
        Assert.assertFalse(config.isDebugging());
        Assert.assertEquals(config.getNotificationTitle(), "Background tracking");
        Assert.assertEquals(config.getNotificationText(), "ENABLED");
        Assert.assertTrue(config.getStopOnTerminate());
        Assert.assertFalse(config.getStartOnBoot());
        Assert.assertEquals(config.getLocationProvider().intValue(), 0);
        Assert.assertEquals(config.getInterval().intValue(), 600000);
        Assert.assertEquals(config.getFastestInterval().intValue(), 120000);
        Assert.assertEquals(config.getActivitiesInterval().intValue(), 10000);
        Assert.assertEquals(config.getNotificationIconColor(), "");
        Assert.assertEquals(config.getLargeNotificationIcon(), "");
        Assert.assertEquals(config.getSmallNotificationIcon(), "");
        Assert.assertTrue(config.getStartForeground());
        Assert.assertTrue(config.getStopOnStillActivity());
        Assert.assertEquals(config.getUrl(), "");
        Assert.assertEquals(config.getSyncUrl(), "");
        Assert.assertEquals(config.getSyncThreshold().intValue(), 100);
        Assert.assertTrue(config.getHttpHeaders().isEmpty());
        Assert.assertEquals(config.getMaxLocations().intValue(), 10000);
    }

    @Test
    public void testMergeConfig() throws CloneNotSupportedException {
        Config config = new Config();

        config.setSyncThreshold(10);
        config.setMaxLocations(1000);
        config.setDesiredAccuracy(5);

        Config newConfig = new Config();
        newConfig.setSyncThreshold(100);
        newConfig.setDesiredAccuracy(500);

        Config merged = config.mergeWith(newConfig);

        Assert.assertEquals(merged.getSyncThreshold().intValue(), 100);
        Assert.assertEquals(merged.getMaxLocations().intValue(), 1000);
        Assert.assertEquals(merged.getDesiredAccuracy().intValue(), 500);

        Assert.assertEquals(config.getSyncThreshold().intValue(), 10);
        Assert.assertEquals(config.getMaxLocations().intValue(), 1000);
        Assert.assertEquals(config.getDesiredAccuracy().intValue(), 5);

        Assert.assertNotSame(config, merged);
        Assert.assertNotSame(config.getSyncThreshold(), merged.getSyncThreshold());
        Assert.assertNotSame(config.getDesiredAccuracy(), merged.getDesiredAccuracy());
    }

    @Test
    public void testMergeHttpHeaders() throws CloneNotSupportedException {
        HashMap httpHeaders = new HashMap<String, String>();
        httpHeaders.put("key1", "value1");
        httpHeaders.put("key2", "value2");

        Config config = new Config();
        config.setHttpHeaders(httpHeaders);

        Config merged = config.mergeWith(new Config());

        Assert.assertNotSame(config, merged);
        // TODO: we should probably clone httpHeaders too (leaving for now)
        //Assert.assertNotSame(config.getHttpHeaders(), merged.getHttpHeaders());
    }
}
