//
//  CMTracker.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface CMTracker : PFObject<MKAnnotation>

@property CLLocationCoordinate2D location;

- (id) initWithLocation:(CLLocationCoordinate2D) coordinate;

@end
