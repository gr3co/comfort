//
//  CMSellerMapViewController.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMSellerMapViewController.h"
#import "CMMapViewTableViewCell.h"
#import "CMMapInfoTableViewCell.h"
#import "CMCallButtonTableViewCell.h"
#import "CMDeliveryAddressTableViewCell.h"
#import "CMUtil.h"
#import "CMEndTripButtonTableViewCell.h"
#import "CMMainViewController.h"

const NSInteger CMMapViewSection = 0;
const NSInteger CMInfoSection = 1;
const NSInteger CMSellDeliveryAddressSection = 2;
const NSInteger CMEndTripButtonSection = 3;

static NSString *CMMapViewIdentifier = @"CMMapViewTableViewCell";
static NSString *CMInfoIdentifier = @"CMInfoTableViewCell";
static NSString *CMSellDeliveryAddressIdentifier = @"CMSellDeliveryAddressTableViewCell";
static NSString *CMEndTripButtonIdentifier = @"CMEndTripButtonTableViewCell";

@interface CMSellerMapViewController()<CMRateViewController> {
    MKMapView *mainMapView;
    
}

@end

@implementation CMSellerMapViewController {
    CMMapInfoTableViewCell *infoCell;
}

- (id) initWithTracker:(CMTracker*)tracker andOrder:(CMOrder*)order {
    self = [super initWithNibName:nil bundle:nil];
    if (self){
        _tracker = tracker;
        UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"PhoneIcon"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(call)];
        
        rbb.tintColor = UIColorFromRGB(0xC3C3C3);
        self.navigationItem.rightBarButtonItem = rbb;
        _order = order;
        mainMapView.delegate = self;
        
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0xFBFBFB);
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.tableView registerClass:[CMMapViewTableViewCell class] forCellReuseIdentifier:CMMapViewIdentifier];
        [self.tableView registerClass:[CMMapInfoTableViewCell class] forCellReuseIdentifier:CMInfoIdentifier];
        [self.tableView registerClass:[CMDeliveryAddressTableViewCell class] forCellReuseIdentifier:CMSellDeliveryAddressIdentifier];
        [self.tableView registerClass:[CMCallButtonTableViewCell class] forCellReuseIdentifier:CMEndTripButtonIdentifier];
        
        self.title = @"Directions";
        
        _locationPoller = [[CMLocationPoller alloc] init];
        _locationPoller.delegate = self;
        _isInitialized = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    if (_isInitialized) {
        [_locationPoller stopUpdatingLocationWithPFObject:_tracker];
        _isInitialized = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CMMapViewSection) {
        if (iPhone5) {
            return 1.1 * self.view.frame.size.width - 42;
        }
        else {
            return .9 * self.view.frame.size.width - 42;
        }
    } else if (indexPath.section == CMInfoSection) {
        if (iPhone5) {
            return self.view.frame.size.height - 1.1 * self.view.frame.size.width - 52;
        } else {
            return self.view.frame.size.height - .9 * self.view.frame.size.width - 52;
        }
    } else if (indexPath.section == CMSellDeliveryAddressSection) {
        return 42;
    } else if (indexPath.section == CMEndTripButtonSection) {
        return 52;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate,
                                                       MKCoordinateSpanMake(0.02, 0.02));
    [UIView animateWithDuration:0.5 delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
        [mapView setRegion:region animated:NO];
        
    } completion:^(BOOL finished){
        if (!_isInitialized) {
            [_locationPoller updateLocationWithPFObject:_tracker everyNumSeconds:5];
            
            [mapView addAnnotation:_tracker];
            
            _isInitialized = YES;
            
            [[[CLGeocoder alloc] init] geocodeAddressString: _order.destAddress
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             CLPlacemark *mark = placemarks[0];
                             [_tracker setCoordinate:mark.location.coordinate];
                             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                 MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
                                 [request setSource:[MKMapItem mapItemForCurrentLocation]];
                                 MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:
                                                    [[MKPlacemark alloc] initWithPlacemark:mark]];
                                 [request setDestination: item];
                                 [request setTransportType:MKDirectionsTransportTypeAny];
                                 [request setRequestsAlternateRoutes:NO];
                                 MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
                                 [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error){
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         if (!error) {
                                             _travelTime = [CMUtil convertTravelTimeToString:[[response routes][0] expectedTravelTime]];
                                             [self refreshTravelTime];
                                             for (MKRoute *route in [response routes]) {
                                                 [mainMapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
                                             }
                                         }
                                     });
                                 }];
                             });
                         }];
        }
        
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
    } else {
        return nil;
    }
}
- (MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // Just always return a pin for now
    return nil;
    
    if (annotation == mapView.userLocation) {
        return nil;
    }
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title];
    view.canShowCallout = NO;
    view.image = imageWithSize([UIImage imageNamed:@"MapPersonIcon"], CGSizeMake(24,45));
    return view;
}

