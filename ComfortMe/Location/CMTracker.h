//
//  CMTracker.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface CMTracker : PFObject<PFSubclassing,MKAnnotation>

@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSString *name;

+ (CMTracker *)createNewTrackerWithCoordinate:(PFGeoPoint*)point withBlock:(void (^)(NSError*,CMTracker*))completionBlock;
- (CLLocationCoordinate2D)coordinate;

@end
