//
//  Config.m
//  BackgroundGeolocation
//
//  Created by Marian Hello on 11/06/16.
//

#import "Config.h"

#define isNull(value) (value == nil || value == (id)[NSNull null])
#define isNotNull(value) (value != nil && value != (id)[NSNull null])

@implementation Config 

@synthesize stationaryRadius, distanceFilter, desiredAccuracy, _debug, activityType, _stopOnTerminate, url, syncUrl, syncThreshold, httpHeaders, _saveBatteryOnBackground, maxLocations, _pauseLocationUpdates, locationProvider, _template;

-(instancetype) initWithDefaults {
    self = [super init];
    
    if (self == nil) {
        return self;
    }
    
    stationaryRadius = [NSNumber numberWithInt:50];
    distanceFilter = [NSNumber numberWithInt:500];
    desiredAccuracy = [NSNumber numberWithInt:100];
    _debug = [NSNumber numberWithBool:NO];
    activityType = @"OtherNavigation";
    _stopOnTerminate = [NSNumber numberWithBool:YES];
    _saveBatteryOnBackground = [NSNumber numberWithBool:YES];
    maxLocations = [NSNumber numberWithInt:10000];
    syncThreshold = [NSNumber numberWithInt:100];
    _pauseLocationUpdates = [NSNumber numberWithBool:NO];
    locationProvider = [NSNumber numberWithInt:DISTANCE_FILTER_PROVIDER];
//    template =
    
    return self;
}

+(instancetype) fromDictionary:(NSDictionary*)config
{
    Config *instance = [[Config alloc] init];

    if (isNotNull(config[@"stationaryRadius"])) {
        instance.stationaryRadius = config[@"stationaryRadius"];
    }
    if (isNotNull(config[@"distanceFilter"])) {
        instance.distanceFilter = config[@"distanceFilter"];
    }
    if (isNotNull(config[@"desiredAccuracy"])) {
        instance.desiredAccuracy = config[@"desiredAccuracy"];
    }
    if (isNotNull(config[@"debug"])) {
        instance._debug = config[@"debug"];
    }
    if (isNotNull(config[@"activityType"])) {
        instance.activityType = config[@"activityType"];
    }
    if (isNotNull(config[@"stopOnTerminate"])) {
        instance._stopOnTerminate = config[@"stopOnTerminate"];
    }
    if (isNotNull(config[@"url"])) {
        instance.url = config[@"url"];
    }
    if (isNotNull(config[@"syncUrl"])) {
        instance.syncUrl = config[@"syncUrl"];
    }
    if (isNotNull(config[@"syncThreshold"])) {
        instance.syncThreshold = config[@"syncThreshold"];
    }
    if (isNotNull(config[@"httpHeaders"])) {
        instance.httpHeaders = config[@"httpHeaders"];
    }
    if (isNotNull(config[@"saveBatteryOnBackground"])) {
        instance._saveBatteryOnBackground = config[@"saveBatteryOnBackground"];
    }
    if (isNotNull(config[@"maxLocations"])) {
        instance.maxLocations = config[@"maxLocations"];
    }
    if (isNotNull(config[@"pauseLocationUpdates"])) {
        instance._pauseLocationUpdates = config[@"pauseLocationUpdates"];
    }
    if (isNotNull(config[@"locationProvider"])) {
        instance.locationProvider = config[@"locationProvider"];
    }
    if (isNotNull(config[@"postTemplate"])) {
        instance._template = config[@"postTemplate"];
    }

    return instance;
}

