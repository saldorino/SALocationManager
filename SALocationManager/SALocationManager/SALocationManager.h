//
//  SALocationManager.h
//  LocationWorkspace
//
//  Created by Sebastian Aldorino on 9/15/14.
//  Copyright (c) 2014 Sebastian Aldorino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@class  SALocationManagerRequestOptions;


#pragma mark -
@interface SALocationManager : NSObject

#pragma mark Initialization
/**
 *  Singleton Init
 *
 *  @return An initialized instance of SALocationManager
 */
+ (instancetype)sharedInstance;

#pragma mark Usage
/**
 *  Starts updating location for the given options parameter
 *
 *  @param options SALocationManagerRequestOptions that configures the request and different callbacks
 */
- (void)startUpdatingLocationWithOptions:(SALocationManagerRequestOptions *)options;

/**
 *  Cancels the location updates for the given options object only.
 *
 *  @param options SALocationManagerRequestOptions used to start updating location.
 */
- (void)stopUpdatingLocationWithOptions:(SALocationManagerRequestOptions *)options;

@end




#pragma mark -
@interface SALocationManagerRequestOptions : NSObject

#pragma mark Public Properties
/**
 *  Holds the best location found so far. Ignores desiredHorizontalAccuracy.
 */
@property (nonatomic) CLLocation *bestLocationSoFar;

#pragma mark Request Configuration Properties
/**
 *  This BOOL defines whether the location manager continues or stops updating location after a location with the desired accuracy has been found
 */
@property (nonatomic) BOOL continuousUpdates;

/**
 *  Desired horizontal accuracy for a location to be considered valid
 */
@property (nonatomic) CGFloat desiredHorizontalAccuracy;

/**
 *  Maximum age of a location to be considered valid.
 */
@property (nonatomic) NSTimeInterval maxAge;

/**
 *  Maximum amount of tries.
 */
@property (nonatomic) NSUInteger retryCount;

/**
 *  Whether the app authorizes to be updating location at all times or only when used.
    See iOS's documentation for NSLocationAlwaysUsageDescription, NSLocationWhenInUseUsageDescription for more info
 */
@property (nonatomic) BOOL authorizeAlways;

/**
 *  Whether the app displays a message to the user when authorization to user's Location is denied or restricted or Location Services are disabled.
    Default value is NO.
 */
@property (nonatomic) BOOL failsAuthorizationSilently;

#pragma mark Request Blocks
/**
 *  Invoked every time a new location is found.
 */
@property (nonatomic, copy) void(^onLocationUpdated)            (CLLocation *updatedLocation);

/**
 *  Invoked when a location that conforms to all the conditions required is found.
 */
@property (nonatomic, copy) void(^onLocationRetrieved)          (CLLocation *mostAccurateLocationRetrieved);

/**
 *  Invoked when location updates are stopped.
 */
@property (nonatomic, copy) void(^onLocationUpdatesStopped)    (CLLocation *mostAccurateLocationRetrieved);

/**
 *  Invoked when location updates are paused.
 */
@property (nonatomic, copy) void(^onLocationUpdatesPaused)      (CLLocation *lastKnownLocation);

/**
 * Invoked when location updates are resumed
 */
@property (nonatomic, copy) void(^onLocationUpdatesResumed)     (CLLocation *lastKnownLocation);

/**
 *  Invoked when location updates fail.
 */
@property (nonatomic, copy) void(^onLocationUpdateFailed)       (NSError *error);

@end