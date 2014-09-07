//
//  CMSellerMapViewController.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CMLocationPoller.h"
#import "CMTracker.h"
#import "CMCampaign.h"

@interface CMSellerMapViewController : UITableViewController<MKMapViewDelegate, CMLocationPollerDelegate>

@property CMLocationPoller *locationPoller;
@property CMTracker *tracker;
@property CMOrder *order;
@property NSString *travelTime;
@property BOOL isInitialized;

- (id) initWithTracker:(CMTracker*)tracker andOrder:(CMOrder*)order ;

@end
