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

- (id) initWithLocation:(CLLocationCoordinate2D) coordinate {
    if ((self = [super initWithClassName:@"CMTracker"]) != nil) {
        location = coordinate;
        self[@"location"] = [PFGeoPoint
                             geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate {
    return location;
}

- (NSString *) title {
    return @"Bob";
}

@end
