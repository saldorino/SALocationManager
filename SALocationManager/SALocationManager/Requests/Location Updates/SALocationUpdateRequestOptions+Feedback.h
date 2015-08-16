//
//  SALocationUpdateRequestOptions+Feedback.h
//  SALocationManager
//
//  Created by Sebastian on 2015-8-4.
//  Copyright (c) 2015 Sebastian Aldorino. All rights reserved.
//

#import "SALocationUpdateRequestOptions.h"

@interface SALocationUpdateRequestOptions (Feedback)


/**
 *  Use this selector to obtain the title used for dismiss buttons
 *
 *  @return Dismiss buttons' title
 */
+ (NSString *)dismissButtonTitle;

/**
 *  This selector can be used to set the 'Dismiss' button's title across all location request instances.
 *
 *  @param title The title to be used
 */
+ (void)setDismissButtonTitle:(NSString *)title;

/**
 *  Use this selector to obtain the title used for open settings app buttons
 *
 *  @return Open Settings app buttons' title.
 */
+ (NSString *)openSettingsButtonTitle;

/**
 *  This selector can be used to set the 'Open Settings App' button's title across all location request instances.
 *
 *  @param title The title to be used
 */
+ (void)setOpenSettingsButtonTitle:(NSString *)title;

/**
 *  Use this selector to obtain the message that will be displayed to the user when the app has been denied authorization to obtain the user's location
 *
 *  @return Authorization denied message.
 */
+ (NSString *)locationAuthorizationDeniedErrorMessage;

/**
 *  This selector can be used to configure the message displayed to the user when the app has been denied user location access.
 *
 *  @param message The message to be displayed
 */
+ (void)setAuthorizationDeniedErrorMessage:(NSString *)message;

/**
 *  Use this selector to obtain the message that will be displayed to the user when Location Services are disabled on the device
 *
 *  @return Location Services disabled message
 */
+ (NSString *)locationServicesDisabledErrorMessage;

/**
 *  This selector can be used to configure the message displayed to the user when their device has Location Services disabled.
 *
 *  @param message The message to be displayed
 */
+ (void)setLocationServicesDisabledErrorMessage:(NSString *)message;

@end
