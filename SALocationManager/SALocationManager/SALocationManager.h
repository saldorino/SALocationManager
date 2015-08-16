//
//  SALocationManager.h
//  SALocationManager
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
 *  Singleton Initializer
 *
 *  @return An initialized instance of SALocationManager
 */
+ (instancetype)defaultManager;

#pragma mark Usage
/**
 *  Starts updating location for a SALocationManagerRequestOptions instance
 *
 *  @param options The options object
 */
- (void)startUpdatingLocationWithOptions:(SALocationManagerRequestOptions *)options;

/**
 *  Cancels the location updates for the a SALocationManagerRequestOptions instance
 *
 *  @param options The options object
 */
- (void)stopUpdatingLocationWithOptions:(SALocationManagerRequestOptions *)options;

@end




#pragma mark -
typedef void(^SALocationRequestSuccessBlock)(CLLocation *location);
typedef void(^SALocationRequestFailureBlock)(NSError *error);

@interface SALocationManagerRequestOptions : NSObject


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
@property (nonatomic, copy) SALocationRequestSuccessBlock onLocationUpdated;

/**
 *  Invoked when a location that conforms to all the required conditions is found.
 */
@property (nonatomic, copy) SALocationRequestSuccessBlock onLocationRetrieved;

/**
 *  Invoked when location updates are stopped.
 */
@property (nonatomic, copy) SALocationRequestSuccessBlock onLocationUpdatesStopped;

/**
 *  Invoked when location updates are paused.
 */
@property (nonatomic, copy) SALocationRequestSuccessBlock onLocationUpdatesPaused;

/**
 * Invoked when location updates are resumed
 */
@property (nonatomic, copy) SALocationRequestSuccessBlock onLocationUpdatesResumed;

/**
 *  Invoked when a location update fails.
 */
@property (nonatomic, copy) SALocationRequestFailureBlock onLocationUpdateFailed;


#pragma mark Feedback Configuration
/**
 *  This selector can be used to set the 'Dismiss' button's title across all location request instances.
 *
 *  @param title The title to be used
 */
+ (void)setDismissButtonTitle:(NSString *)title;

/**
 *  This selector can be used to set the 'Open Settings App' button's title across all location request instances.
 *
 *  @param title The title to be used
 */
+ (void)setOpenSettingsButtonTitle:(NSString *)title;

/**
 *  This selector can be used to configure the message displayed to the user when the app has been denied user location access.
 *
 *  @param message The message to be displayed
 */
+ (void)setAuthorizationDeniedErrorMessage:(NSString *)message;

/**
 *  This selector can be used to configure the message displayed to the user when their device has Location Services disabled.
 *
 *  @param message The message to be displayed
 */
+ (void)setLocationServicesDisabledErrorMessage:(NSString *)message;

@end