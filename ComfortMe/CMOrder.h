//
//  CMOrder.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "CMTracker.h"

@interface CMOrder : NSObject

+ (PFObject*) newOrder;

+ (void) attemptOrder:(PFObject*)order withBlock:(void (^)(BOOL accepted, CMTracker *tracker))completionBlock;

@end
