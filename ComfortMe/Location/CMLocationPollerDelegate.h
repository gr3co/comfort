//
//  CMLocationPollerDelegate.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMLocationPoller.h"

@protocol CMLocationPollerDelegate <NSObject>

@optional
- (void) locationPollerDidRefreshLocationForPFObject:(PFObject*)object;
- (void) locationPollerDidUpdateLocationForPFObject:(PFObject*)object withSuccess:(BOOL)success;
- (void) locationPollerDidEncounterError:(NSError*)error;
@end
