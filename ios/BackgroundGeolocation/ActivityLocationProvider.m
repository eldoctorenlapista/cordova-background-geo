//
//  ActivityLocationProvider.m
//  BackgroundGeolocation
//
//  Created by Marian Hello on 14/09/2016.
//  Copyright © 2016 mauron85. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityLocationProvider.h"
#import "Logging.h"

static NSString * const TAG = @"ActivityLocationProvider";
static NSString * const Domain = @"com.marianhello";

@implementation ActivityLocationProvider

- (instancetype) init
{
    self = [super init];
    
    if (self == nil) {
        return self;
    }
    
    return self;
}

- (void) onCreate {/* noop */}

- (void) onDestroy {/* noop */}

- (BOOL) onConfigure:(Config*)config error:(NSError * __autoreleasing *)outError
{
    if (outError != nil) {
        NSDictionary *errorDictionary = @{ @"code": [NSNumber numberWithInt:BG_NOT_IMPLEMENTED], @"message" : @"Not implemented yet" };
        *outError = [NSError errorWithDomain:Domain code:BG_NOT_IMPLEMENTED userInfo:errorDictionary];
    }
    
    return NO;
}

- (BOOL) onStart:(NSError * __autoreleasing *)outError
{
    if (outError != nil) {
        NSDictionary *errorDictionary = @{ @"code": [NSNumber numberWithInt:BG_NOT_IMPLEMENTED], @"message" : @"Not implemented yet" };
        *outError = [NSError errorWithDomain:Domain code:BG_NOT_IMPLEMENTED userInfo:errorDictionary];
    }

    return NO;
}

- (BOOL) onStop:(NSError * __autoreleasing *)outError
{
    if (outError != nil) {
        NSDictionary *errorDictionary = @{ @"code": [NSNumber numberWithInt:BG_NOT_IMPLEMENTED], @"message" : @"Not implemented yet" };
        *outError = [NSError errorWithDomain:Domain code:BG_NOT_IMPLEMENTED userInfo:errorDictionary];
    }

    return NO;
}

- (void) onSwitchMode:(BGOperationMode)mode
{
    /* do nothing */
}

@end
