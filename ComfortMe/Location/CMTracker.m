//
//  CMTracker.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMTracker.h"

@implementation CMTracker
@synthesize location;

+ (NSString *)parseClassName
{
    return @"CMTracker";
}

+ (CMTracker *)createNewTrackerWithCoordinate:(CLLocationCoordinate2D)coordinate withOrder:(CMOrder *)order withBlock:(void (^)(BOOL,CMTracker*))completionBlock
{
    CMTracker *tracker = [[CMTracker alloc] init];
    tracker.location = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    tracker.order = order;
    [tracker saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completionBlock(succeeded, tracker);
    }];
    return tracker;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.location latitude], [self.location longitude]);
}

- (NSString *) title {
//    return [[self.order seller] objectForKey:@"fbName"];
    return @"Bob";
}

@end
