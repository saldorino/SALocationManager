//
//  SALocationUpdateRequestOptions+Feedback.m
//  SALocationManager
//
//  Created by Sebastian on 2015-8-4.
//  Copyright (c) 2015 Sebastian Aldorino. All rights reserved.
//

#import "SALocationUpdateRequestOptions+Feedback.h"

@implementation SALocationUpdateRequestOptions (Feedback)


static NSString * _dismissButtonTitle                   = nil;
static NSString * _openSettingsButtonTitle              = nil;
static NSString * _authorizationDeniedErrorMessage      = nil;
static NSString * _locationServicesDisabledErrorMessage = nil;

+ (NSString *)dismissButtonTitle
{
    if (!_dismissButtonTitle)
    {
        [self setDismissButtonTitle:@"Dismiss"];
    }

    return _dismissButtonTitle;
}

+ (void)setDismissButtonTitle:(NSString *)title
{
    _dismissButtonTitle = title;
}

+ (NSString *)openSettingsButtonTitle
{
    if (!_openSettingsButtonTitle)
    {
        [self setOpenSettingsButtonTitle:@"Open Settings App"];
    }

    return _openSettingsButtonTitle;
}

+ (void)setOpenSettingsButtonTitle:(NSString *)title
{
    _openSettingsButtonTitle = title;
}

+ (NSString *)locationAuthorizationDeniedErrorMessage
{
    if (!_authorizationDeniedErrorMessage)
    {
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
        NSString *message = [NSString stringWithFormat:@"'%@' is not authorized to access your location. Please authorize it through your device's Settings App", appName];

        [self setAuthorizationDeniedErrorMessage:message];
    }

    return _authorizationDeniedErrorMessage;
}

+ (void)setAuthorizationDeniedErrorMessage:(NSString *)message
{
    _authorizationDeniedErrorMessage = message;
}

+ (NSString *)locationServicesDisabledErrorMessage
{
    if (!_locationServicesDisabledErrorMessage)
    {
        [self setLocationServicesDisabledErrorMessage:@"Location services are disabled on your device. Please enable them through the Settings App"];
    }

    return _locationServicesDisabledErrorMessage;
}

+ (void)setLocationServicesDisabledErrorMessage:(NSString *)message
{
    _locationServicesDisabledErrorMessage = message;
}


@end
