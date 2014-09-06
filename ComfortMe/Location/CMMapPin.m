//
//  CMMapPin.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMMapPin.h"

@implementation CMMapPin


- (id) initWithCoordinate:(CLLocationCoordinate2D)coord {
    if ((self = [super init]) != nil) {
        self.coordinate = coord;
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate {
    return self.coordinate;
}

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self.coordinate = newCoordinate;
}

@end
