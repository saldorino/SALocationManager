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
#import "SALocationUpdateRequestOptions.h"
#import "SALocationUpdateRequestOptions+Feedback.h"

#pragma mark -
@interface SALocationManager : NSObject

/**
 *  A Boolean value indicating whether the location manager object may pause location updates.
 */
@property (nonatomic) BOOL pausesLocationUpdatesAutomatically;

#pragma mark Initialization
/**
 *  Singleton Initializer
 *
 *  @return An initialized instance of SALocationManager
 */
+ (instancetype)defaultManager;


#pragma mark Location Update Requests
/**
 *  Starts updating location for a SALocationManagerRequestOptions instance
 *
 *  @param options The options object
 */
- (void)startUpdatingLocationWithOptions:(SALocationUpdateRequestOptions *)options;

/**
 *  Cancels the location updates for the a SALocationManagerRequestOptions instance
 *
 *  @param options The options object
 */
- (void)stopUpdatingLocationWithOptions:(SALocationUpdateRequestOptions *)options;

@end