static UIImage* imageWithSize(UIImage *image, CGSize newSize) {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CMMapViewSection) {
        CMMapViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMMapViewIdentifier];
        if (cell == nil) {
            cell = [[CMMapViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMMapViewIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mapView.delegate = self;
        }
        return cell;
    } else if (indexPath.section == CMInfoSection) {
        CMMapInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMInfoIdentifier];
        if (cell == nil) {
            cell = [[CMMapInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMInfoIdentifier];
            [cell setupViewForUser:_order.owner];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            infoCell = cell;
            [CMUtil getEstimatedTravelTimeFrom:_order.destGeo block:^(NSString *eta) {
                _travelTime = eta;
                cell.etaLabel.text = eta;
            }];
        }
        return cell;
    } else if (indexPath.section == CMSellDeliveryAddressSection) {
        CMDeliveryAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMSellDeliveryAddressIdentifier];
        if (cell == nil) {
            cell = [[CMDeliveryAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMSellDeliveryAddressIdentifier];
            cell.currentAddress.text = _order.destAddress;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    } else if (indexPath.section == CMEndTripButtonSection) {
        CMEndTripButtonTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMEndTripButtonIdentifier];
        if (cell == nil) {
            cell = [[CMEndTripButtonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMEndTripButtonIdentifier];
        }
        return cell;
    }
    return nil;
}

- (void) locationPollerDidUpdateLocationForPFObject {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        [request setSource:[MKMapItem mapItemForCurrentLocation]];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_tracker.coordinate addressDictionary:@{}]];
        [request setDestination: item];
        [request setTransportType:MKDirectionsTransportTypeAny];
        [request setRequestsAlternateRoutes:NO];
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) {
                    _travelTime = [CMUtil convertTravelTimeToString:[[response routes][0] expectedTravelTime]];
                    [self refreshTravelTime];
                    for (MKRoute *route in [response routes]) {
                        [mainMapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
                    }
                }
            });
        }];
    });

}

- (void)callButtonPressed:(id)sender {
    NSString *phNo = @"+19255968005";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Cannot make phone call" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (void) refreshTravelTime {
    infoCell.etaLabel.text = _travelTime;
    [infoCell.etaLabel setNeedsDisplay];
}

-(void)endTripButtonPressed:(id)sender {
    NSLog(@"End trip pressed");
    [_tracker deactivate];
    CMRateViewController *ratingVC = [[CMRateViewController alloc] init];
    ratingVC.delegate = self;
    CMCampaign *campaign = [_order campaign];
    [campaign fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        CMCampaign *thisCampaign = (CMCampaign *)object;
        [thisCampaign setObject:[NSNumber numberWithBool:YES] forKey:@"isAvailable"];
        [thisCampaign saveInBackground];
    }];
    [self presentViewController:ratingVC animated:YES completion:nil];
}

- (void)call {
    // MAKE PHONE CALL?
}

- (void)ratingDoneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    CMMainViewController *mainVC = [[CMMainViewController alloc] init];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)updateRating:(float)rating {
    _rating = rating;
    [_order setObject:[NSNumber numberWithFloat:rating] forKey:@"rating"];
    [_order saveInBackground];
}


@end
