//
//  CMLocationPollerDelegate.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMLocationPoller.h"
#import "CMTracker.h"

@protocol CMLocationPollerDelegate <NSObject>

@optional
- (void) locationPollerDidRefreshLocationForPFObject;
- (void) locationPollerDidUpdateLocationForPFObject;
- (void) locationPollerDidEncounterError:(NSError*)error;
- (void) locationPollerDidNoticeConnectionClosed;
@end
