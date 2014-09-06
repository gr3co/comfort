//
//  CMUserMapViewController.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CMLocationPoller.h"

@interface CMUserMapViewController : UIViewController<CMLocationPollerDelegate, MKMapViewDelegate>

@property MKMapView *mapView;
@property CMLocationPoller *locationPoller;
@property id<MKAnnotation> pin;
@property PFObject *tracker;
@property NSString *travelTime;
@property BOOL isInitialized;

- (void) initializeTracker:(PFObject *)tracker;

@end
