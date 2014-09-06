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
#import "CMTracker.h"

@interface CMUserMapViewController : UIViewController<CMLocationPollerDelegate, MKMapViewDelegate>

@property MKMapView *mapView;
@property CMLocationPoller *locationPoller;
@property CMTracker *tracker;
@property NSString *travelTime;
@property BOOL isInitialized;

@end
