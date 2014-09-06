//
//  CMLocationPoller.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "CMLocationPollerDelegate.h"

@interface CMLocationPoller : NSObject<CLLocationManagerDelegate>

@property NSMutableDictionary *currentPolling;
@property CLLocationManager *locationManager;
@property id<CMLocationPollerDelegate> delegate;

- (void) refreshLocationWithPFObject:(PFObject*)object
         everyNumSeconds:(NSInteger)seconds;

- (void) stopRefreshingLocationWithPFObject:(PFObject*)object;

- (void) updateLocationWithPFObject:(PFObject*)object
        everyNumSeconds:(NSInteger)seconds;

@end
