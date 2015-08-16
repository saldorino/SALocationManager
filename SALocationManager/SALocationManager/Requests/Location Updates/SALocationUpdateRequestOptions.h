//
//  SALocationManager.m
//  SALocationManager
//
//  Created by Sebastian Aldorino on 9/15/14.
//  Copyright (c) 2014 Sebastian Aldorino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#pragma mark -
typedef void(^SALocationUpdateRequestSuccessBlock)(CLLocation *location);
typedef void(^SALocationUpdateRequestFailureBlock)(NSError *error);

@interface SALocationUpdateRequestOptions : NSObject


#pragma mark Public Properties
/**
 *  Holds the best location found so far. Ignores desiredHorizontalAccuracy.
 */
@property (nonatomic) CLLocation *bestLocationSoFar;

#pragma mark Request Configuration Properties
/**
 *  Whether or not the location manager continues updating location after a location with that conforms with all the requirements has been found
 */
@property (nonatomic) BOOL continuousUpdates;

/**
 *  Desired horizontal accuracy for a location to be considered valid.
 */
@property (nonatomic) CGFloat desiredHorizontalAccuracy;

/**
 *  Maximum age of a location to be considered valid.
 */
@property (nonatomic) NSTimeInterval maxAge;

/**
 *  Maximum amount of tries before stopping.
 */
@property (nonatomic) NSUInteger retryCount;

/**
 *  Whether the app should authorize location access at all times or only when used.
 See Objective-C's NSLocationAlwaysUsageDescription and NSLocationWhenInUseUsageDescription documentation for more info.
 */
@property (nonatomic) BOOL authorizeAlways;

/**
 *  Whether the app displays a message to the user when authorization to user's Location is denied or if Location Services are disabled.
 */
@property (nonatomic) BOOL failsAuthorizationSilently;


#pragma mark Request Blocks
/**
 *  Invoked every time a new location is found.
 */
@property (nonatomic, copy) SALocationUpdateRequestSuccessBlock onLocationUpdated;

/**
 *  Invoked when a location that conforms to all the required conditions is found.
 */
@property (nonatomic, copy) SALocationUpdateRequestSuccessBlock onLocationRetrieved;

/**
 *  Invoked when location updates are stopped.
 */
@property (nonatomic, copy) SALocationUpdateRequestSuccessBlock onLocationUpdatesStopped;

/**
 *  Invoked when location updates are paused.
 */
@property (nonatomic, copy) SALocationUpdateRequestSuccessBlock onLocationUpdatesPaused;

/**
 * Invoked when location updates are resumed
 */
@property (nonatomic, copy) SALocationUpdateRequestSuccessBlock onLocationUpdatesResumed;

/**
 *  Invoked when a location update fails.
 */
@property (nonatomic, copy) SALocationUpdateRequestFailureBlock onLocationUpdateFailed;

@end