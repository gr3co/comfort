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
        self.coordinates = coord;
    }
    return self;
}

- (NSString*) title {
    return @"Bob's location";
}

@end
