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
    NSMutableArray *_locationUpdatesListeners;
}



#pragma mark IBActions
- (IBAction)addLocationUpdatesListener:(id)sender
{
    SALocationUpdatesListener *listener             = [SALocationUpdatesListener new];
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

        [[self locationUpdatesListeners] removeObject:weakListener];
    };

    [[SALocationManager defaultManager] startUpdatingLocationWithListener:listener];

    [[self locationUpdatesListeners] addObject:listener];
}



#pragma mark Private Properties
- (NSMutableArray *)locationUpdatesListeners
{
    if (!_locationUpdatesListeners)
    {
        _locationUpdatesListeners = [NSMutableArray new];
    }

    return _locationUpdatesListeners;
}



#pragma mark Private LocationUpdateListeners helpers
- (SALocationUpdatesListener *)newLocationUpdatesListener
{
    SALocationUpdatesListener *listener = [SALocationUpdatesListener new];



    return listener;
}


@end
