//
//  CMLocationPoller.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMLocationPoller.h"

@implementation CMLocationPoller
@synthesize
    currentPolling,
    currentUpdating,
    delegate;

- (id) init {
    if ((self = [super init]) != nil) {
        currentPolling = [[NSMutableDictionary alloc] init];
        currentUpdating = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void) refreshLocationWithPFObject:(PFObject*)object
         everyNumSeconds:(NSInteger)seconds {
    if (currentPolling[object.objectId]) {
        // Already polling
        return;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                        target:self
                                        selector:@selector(refresh:)
                                        userInfo:object
                                        repeats:YES];
    currentPolling[object.objectId] = timer;
}

- (void) refresh:(NSTimer*)sender {
    PFObject *object = sender.userInfo;
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
    if (currentUpdating[object.objectId]) {
        // Already updating location
        return;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                                      target:self
                                                    selector:@selector(update:)
                                                    userInfo:object
                                                     repeats:YES];
    currentUpdating[object.objectId] = timer;
}

- (void) update:(NSTimer*)sender {
    PFObject *object = sender.userInfo;
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (error) {
            [delegate locationPollerDidEncounterError:error];
        } else {
            object[@"location"] = geoPoint;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    [delegate locationPollerDidEncounterError:error];
                } else {
                    [delegate locationPollerDidUpdateLocationForPFObject:object withSuccess:succeeded];
                }
            }];
        }
    }];
}

- (void) stopUpdatingLocationWithPFObject:(PFObject*)object {
    NSTimer *timer = currentUpdating[object.objectId];
    [currentUpdating removeObjectForKey:object.objectId];
    [timer invalidate];
}

@end