+ (instancetype) merge:(Config*)config withConfig:(Config*)newConfig
{
    if (config == nil) {
        return newConfig;
    }

    if (newConfig == nil) {
        return config;
    }
    
    Config *merger= [config copy];

    if ([newConfig hasStationaryRadius]) {
        merger.stationaryRadius = newConfig.stationaryRadius;
    }
    if ([newConfig hasDistanceFilter]) {
        merger.distanceFilter = newConfig.distanceFilter;
    }
    if ([newConfig hasDesiredAccuracy]) {
        merger.desiredAccuracy = newConfig.desiredAccuracy;
    }
    if ([newConfig hasDebug]) {
        merger._debug = newConfig._debug;
    }
    if ([newConfig hasActivityType]) {
        merger.activityType = newConfig.activityType;
    }
    if ([newConfig hasStopOnTerminate]) {
        merger._stopOnTerminate = newConfig._stopOnTerminate;
    }
    if ([newConfig hasUrl]) {
        merger.url = newConfig.url;
    }
    if ([newConfig hasSyncUrl]) {
        merger.syncUrl = newConfig.syncUrl;
    }
    if ([newConfig hasSyncThreshold]) {
        merger.syncThreshold = newConfig.syncThreshold;
    }
    if ([newConfig hasHttpHeaders]) {
        merger.httpHeaders = newConfig.httpHeaders;
    }
    if ([newConfig hasSaveBatteryOnBackground]) {
        merger._saveBatteryOnBackground = newConfig._saveBatteryOnBackground;
    }
    if ([newConfig hasMaxLocations]) {
        merger.maxLocations = newConfig.maxLocations;
    }
    if ([newConfig hasPauseLocationUpdates]) {
        merger._pauseLocationUpdates = newConfig._pauseLocationUpdates;
    }
    if ([newConfig hasLocationProvider]) {
        merger.locationProvider = newConfig.locationProvider;
    }
    if ([newConfig hasTemplate]) {
        merger._template = newConfig._template;
    }

    return merger;
}

-(id) copyWithZone: (NSZone *) zone
{
    Config *copy = [[[self class] allocWithZone: zone] init];
    if (copy) {
        copy.stationaryRadius = stationaryRadius;
        copy.distanceFilter = distanceFilter;
        copy.desiredAccuracy = desiredAccuracy;
        copy._debug = _debug;
        copy.activityType = activityType;
        copy._stopOnTerminate = _stopOnTerminate;
        copy.url = url;
        copy.syncUrl = syncUrl;
        copy.syncThreshold = syncThreshold;
        copy.httpHeaders = httpHeaders;
        copy._saveBatteryOnBackground = _saveBatteryOnBackground;
        copy.maxLocations = maxLocations;
        copy._pauseLocationUpdates = _pauseLocationUpdates;
        copy.locationProvider = locationProvider;
    }
    
    return copy;
}

- (BOOL) hasStationaryRadius
{
    return stationaryRadius != nil;
}

- (BOOL) hasDistanceFilter
{
    return distanceFilter != nil;
}

- (BOOL) hasDesiredAccuracy
{
    return desiredAccuracy != nil;
}

- (BOOL) hasDebug
{
    return _debug != nil;
}

- (BOOL) hasActivityType
{
    return activityType != nil;
}

- (BOOL) hasStopOnTerminate
{
    return _stopOnTerminate != nil;
}

- (BOOL) hasUrl
{
    return (url != nil && url.length > 0);
}

- (BOOL) hasSyncUrl
{
    return (syncUrl != nil && syncUrl.length > 0);
}

- (BOOL) hasSyncThreshold
{
    return syncThreshold != nil;
}

- (BOOL) hasHttpHeaders
{
    return httpHeaders != nil;
}

- (BOOL) hasSaveBatteryOnBackground
{
    return _saveBatteryOnBackground != nil;
}

- (BOOL) hasMaxLocations
{
    return maxLocations != nil;
}

- (BOOL) hasPauseLocationUpdates
{
    return _pauseLocationUpdates != nil;
}

- (BOOL) hasLocationProvider
{
    return locationProvider != nil;
}

- (BOOL) hasTemplate
{
    return _template != nil;
}

- (BOOL) isDebugging
{
    return _debug.boolValue;
}

- (BOOL) stopOnTerminate
{
    return _stopOnTerminate.boolValue;
}

- (BOOL) saveBatteryOnBackground
{
    return _saveBatteryOnBackground.boolValue;
}

- (BOOL) pauseLocationUpdates
{
    return _pauseLocationUpdates.boolValue;
}

