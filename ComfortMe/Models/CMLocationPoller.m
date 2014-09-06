//
//  CMLocationPoller.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMLocationPoller.h"

@implementation CMLocationPoller
@synthesize currentPolling, locationManager, delegate;

- (id) init {
    if ((self = [super init]) != nil) {
        currentPolling = [[NSMutableDictionary alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        locationManager.distanceFilter = 100;
    }
    return self;
}


- (void) refreshLocationWithPFObject:(PFObject*)object
         everyNumSeconds:(NSInteger)seconds {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                        target:self
                                        selector:@selector(refresh:)
                                        userInfo:object
                                        repeats:YES];
    currentPolling[object.objectId] = timer;
}

- (void) refresh:(PFObject*)object {
    [object refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            [delegate locationPollerDidRefreshLocationForPFObject:object];
        } else {
            [delegate locationPollerDidEncounterError:error];
        }
    }];
}

- (void) stopRefreshingLocationWithPFObject:(PFObject*)object {
    NSTimer *timer = currentPolling[object.objectId];
    [currentPolling removeObjectForKey:object.objectId];
    [timer invalidate];
}

- (void) updateLocationWithPFObject:(PFObject*)object
        everyNumSeconds:(NSInteger)seconds {
    [locationManager startUpdatingLocation];
}

@end
