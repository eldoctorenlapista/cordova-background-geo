//
//  ActivityLocationProvider.m
//  BackgroundGeolocation
//
//  Created by Marian Hello on 14/09/2016.
//  Copyright © 2016 mauron85. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityLocationProvider.h"
#import "Activity.h"
#import "SOMotionDetector.h"
#import "Logging.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

static NSString * const TAG = @"ActivityLocationProvider";
static NSString * const Domain = @"com.marianhello";

@implementation ActivityLocationProvider {
    BOOL isStarted;
}

- (instancetype) init
{
    self = [super init];
    
    if (self == nil) {
        return self;
    }
    
    isStarted = NO;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [SOMotionDetector sharedInstance].useM7IfAvailable = YES; //Use M7 chip if available, otherwise use lib's algorithm
    }
    
    [SOMotionDetector sharedInstance].motionTypeChangedBlock = ^(SOMotionType motionType) {
        NSString *type = @"";
        switch (motionType) {
            case MotionTypeNotMoving:
                type = @"STILL";
                break;
            case MotionTypeWalking:
                type = @"WALKING";
                break;
            case MotionTypeRunning:
                type = @"RUNNING";
                break;
            case MotionTypeAutomotive:
                type = @"IN_VEHICLE";
                break;
        }
        DDLogDebug(@"%@ motionTypeChanged: %@", TAG, type);
        Activity *activity = [[Activity alloc] init];
        activity.type = type;
        [super.delegate onActivityChanged:activity];
    };
    
    [SOMotionDetector sharedInstance].locationChangedBlock = ^(CLLocation *location) {
        DDLogDebug(@"%@ locationChanged: %@", TAG, location);
        
        Location *bgloc = [Location fromCLLocation:location];
        [super.delegate onLocationChanged:bgloc];
    };
    
    [SOMotionDetector sharedInstance].accelerationChangedBlock = ^(CMAcceleration acceleration) {
        DDLogDebug(@"%@ accelerationChanged x=%f y=%f z=%f)", TAG, acceleration.x, acceleration.y, acceleration.z);
    };
    
    [SOMotionDetector sharedInstance].locationWasPausedBlock = ^(BOOL changed) {
        DDLogDebug(@"%@ locationWasPausedBlock: %d)", TAG, changed);
    };
    
    [SOLocationManager sharedInstance].allowsBackgroundLocationUpdates = YES;
    
    return self;
}

- (void) onCreate {/* noop */}

- (BOOL) onConfigure:(Config*)config error:(NSError * __autoreleasing *)outError
{
    // TODO: implement configuration
    return YES;
}

- (BOOL) onStart:(NSError * __autoreleasing *)outError
{
    DDLogInfo(@"%@ will start", TAG);
    
    if (!isStarted) {
        [[SOMotionDetector sharedInstance] startDetection];
        isStarted = YES;
    }
    
    return YES;
}

- (BOOL) onStop:(NSError * __autoreleasing *)outError
{
    DDLogInfo(@"%@ will stop", TAG);
    
    if (isStarted) {
        [[SOMotionDetector sharedInstance] stopDetection];
        isStarted = NO;
    }
    
    return YES;
}

- (void) onSwitchMode:(BGOperationMode)mode
{
    /* do nothing */
}

- (void) onDestroy {
    DDLogInfo(@"Destroying %@ ", TAG);
    [self onStop:nil];
}

@end

