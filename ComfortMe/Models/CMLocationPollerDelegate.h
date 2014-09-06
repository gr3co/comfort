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

@required
- (void) locationPollerDidRefreshLocationForPFObject:(PFObject*)object;
- (void) locationPollerDidEncounterError:(NSError*)error;
@end
