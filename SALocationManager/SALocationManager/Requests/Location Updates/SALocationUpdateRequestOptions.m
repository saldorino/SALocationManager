//
//  SALocationManager.m
//  SALocationManager
//
//  Created by Sebastian Aldorino on 9/15/14.
//  Copyright (c) 2014 Sebastian Aldorino. All rights reserved.
//

#import "SALocationUpdateRequestOptions.h"

#pragma mark -
@implementation SALocationUpdateRequestOptions


#pragma mark inits & dealloc
- (instancetype)init
{
    if (self = [super init])
    {
        self.desiredHorizontalAccuracy  = 100.f;
        self.retryCount                 = 10;
        self.maxAge                     = 5 * 60;
        self.continuousUpdates          = NO;
        self.authorizeAlways            = NO;
        self.failsAuthorizationSilently = NO;
        self.onLocationUpdated          = ^(CLLocation *location) {};
        self.onLocationRetrieved        = ^(CLLocation *location) {};
        self.onLocationUpdatesStopped   = ^(CLLocation *location) {};
        self.onLocationUpdatesResumed   = ^(CLLocation *location) {};
        self.onLocationUpdateFailed     = ^(NSError *error) {};
    }

    return self;
}

@end
