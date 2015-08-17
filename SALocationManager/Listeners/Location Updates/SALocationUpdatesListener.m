//
//  SALocationManager.m
//  SALocationManager
//
//  Created by Sebastian Aldorino on 2015-08-16
//  Copyright (c) 2014 Sebastian Aldorino. All rights reserved.
//

#import "SALocationUpdatesListener.h"

#pragma mark -
@implementation SALocationUpdatesListener


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
