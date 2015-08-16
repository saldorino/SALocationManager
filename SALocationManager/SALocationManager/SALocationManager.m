//
//  SALocationManager.m
//  SALocationManager
//
//  Created by Sebastian Aldorino on 9/15/14.
//  Copyright (c) 2014 Sebastian Aldorino. All rights reserved.
//

#import "SALocationManager.h"

static NSString * const kAuthorizeAlwaysDescriptionKey    = @"NSLocationAlwaysUsageDescription";
static NSString * const kAuthorizeWhenInUseDescriptionKey = @"NSLocationWhenInUseUsageDescription";


#pragma mark -
@interface SALocationManager () <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic) CLLocation        *lastKnownLocation;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSMutableArray    *runningRequestsOptions;

@end

@implementation SALocationManager


#pragma mark inits & dealloc
+ (instancetype)defaultManager
{
    static id _instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self new];
    });

    return _instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.runningRequestsOptions = [NSMutableArray new];
        self.locationManager        = self.locationManager;
    }

    return self;
}



#pragma mark Request Starting & Stopping
- (void)startUpdatingLocationWithOptions:(SALocationUpdateRequestOptions *)options
{
#if DEBUG
    [self verifyLocationRequestsSetupWithOptions:options];
#endif

    if (![CLLocationManager locationServicesEnabled])
    {
        if (!options.failsAuthorizationSilently)
        {
            [[[UIAlertView alloc] initWithTitle:@""
                                        message:[SALocationUpdateRequestOptions locationServicesDisabledErrorMessage]
                                       delegate:nil
                              cancelButtonTitle:[SALocationUpdateRequestOptions dismissButtonTitle]
                              otherButtonTitles:nil]
             show];
        }
    }
    else
    {
        if ([self shouldUseLastKnownLocationWithOptions:options])
        {
            options.bestLocationSoFar = self.lastKnownLocation;

            options.onLocationRetrieved(self.lastKnownLocation);
        }
        else
        {
            [self.runningRequestsOptions addObject:options];

            if ([self requiresAuthorizationStatusChangeWithOptions:options])
            {
                [self displayAuthorizationAlertWithOptions:options];
            }
            else
            {
                [self.locationManager startUpdatingLocation];
            }
        }
    }
}

- (void)stopUpdatingLocationWithOptions:(SALocationUpdateRequestOptions *)options
{
    [self.runningRequestsOptions removeObject:options];

    if (!self.runningRequestsOptions.count)
    {
        [self.locationManager stopUpdatingLocation];
    }

    options.onLocationUpdatesStopped(options.bestLocationSoFar);
}



#pragma mark Public Properties
- (void)setPausesLocationUpdatesAutomatically:(BOOL)pausesLocationUpdatesAutomatically
{
    [self.locationManager setPausesLocationUpdatesAutomatically:pausesLocationUpdatesAutomatically];
}

- (BOOL)pausesLocationUpdatesAutomatically
{
    return [self.locationManager pausesLocationUpdatesAutomatically];
}



#pragma mark Private
- (BOOL)shouldUseLastKnownLocationWithOptions:(SALocationUpdateRequestOptions *)options
{
    CLLocation *loc         = self.lastKnownLocation;
    NSTimeInterval locAge   = [[NSDate date] timeIntervalSinceDate:self.lastKnownLocation.timestamp];

    return loc && loc.horizontalAccuracy <= options.desiredHorizontalAccuracy && locAge <= options.maxAge;
}



#pragma mark Private Properties
- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        CLLocationManager *(^initializeLocationManager)() = ^CLLocationManager *()
        {
            CLLocationManager *manager = [CLLocationManager new];
            manager.delegate  = self;

            return manager;
        };

        if (![NSThread isMainThread])
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                _locationManager = initializeLocationManager();
            });
        }
        else
        {
            _locationManager = initializeLocationManager();
        }
    }

    return _locationManager;
}



#pragma mark Authorization Status
- (BOOL)requiresAuthorizationStatusChangeWithOptions:(SALocationUpdateRequestOptions *)options
{
    BOOL result;
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];

    switch (authStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            result = NO;
            break;

        case kCLAuthorizationStatusAuthorizedWhenInUse:
            result = options.authorizeAlways ? YES : NO;
            break;

        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            result = YES;
            break;
    }

    return result;
}

