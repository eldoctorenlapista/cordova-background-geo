//
//  LocationTest.m
//  BackgroundGeolocationTests
//
//  Created by Marian Hello on 06/12/2017.
//  Copyright © 2017 mauron85. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Location.h"

@interface LocationTest : XCTestCase

@end

@implementation LocationTest

- (void)testLocationToArray {
    Location *location = [[Location alloc] init];
    location.id = [NSNumber numberWithInt:1];
    location.time = [NSDate dateWithTimeIntervalSince1970:1000];
    location.accuracy = [NSNumber numberWithInt:40];
    location.altitudeAccuracy = [NSNumber numberWithInt:50];
    location.speed = [NSNumber numberWithInt:60];
    location.heading = [NSNumber numberWithInt:1];
    location.altitude = [NSNumber numberWithInt:100];
    location.latitude = [NSNumber numberWithInt:49];
    location.longitude = [NSNumber numberWithInt:20];
    location.provider = @"TEST";
    location.locationProvider = [NSNumber numberWithInt:-1];
    location.radius = [NSNumber numberWithInt:111];
    location.isValid = @YES;
    location.recordedAt = [NSDate dateWithTimeIntervalSince1970:2000];
    
    NSArray *template = @[@"time", @"altitude", @"longitude", @"recordedAt", @"accuracy", @"custom", @"heading", @"speed", @"provider", @"id", @"radius"];
    
    NSArray *actual = [location toResultFromTemplate:template];
    NSArray *expected = @[
                        location.time,
                        location.altitude,
                        location.longitude,
                        location.recordedAt,
                        location.accuracy,
                        @"custom",
                        location.heading,
                        location.speed,
                        location.provider,
                        location.id,
                        location.radius
                    ];

    XCTAssertEqualObjects(actual, expected);
}

- (void)testLocationToDictionary {
    Location *location = [[Location alloc] init];
    location.id = [NSNumber numberWithInt:1];
    location.time = [NSDate dateWithTimeIntervalSince1970:1000];
    location.accuracy = [NSNumber numberWithInt:40];
    location.altitudeAccuracy = [NSNumber numberWithInt:50];
    location.speed = [NSNumber numberWithInt:60];
    location.heading = [NSNumber numberWithInt:1];
    location.altitude = [NSNumber numberWithInt:100];
    location.latitude = [NSNumber numberWithInt:49];
    location.longitude = [NSNumber numberWithInt:20];
    location.provider = @"TEST";
    location.locationProvider = [NSNumber numberWithInt:-1];
    location.radius = [NSNumber numberWithInt:111];
    location.isValid = @YES;
    location.recordedAt = [NSDate dateWithTimeIntervalSince1970:2000];
    
    NSDictionary *template = @{
                               @"id": @"id",
                               @"t": @"time",
                               @"acu": @"accuracy",
                               @"aacu": @"altitudeAccuracy",
                               @"s": @"speed",
                               @"h": @"heading",
                               @"alt": @"altitude",
                               @"lat": @"latitude",
                               @"lon": @"longitude",
                               @"p": @"provider",
                               @"lp": @"locationProvider",
                               @"r": @"radius",
                               @"rt": @"recordedAt",
                               @"foo": @"bar"
                               };

    NSDictionary *actual = [location toResultFromTemplate:template];
    NSDictionary *expected = @{
                               @"id": location.id,
                               @"t": location.time,
                               @"acu": location.accuracy,
                               @"aacu": location.altitudeAccuracy,
                               @"s": location.speed,
                               @"h": location.heading,
                               @"alt": location.altitude,
                               @"lat": location.latitude,
                               @"lon": location.longitude,
                               @"p": location.provider,
                               @"lp": location.locationProvider,
                               @"r": location.radius,
                               @"rt": location.recordedAt,
                               @"foo": @"bar"
                            };
    
    XCTAssertEqualObjects(actual, expected);
}

@end
