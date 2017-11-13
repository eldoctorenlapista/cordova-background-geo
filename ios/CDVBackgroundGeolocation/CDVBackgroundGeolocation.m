//
//  CDVBackgroundGeolocation.h
//
//  Created by Marian Hello on 04/06/16.
//  Version 2.0.0
//
//  According to apache license
//
//  This is class is using code from christocracy cordova-plugin-background-geolocation plugin
//  https://github.com/christocracy/cordova-plugin-background-geolocation


#import "CDVBackgroundGeolocation.h"
#import "Config.h"
#import "BackgroundGeolocationFacade.h"
#import "BackgroundTaskManager.h"

static NSString * const TAG = @"CDVBackgroundGeolocation";

@implementation CDVBackgroundGeolocation {
    NSString *callbackId;
    BackgroundGeolocationFacade* facade;
}

- (void)pluginInitialize
{

    facade = [[BackgroundGeolocationFacade alloc] init];
    facade.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppPause:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppResume:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppTerminate:) name:UIApplicationWillTerminateNotification object:nil];
}

/**
 * configure plugin
 * @param {Number} stationaryRadius
 * @param {Number} distanceFilter
 * @param {Number} locationTimeout
 */
- (void) configure:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"configure");
    [self.commandDelegate runInBackground:^{
        Config* config = [Config fromDictionary:[command.arguments objectAtIndex:0]];
        
        NSError *error = nil;
        CDVPluginResult* result = nil;
        if (![facade configure:config error:&error]) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Configuration error"];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

/**
 * Turn on background geolocation
 * in case of failure it calls error callback from configure method
 * may fire two callback when location services are disabled and when authorization failed
 */
- (void) start:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"start");
    [self.commandDelegate runInBackground:^{
        NSError *error = nil;
        CDVPluginResult* result = nil;

        [facade start:&error];
        if (error == nil) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:[error userInfo]];
        }
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

/**
 * Turn it off
 */
- (void) stop:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"stop");
    [self.commandDelegate runInBackground:^{
        NSError *error = nil;
        CDVPluginResult* result = nil;
        if ([facade stop:&error]) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:[error userInfo]];
        }
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

/**
 * Change 
 * @param {Number} operation mode BACKGROUND/FOREGROUND
 */
- (void) switchMode:(CDVInvokedUrlCommand *)command
{
    NSLog(@"%@ #%@", TAG, @"switchMode");
    [self.commandDelegate runInBackground:^{
        BGOperationMode mode = [[command.arguments objectAtIndex: 0] intValue];
        [facade switchMode:mode];
    }];
}

/**
 * Fetches current stationaryLocation
 */
- (void) getStationaryLocation:(CDVInvokedUrlCommand *)command
{
    NSLog(@"%@ #%@", TAG, @"getStationaryLocation");
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* result = nil;

        Location* stationaryLocation = [facade getStationaryLocation];
        if (stationaryLocation) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[stationaryLocation toDictionary]];
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
        }

        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void) isLocationEnabled:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"isLocationEnabled");
    [self.commandDelegate runInBackground:^{
        BOOL isLocationEnabled = [facade isLocationEnabled];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isLocationEnabled];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void) showAppSettings:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"showAppSettings");
    [self.commandDelegate runInBackground:^{
        [facade showAppSettings];
    }];
}

- (void) showLocationSettings:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"showLocationSettings");
    [self.commandDelegate runInBackground:^{
        [facade showLocationSettings];
    }];
}

- (void) getLocations:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"getLocations");
    [self.commandDelegate runInBackground:^{
        NSArray *locations = [facade getLocations];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:locations];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void) getValidLocations:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"getValidLocations");
    [self.commandDelegate runInBackground:^{
        NSArray *locations = [facade getValidLocations];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:locations];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void) deleteLocation:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"deleteLocation");
    [self.commandDelegate runInBackground:^{
        int locationId = [[command.arguments objectAtIndex: 0] intValue];
        [facade deleteLocation:[[NSNumber alloc] initWithInt:locationId]];
    }];
}

