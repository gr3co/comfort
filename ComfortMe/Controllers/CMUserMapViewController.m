//
//  CMUserMapViewController.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMUserMapViewController.h"
#import "CMMapViewTableViewCell.h"
#import "CMMapInfoTableViewCell.h"
#import "CMCallButtonTableViewCell.h"
#import "CMUtil.h"
#import "CMRateViewController.h"
#import "CMMainViewController.h"

const NSInteger CMUserMapViewSection = 0;
const NSInteger CMUserInfoSection = 1;
const NSInteger CMUserCallButtonSection = 2;

static NSString *CMUserMapViewIdentifier = @"CMUserMapViewTableViewCell";
static NSString *CMUserInfoIdentifier = @"CMUserInfoTableViewCell";
static NSString *CMUserCallButtonIdentifier = @"CMUserCallButtonTableViewCell";

@interface CMUserMapViewController()<CMRateViewController> {
    
}

@end

@implementation CMUserMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0xFBFBFB);
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.tableView registerClass:[CMMapViewTableViewCell class] forCellReuseIdentifier:CMUserMapViewIdentifier];
        [self.tableView registerClass:[CMMapInfoTableViewCell class] forCellReuseIdentifier:CMUserInfoIdentifier];
        [self.tableView registerClass:[CMCallButtonTableViewCell class] forCellReuseIdentifier:CMUserCallButtonIdentifier];
        
        self.title = @"Where am I?";
        
        _locationPoller = [[CMLocationPoller alloc] init];
        _locationPoller.delegate = self;
        _isInitialized = NO;
        _travelTime = @"";
        
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 120/2, 70, 120, 120)];
        avatar.image = [UIImage imageNamed:@"TempAvatarLarge"];
        [self.view addSubview:avatar];
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
        [_locationPoller stopRefreshingLocationWithPFObject:_tracker];
        _isInitialized = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CMUserMapViewSection) {
        if (iPhone5) {
            return 1.1 * self.view.frame.size.width;
        }
        else {
            return .9 * self.view.frame.size.width;
        }
    } else if (indexPath.section == CMUserInfoSection) {
        if (iPhone5) {
            return self.view.frame.size.height - 1.1 * self.view.frame.size.width - 52;
        } else {
            return self.view.frame.size.height - .9 * self.view.frame.size.width - 52;
        }
    } else if (indexPath.section == CMUserCallButtonSection) {
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
            [_locationPoller refreshLocationWithPFObject:_tracker everyNumSeconds:5];
            
            [mapView addAnnotation:_tracker];
            
            _isInitialized = YES;
        }
        
    }];
}

- (MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
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
    if (indexPath.section == CMUserMapViewSection) {
        CMMapViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMUserMapViewIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mapView.delegate = self;
        return cell;
    } else if (indexPath.section == CMUserInfoSection) {
        CMMapInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMUserInfoIdentifier];
        [cell setupViewForUser:_campaign.owner];
        return cell;
    } else if (indexPath.section == CMUserCallButtonSection) {
        CMCallButtonTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMUserCallButtonIdentifier];
        return cell;
    }
    return nil;
}

- (void) locationPollerDidRefreshLocationForPFObject:(PFObject *)object {
    if ([object isEqual:_tracker]) {
        PFGeoPoint *point = object[@"location"];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(point.latitude, point.longitude);
        [_tracker setCoordinate:coord];
        [CMUtil getEstimatedTravelTimeFrom:point block:^(NSString *eta) {
            _travelTime = eta;
            [self refreshTravelTime];
        }];
    }
}

- (void)callButtonPressed:(id)sender {

}

- (void) refreshTravelTime {}

// call this when trip ends
- (void)tripEnded
{
    CMRateViewController *ratingVC = [[CMRateViewController alloc] init];
    ratingVC.delegate = self;
    [_campaign fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        CMCampaign *thisCampaign = (CMCampaign *)object;
        [thisCampaign setObject:[NSNumber numberWithBool:YES] forKey:@"isAvailable"];
        [thisCampaign saveInBackground];
    }];
    [self presentViewController:ratingVC animated:YES completion:nil];
}

#pragma mark - RateViewControllerDelegate methods
- (void)ratingDoneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    CMMainViewController *mainVC = [[CMMainViewController alloc] init];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)updateRating:(float)rating {
    _rating = rating;
//    [_order setObject:[NSNumber numberWithFloat:rating] forKey:@"rating"];
//    [_order saveInBackground];
}




@end
