//
//  GeolocationOpenHelperTests.m
//  CDVBackgroundGeolocation
//
//  Created by Marian Hello on 01/07/16.
//  Copyright © 2016 mauron85. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationContract.h"
#import "GeolocationOpenHelper.h"


// Warning: This has to be last test in suite, because it unlinks db file
@interface xGeolocationOpenHelperTests : XCTestCase

@end

@implementation xGeolocationOpenHelperTests

- (void)setUp {
    [super setUp];
    GeolocationOpenHelper *helper = [[GeolocationOpenHelper alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbPath = [helper getDatabasePath];
    [fileManager removeItemAtPath:dbPath error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfLocationTableIsCreated {
    GeolocationOpenHelper *helper = [[GeolocationOpenHelper alloc] init];
    FMDatabaseQueue *queue = [helper getWritableDatabase];
    
    [queue inDatabase:^(FMDatabase *database) {
        NSString *sql = [NSString stringWithFormat: @"SELECT name FROM sqlite_master WHERE type='%@' AND name='table_name';", @LC_TABLE_NAME];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]) {
            XCTAssertEqual([rs stringForColumnIndex:0], @LC_TABLE_NAME);
        }
        [rs close];
    }];
    
    [helper close];
}

- (void)testLocationTableSQLStatement {
    NSString *sql = [LocationContract createTableSQL];
    XCTAssertEqualObjects(sql, @"CREATE TABLE IF NOT EXISTS location ( id INTEGER PRIMARY KEY AUTOINCREMENT , time REAL , accuracy REAL , speed REAL , bearing REAL , altitude REAL , latitude REAL , longitude REAL , provider TEXT , service_provider TEXT , valid INTEGER , recorded_at INTEGER );");
}

@end