- (void) deleteAllLocations:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"deleteAllLocations");
    [self.commandDelegate runInBackground:^{
        [facade deleteAllLocations];
    }];
}

- (void) getLogEntries:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@ #%@", TAG, @"getLogEntries");
    [self.commandDelegate runInBackground:^{
        NSInteger limit = [command.arguments objectAtIndex: 0] == [NSNull null]
            ? 0 : [[command.arguments objectAtIndex: 0] integerValue];
        NSArray *logs = [facade getLogEntries:limit];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:logs];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void) startTask:(CDVInvokedUrlCommand*)command
{
    NSUInteger taskKey = [[BackgroundTaskManager sharedTasks] beginTask];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSUInteger:taskKey];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) endTask:(CDVInvokedUrlCommand*)command
{
    int taskKey = [[command.arguments objectAtIndex: 0] intValue];
    [[BackgroundTaskManager sharedTasks] endTaskWithKey:taskKey];
}

- (void) addEventListener:(CDVInvokedUrlCommand*)command
{
    callbackId = command.callbackId;
}

- (void) removeEventListener:(CDVInvokedUrlCommand*)command
{
    callbackId = nil;
}

-(void) sendEvent:(NSString*)name
{
    if (callbackId == nil) {
        return;
    }

    NSDictionary *event = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@", name], @"name", nil];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:event];
    [result setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

-(void) sendEvent:(NSString*)name resultAsNSInteger:(NSInteger)resultAsNSInteger
{
    if (callbackId == nil) {
        return;
    }

    NSDictionary *event = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@", name], @"name",
                           resultAsNSInteger, @"payload",
                           nil];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:event];
    [result setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

-(void) sendEvent:(NSString*)name resultAsDictionary:(NSDictionary*)resultAsDictionary
{
    if (callbackId == nil) {
        return;
    }
    
    NSDictionary *event = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@", name], @"name",
                           resultAsDictionary, @"payload",
                           nil];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:event];
    [result setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void) onAuthorizationChanged:(BGAuthorizationStatus)authStatus
{
    NSLog(@"%@ #%@", TAG, @"onAuthorizationChanged");
    [self sendEvent:@"authorization" resultAsNSInteger:authStatus];
}

- (void) onLocationChanged:(Location*)location
{
    NSLog(@"%@ #%@", TAG, @"onLocationChanged");
    [self sendEvent:@"location" resultAsDictionary:[location toDictionary]];
}

- (void) onStationaryChanged:(Location*)location
{
    NSLog(@"%@ #%@", TAG, @"onStationaryChanged");
    [self sendEvent:@"stationary" resultAsDictionary:[location toDictionary]];
}

- (void) onLocationPause
{
    NSLog(@"%@ %@", TAG, @"location updates paused");
    [self sendEvent:@"stop"];
}

- (void) onLocationResume
{
    NSLog(@"%@ %@", TAG, @"location updates resumed");
    [self sendEvent:@"stop"];
}

- (void) onError:(NSError*)error
{
    NSLog(@"%@ #%@", TAG, @"onError");
    if (callbackId == nil) {
        return;
    }

    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:[error userInfo]];
    [result setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

-(void) onAppResume:(NSNotification *)notification
{
    NSLog(@"%@ %@", TAG, @"resumed");
    [facade switchMode:FOREGROUND];
}

-(void) onAppPause:(NSNotification *)notification
{
    NSLog(@"%@ %@", TAG, @"paused");
    [facade switchMode:BACKGROUND];
}

/**@
 * on UIApplicationDidFinishLaunchingNotification
 */
-(void) onFinishLaunching:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    
    if ([dict objectForKey:UIApplicationLaunchOptionsLocationKey]) {
        NSLog(@"%@ %@", TAG, @"started by system on location event.");
//        [manager switchOperationMode:BACKGROUND];
    }
}

-(void) onAppTerminate:(NSNotification *)notification
{
    NSLog(@"%@ %@", TAG, @"appTerminate");
    [facade onAppTerminate];
}

@end
