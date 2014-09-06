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

const NSInteger CMMapViewSection = 0;
const NSInteger CMInfoSection = 1;
const NSInteger CMDeliveryAddressSection = 2;
const NSInteger CMCallButtonSection = 3;

static NSString *CMMapViewIdentifier = @"CMMapViewTableViewCell";
static NSString *CMInfoIdentifier = @"CMInfoTableViewCell";
static NSString *CMDeliveryAddressIdentifier = @"CMDeliveryAddressTableViewCell";
static NSString *CMCallButtonIdentifier = @"CMCallButtonTableViewCell";

@implementation CMSellerMapViewController

- (id) initWithTracker:(CMTracker*)tracker andCampaign:(CMCampaign*)campaign {
    self = [super initWithNibName:nil bundle:nil];
    if (self){
        _tracker = tracker;
        _campaign = campaign;
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
        [self.tableView registerClass:[CMDeliveryAddressTableViewCell class] forCellReuseIdentifier:CMDeliveryAddressIdentifier];
        [self.tableView registerClass:[CMCallButtonTableViewCell class] forCellReuseIdentifier:CMCallButtonIdentifier];
        
        self.title = @"Directions";
        
        _locationPoller = [[CMLocationPoller alloc] init];
        _isInitialized = NO;
        _travelTime = @"";
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
    } else if (indexPath.section == CMDeliveryAddressSection) {
        return 42;
    } else if (indexPath.section == CMCallButtonSection) {
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
        }
        
    }];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mapView.delegate = self;
        return cell;
    } else if (indexPath.section == CMInfoSection) {
        CMMapInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMInfoIdentifier];
        [cell setupViewForUser:_campaign.owner];
        return cell;
    } else if (indexPath.section == CMDeliveryAddressSection) {
        CMDeliveryAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMDeliveryAddressIdentifier];
        cell.currentAddress.text = @"Michigan University";
        cell.estimatedTime.text = [NSString stringWithFormat:@"Est %d min", 2];
        return cell;
    } else if (indexPath.section == CMCallButtonSection) {
        CMCallButtonTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMCallButtonIdentifier];
        return cell;
    }
    return nil;
}

- (void) locationPollerDidUpdateLocationForPFObject:(PFObject *)object {
    if ([object isEqual:_tracker]) {
        PFGeoPoint *point = object[@"location"];
        [CMUtil getEstimatedTravelTimeFrom:point block:^(NSString *eta) {
            _travelTime = eta;
            [self refreshTravelTime];
        }];
    }
}

- (void)callButtonPressed:(id)sender {
    
}

- (void) refreshTravelTime {
}



@end
