//
//  CMTracker.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "CMOrder.h"

@interface CMTracker : PFObject<PFSubclassing,MKAnnotation>

@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) CMOrder *order;

+ (CMTracker *)createNewTrackerWithCoordinate:(CLLocationCoordinate2D)coordinate withOrder:(CMOrder *)order withBlock:(void (^)(BOOL,CMTracker*))completionBlock;
- (CLLocationCoordinate2D)coordinate;

@end
