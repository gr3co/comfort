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
#import "CMTracker.h"

@interface CMLocationPoller : NSObject

@property NSMutableDictionary *currentPolling;
@property NSMutableDictionary *currentUpdating;
@property id<CMLocationPollerDelegate> delegate;

- (void) refreshLocationWithPFObject:(CMTracker*)object
         everyNumSeconds:(NSInteger)seconds;

- (void) stopRefreshingLocationWithPFObject:(CMTracker*)object;

- (void) updateLocationWithPFObject:(CMTracker*)object
        everyNumSeconds:(NSInteger)seconds;

- (void) stopUpdatingLocationWithPFObject:(CMTracker*)object;

@end
