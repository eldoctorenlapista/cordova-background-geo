//
//  ConfigTest.m
//  BackgroundGeolocationTests
//
//  Created by Marian Hello on 02/12/2017.
//  Copyright © 2017 mauron85. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Config.h"

@interface ConfigTest : XCTestCase

@end

@implementation ConfigTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEmpty {
    Config *config = [[Config alloc] init];

    XCTAssertFalse([config hasStationaryRadius]);
    XCTAssertFalse([config hasDistanceFilter]);
    XCTAssertFalse([config hasDesiredAccuracy]);
    XCTAssertFalse([config hasDebug]);
    XCTAssertFalse([config hasActivityType]);
    XCTAssertFalse([config hasStopOnTerminate]);
    XCTAssertFalse([config hasUrl]);
    XCTAssertFalse([config hasSyncUrl]);
    XCTAssertFalse([config hasSyncThreshold]);
    XCTAssertFalse([config hasHttpHeaders]);
    XCTAssertFalse([config hasSaveBatteryOnBackground]);
    XCTAssertFalse([config hasMaxLocations]);
    XCTAssertFalse([config hasPauseLocationUpdates]);
    XCTAssertFalse([config hasLocationProvider]);
}

- (void)testBooleans {
    Config *config = [[Config alloc] init];
    
    config._debug = @YES;
    XCTAssertTrue([config isDebugging]);
    
    config._debug = @NO;
    XCTAssertFalse([config isDebugging]);
    
}

- (void)testMerge {
    Config *config1 = [[Config alloc] init];
    config1.distanceFilter = [NSNumber numberWithInt:666];
    Config *config2 = [[Config alloc] initWithDefaults];
    config2.distanceFilter = [NSNumber numberWithInt:999];
    
    Config *merger = [Config merge:config1 withConfig:config2];
    
    XCTAssertEqual(merger.distanceFilter.intValue, 999);
    XCTAssertEqualObjects(merger.activityType, @"OtherNavigation");
    XCTAssertEqual(config1.distanceFilter.intValue, 666);
    XCTAssertEqual(config2.distanceFilter.intValue, 999);
    XCTAssertNotEqual(merger.distanceFilter, config1.distanceFilter);
    XCTAssertEqual(merger.distanceFilter, config2.distanceFilter);
    XCTAssertNotEqual(config1.distanceFilter, config2.distanceFilter);
}

@end
