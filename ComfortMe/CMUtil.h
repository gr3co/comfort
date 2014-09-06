//
//  CMUtil.h
//  ComfortMe
//
//  Created by Niveditha Jayasekar on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "CMOrder.h"
#import "CMTracker.h"

@interface CMUtil : NSObject

+(void)getEstimatedTravelTimeFrom: (PFGeoPoint *)startPoint block:(void (^)(NSString *eta))completionBlock;
+ (void) attemptOrder:(CMOrder *)order withBlock:(void (^)(BOOL accepted, CMTracker *tracker))completionBlock;
@end
