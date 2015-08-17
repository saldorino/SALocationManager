//
//  SALocationManager.h
//  SALocationManager
//
//  Created by Sebastian Aldorino on 2014-9-15
//  Copyright (c) 2014 Sebastian Aldorino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "SALocationUpdatesListener.h"

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
 *  Use this selector to start updating location
 *
 *  @param listener The listener that whose blocks will be invoked.
 */
- (void)startUpdatingLocationWithListener:(SALocationUpdatesListener *)listener;

/**
 *  Use this selector to stop updating location for a given listener.
 *
 *  @param listener A listener that was previously used as a parameter on startUpdatingLocationWithListener:
 */
- (void)stopUpdatingLocationWithListener:(SALocationUpdatesListener *)listener;

@end





#pragma mark -
@interface SALocationManager (User_Feedback)

@property (nonatomic, copy) NSString *dismissButtonTitle;

@property (nonatomic, copy) NSString *openSettingsButtonTitle;

@property (nonatomic, copy) NSString *locationAuthorizationDeniedErrorMessage;

@property (nonatomic, copy) NSString *locationServicesDisabledErrorMessage;

@end