- (CLActivityType) decodeActivityType
{
    if ([activityType caseInsensitiveCompare:@"AutomotiveNavigation"]) {
        return CLActivityTypeAutomotiveNavigation;
    }
    if ([activityType caseInsensitiveCompare:@"OtherNavigation"]) {
        return CLActivityTypeOtherNavigation;
    }
    if ([activityType caseInsensitiveCompare:@"Fitness"]) {
        return CLActivityTypeFitness;
    }

    return CLActivityTypeOther;
}

- (NSInteger) decodeDesiredAccuracy
{
    NSInteger desiredAccuracy = self.desiredAccuracy.integerValue;

    if (desiredAccuracy >= 1000) {
        return kCLLocationAccuracyKilometer;
    }
    if (desiredAccuracy >= 100) {
        return kCLLocationAccuracyHundredMeters;
    }
    if (desiredAccuracy >= 10) {
        return kCLLocationAccuracyNearestTenMeters;
    }
    if (desiredAccuracy >= 0) {
        return kCLLocationAccuracyBest;
    }

    return kCLLocationAccuracyHundredMeters;
}

- (NSString*) getHttpHeadersAsString:(NSError * __autoreleasing *)outError;
{
    NSError *error = nil;
    NSString *httpHeadersString;
    
    if ([self hasHttpHeaders]) {
        NSData *jsonHttpHeaders = [NSJSONSerialization dataWithJSONObject:httpHeaders options:NSJSONWritingPrettyPrinted error:&error];
        if (jsonHttpHeaders) {
            httpHeadersString = [[NSString alloc] initWithData:jsonHttpHeaders encoding:NSUTF8StringEncoding];
        } else {
            if (outError != nil) {
                NSLog(@"Http headers serialization error: %@", error);
                *outError = error;
            }
        }
    }

    return httpHeadersString;
}

- (NSString*) getTemplateAsString:(NSError * __autoreleasing *)outError;
{
    NSError *error = nil;
    NSString *templateAsString;

    if ([self hasTemplate]) {
        NSData *jsonTemplate = [NSJSONSerialization dataWithJSONObject:_template options:0 error:&error];
        if (jsonTemplate) {
            templateAsString = [[NSString alloc] initWithData:jsonTemplate encoding:NSUTF8StringEncoding];
        } else {
            if (outError != nil) {
                NSLog(@"Template serialization error: %@", error);
                *outError = error;
            }
        }
    }

    return templateAsString;
}

- (NSDictionary*) toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
 
    if (activityType != nil) [dict setObject:activityType forKey:@"activityType"];
    if (url != nil) [dict setObject:url forKey:@"url"];
    if (syncUrl != nil) [dict setObject:syncUrl forKey:@"syncUrl"];
    if (httpHeaders != nil) [dict setObject:httpHeaders forKey:@"httpHeaders"];
    if (_template != nil) [dict setObject:_template forKey:@"postTemplate"];

    [dict setObject:stationaryRadius forKey:@"stationaryRadius"];
    [dict setObject:distanceFilter forKey:@"distanceFilter"];
    [dict setObject:desiredAccuracy forKey:@"desiredAccuracy"];
    [dict setObject:_debug forKey:@"debug"];
    [dict setObject:_stopOnTerminate forKey:@"stopOnTerminate"];
    [dict setObject:syncThreshold forKey:@"syncThreshold"];
    [dict setObject:_saveBatteryOnBackground forKey:@"saveBatteryOnBackground"];
    [dict setObject:maxLocations forKey:@"maxLocations"];
    [dict setObject:_pauseLocationUpdates forKey:@"pauseLocationUpdates"];
    [dict setObject:locationProvider forKey:@"locationProvider"];
    
    return dict; 
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Config: distanceFilter=%@ stationaryRadius=%@ desiredAccuracy=%@ activityType=%@ isDebugging=%@ stopOnTerminate=%@ url=%@ syncThreshold=%@ maxLocations=%@ httpHeaders=%@ pauseLocationUpdates=%@ saveBatteryOnBackground=%@ locationProvider=%@ template=%@", distanceFilter, stationaryRadius, desiredAccuracy, activityType, _debug, _stopOnTerminate, url, syncThreshold, maxLocations, httpHeaders, _pauseLocationUpdates, _saveBatteryOnBackground, locationProvider, _template];

}

@end
