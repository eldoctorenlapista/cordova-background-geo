package com.marianhello.backgroundgeolocation;

import android.test.suitebuilder.annotation.SmallTest;

import com.marianhello.bgloc.Config;

import junit.framework.Assert;

import org.junit.Test;

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
    public void testMergeConfig() {
        Config config = new Config();
        config.setSyncThreshold(10);
        config.setMaxLocations(1000);

        Config newConfig = new Config();
        newConfig.setSyncThreshold(100);

        config.mergeWith(newConfig);

        Assert.assertEquals(config.getSyncThreshold().intValue(), 100);
        Assert.assertEquals(config.getMaxLocations().intValue(), 1000);
    }
}
