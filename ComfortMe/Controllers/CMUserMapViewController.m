//
//  CMUserMapViewController.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMUserMapViewController.h"
#import "CMMapPin.h"
#import "CMUtil.h"

@implementation CMUserMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _locationPoller = [[CMLocationPoller alloc] init];
        _isInitialized = NO;
        _travelTime = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    _mapView = [[MKMapView alloc] initWithFrame:
                    CGRectMake(0, 0, width, 1.2 * width)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    if (_isInitialized) {
        [_locationPoller stopRefreshingLocationWithPFObject:_tracker];
        _isInitialized = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate,
                                                           MKCoordinateSpanMake(0.02, 0.02));
    [UIView animateWithDuration:0.5 delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            
        [mapView setRegion:region animated:NO];
            
    } completion:^(BOOL finished){}];
}

- (void) initializeTracker:(PFObject *)tracker {
    if (!_isInitialized) {
        _tracker = tracker;
        [_locationPoller refreshLocationWithPFObject:tracker everyNumSeconds:5];
        _isInitialized = YES;
    }
}

- (void) locationPollerDidRefreshLocationForPFObject:(PFObject *)object {
    if ([object isEqual:_tracker]) {
        PFGeoPoint *point = object[@"location"];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(point.latitude, point.longitude);
        if (_pin) {
            [_pin setCoordinate:coord];
        } else {
            _pin = [[CMMapPin alloc] initWithCoordinate:coord];
            [_mapView addAnnotation:_pin];
        }
        [CMUtil getEstimatedTravelTimeFrom:point block:^(NSString *eta) {
            _travelTime = eta;
            [self refreshTravelTime];
        }];
    }
}

- (void) refreshTravelTime {}

@end
