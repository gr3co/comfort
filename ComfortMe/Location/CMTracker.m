//
//  CMTracker.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMTracker.h"

@implementation CMTracker
@dynamic location;
@dynamic name;
@dynamic isActive;

+ (NSString *)parseClassName
{
    return @"CMTracker";
}

+ createNewTrackerWithCoordinate:(PFGeoPoint*)point andName:(NSString*)name
                       withBlock:(void (^)(NSError*,CMTracker*))completionBlock
{
    CMTracker *tracker = [[CMTracker alloc] init];
    tracker.location = point;
    tracker.name = name;
    tracker.isActive = @YES;
    [tracker saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completionBlock(error, tracker);
    }];
    return tracker;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.location latitude], [self.location longitude]);
}

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self.location.latitude = newCoordinate.latitude;
    self.location.longitude = newCoordinate.longitude;
}

- (NSString *) title {
    return self.name;
}

- (void) deactivate {
    [self fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        object[@"isActive"] = @NO;
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        }];
    }];
}

@end
