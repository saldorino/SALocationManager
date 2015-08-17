//
//  LocationUpdatesListenerSample.m
//  SALocationManager
//
//  Created by Sebastian on 2015-8-4.
//  Copyright (c) 2015 Sebastian Aldorino. All rights reserved.
//

#import "LocationUpdatesViewController.h"
#import "SALocationManager.h"

@implementation LocationUpdatesViewController
{
    NSMutableArray *_continuousLocationUpdatesListeners;
    NSMutableArray *_nonContinuousLocationUpdatesListeners;
}



#pragma mark IBActions
- (IBAction)addContinuousLocationUpdatesListener:(id)sender
{
    SALocationUpdatesListener *listener = [self newLocationUpdatesListener];
    listener.continuousUpdates          = YES;

    [[SALocationManager defaultManager] startUpdatingLocationWithListener:listener];

    [[self continuousLocationUpdatesListeners] addObject:listener];
}

- (IBAction)removeAllContinuousLocationUpdatesListeners:(id)sender
{
    NSMutableArray *listeners = [self continuousLocationUpdatesListeners].copy;

    for (SALocationUpdatesListener *listener in listeners)
    {
        [[SALocationManager defaultManager] stopUpdatingLocationWithListener:listener];
    }
}

- (IBAction)addNonContinuousLocationUpdatesListener:(id)sender
{
    SALocationUpdatesListener *listener = [self newLocationUpdatesListener];

    [[SALocationManager defaultManager] startUpdatingLocationWithListener:listener];

    [[self nonContinuousLocationUpdatesListeners] addObject:listener];
}

- (IBAction)removeAllNonContinuousLocationUpdatesListeners:(id)sender
{
    NSMutableArray *listeners = [self nonContinuousLocationUpdatesListeners];

    for (SALocationUpdatesListener *listener in listeners)
    {
        [[SALocationManager defaultManager] stopUpdatingLocationWithListener:listener];
    }

    [listeners removeAllObjects];
}



#pragma mark Private Properties
- (NSMutableArray *)continuousLocationUpdatesListeners
{
    if (!_continuousLocationUpdatesListeners)
    {
        _continuousLocationUpdatesListeners = [NSMutableArray new];
    }

    return _continuousLocationUpdatesListeners;
}

- (NSMutableArray *)nonContinuousLocationUpdatesListeners
{
    if (!_nonContinuousLocationUpdatesListeners)
    {
        _nonContinuousLocationUpdatesListeners = [NSMutableArray new];
    }

    return _nonContinuousLocationUpdatesListeners;
}



#pragma mark Private LocationUpdateListeners helpers
- (SALocationUpdatesListener *)newLocationUpdatesListener
{
    SALocationUpdatesListener *listener = [SALocationUpdatesListener new];
    listener.desiredHorizontalAccuracy  = 100;

    __block SALocationUpdatesListener *weakListener = listener;

    listener.onLocationUpdated = ^(CLLocation *location)
    {
        NSLog(@"%@.onLocationUpdated(%@)", weakListener, location);
    };

    listener.onLocationRetrieved = ^(CLLocation *location)
    {
        NSLog(@"%@.onLocationRetrieved(%@)", weakListener, location);
    };

    listener.onLocationUpdatesStopped = ^(CLLocation *location)
    {
        NSLog(@"%@.onLocationUpdatesStopped(%@)", weakListener, location);

        [[self continuousLocationUpdatesListeners] removeObject:weakListener];
    };

    return listener;
}


@end