- (void)displayAuthorizationAlertWithOptions:(SALocationUpdateRequestOptions *)options
{
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];

    // Display iOS's auth alert
    if (authStatus == kCLAuthorizationStatusNotDetermined)
    {
        SEL authSEL = options.authorizeAlways ? @selector(requestAlwaysAuthorization) : @selector(requestWhenInUseAuthorization);
        if ([self.locationManager respondsToSelector:authSEL])
        {
            // Invoke the selector ignoring ARC-Related warning because we know it doesn't apply here.
            ((void (*)(id, SEL))[self.locationManager methodForSelector:authSEL])(self.locationManager, authSEL);
        }
        else
        {
            [self.locationManager startUpdatingLocation];
            [self.locationManager stopUpdatingLocation];
        }
    }
    // The app has been denied the location services in the past. Let the user know with a custom alert that opens the settings App (if possible)
    else if (authStatus == kCLAuthorizationStatusDenied || authStatus == kCLAuthorizationStatusRestricted)
    {
        [self.runningRequestsOptions removeObject:options];

        if (!options.failsAuthorizationSilently)
        {
            [self displayAuthorizationDeniedAlert];
        }
    }
}

- (void)displayAuthorizationDeniedAlert
{
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@""
                                                message:[SALocationUpdateRequestOptions locationAuthorizationDeniedErrorMessage]
                                               delegate:nil
                                      cancelButtonTitle:[SALocationUpdateRequestOptions dismissButtonTitle]
                                      otherButtonTitles:nil];

    if (&UIApplicationOpenSettingsURLString != NULL && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
    {
        a.delegate = self;

        [a addButtonWithTitle:[SALocationUpdateRequestOptions openSettingsButtonTitle]];
    }

    [a show];
}



#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        UIApplication *application  = [UIApplication sharedApplication];
        NSURL *settingsURL          = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

        if ([application canOpenURL:settingsURL])
        {
            [application openURL:settingsURL];
        }
    }
}



#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location    = locations.firstObject;
    self.lastKnownLocation  = location;

    NSArray *requestsOptions = self.runningRequestsOptions.copy;
    for (SALocationUpdateRequestOptions *options in requestsOptions)
    {
        NSTimeInterval locationAge = [[NSDate date] timeIntervalSinceDate:location.timestamp];

        if (locationAge <= options.maxAge)
        {
            if (!options.bestLocationSoFar || location.horizontalAccuracy <= options.bestLocationSoFar.horizontalAccuracy)
            {
                options.bestLocationSoFar = location;
                options.onLocationUpdated(options.bestLocationSoFar);

                if (location.horizontalAccuracy < options.desiredHorizontalAccuracy)
                {
                    if (!options.continuousUpdates)
                    {
                        [self.runningRequestsOptions removeObject:options];
                    }

                    options.onLocationRetrieved(options.bestLocationSoFar);
                }
            }
        }

        if (--options.retryCount <= 0 && !options.continuousUpdates)
        {
            [self.runningRequestsOptions removeObject:options];

            options.onLocationRetrieved(options.bestLocationSoFar);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSArray *requestsOptions = self.runningRequestsOptions.copy;

    for (SALocationUpdateRequestOptions *options in requestsOptions)
    {
        options.onLocationUpdateFailed(error);

        [self.runningRequestsOptions removeObject:options];
    }

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    for (SALocationUpdateRequestOptions *options in self.runningRequestsOptions)
    {
        options.onLocationUpdatesPaused(options.bestLocationSoFar);
    }
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    for (SALocationUpdateRequestOptions *options in self.runningRequestsOptions)
    {
        options.onLocationUpdatesResumed(options.bestLocationSoFar);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {
        [self.locationManager startUpdatingLocation];
    }
}



#pragma mark DEBUG
- (void)verifyLocationRequestsSetupWithOptions:(SALocationUpdateRequestOptions *)options
{
#if DEBUG
    NSBundle *b               = [NSBundle mainBundle];
    NSString *authKey         = options.authorizeAlways ? kAuthorizeAlwaysDescriptionKey : kAuthorizeWhenInUseDescriptionKey;
    NSString *authDescription = [b objectForInfoDictionaryKey:authKey];

    if (options.authorizeAlways)
    {
        NSAssert(authDescription.length, @"Info.plist is missing the required key to allow location authorization all the time.");
    }
    else
    {
        NSAssert(authDescription.length, @"Info.plist is missing the required key to allow location authorization while the app is active.");
    }
#endif
}


@end
