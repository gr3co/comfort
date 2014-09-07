//
//  CMCampaignInfoViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCampaignInfoViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "CMHomeCampaignTableViewCell.h"
#import "CMMoreInfoTableViewCell.h"
#import "CMDeliveryAddressTableViewCell.h"
#import "CMComfortButtonTableViewCell.h"
#import "CMCampaign.h"
#import "CMOrder.h"
#import "CMAddressSearchViewController.h"
#import "MBProgressHUD.h"
#import "CMMenuNavigationController.h"
#import "CMUserMapViewController.h"
#import "CMColors.h"
#import "INTULocationManager.h"
#import "CMUtil.h"

const NSInteger CMHomeCampaignSection = 0;
const NSInteger CMMoreInfoSection = 1;
const NSInteger CMDeliveryAddressSection = 2;
const NSInteger CMComfortButtonSection = 3;

static NSString *CMHomeCampaignIdentifier = @"CMHomeCampaignTableViewCell";
static NSString *CMMoreInfoIdentifier = @"CMMoreInfoTableViewCell";
static NSString *CMDeliveryAddressIdentifier = @"CMDeliveryAddressTableViewCell";
static NSString *CMComfortButtonIdentifier = @"CMComfortButtonTableViewCell";

@interface CMCampaignInfoViewController ()<APParallaxViewDelegate, CMComfortButtonTableViewCell, CMDeliveryAddressTableViewCell> {
    CMDeliveryAddressTableViewCell *addressCell;
    MBProgressHUD *hud;
    CMTracker *globalTracker;
    PFGeoPoint *destGeo;
    NSString *destAddress;
    NSString *destTime;
}

@end

@implementation CMCampaignInfoViewController

- (id)initWithCampaign:(CMCampaign *)campaign
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        _campaign = campaign;
        [self getAddressOfCurrentLocation:^(NSString *address, NSString *dTime) {
            destAddress = address;
            destTime = dTime;
            [self.tableView reloadData];
        }];
        self.view.backgroundColor = UIColorFromRGB(0xFBFBFB);
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.tableView addParallaxWithImage:[_campaign headerImage]  andHeight:187];
        [self.tableView.parallaxView setDelegate:self];
        
        [self.tableView registerClass:[CMHomeCampaignTableViewCell class] forCellReuseIdentifier:CMHomeCampaignIdentifier];
        [self.tableView registerClass:[CMMoreInfoTableViewCell class] forCellReuseIdentifier:CMMoreInfoIdentifier];
        [self.tableView registerClass:[CMDeliveryAddressTableViewCell class] forCellReuseIdentifier:CMDeliveryAddressIdentifier];
        [self.tableView registerClass:[CMComfortButtonTableViewCell class] forCellReuseIdentifier:CMComfortButtonIdentifier];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [CMColors mainColor]};
    self.title = @"More Information";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CMHomeCampaignSection) {
        return 60;
    } else if (indexPath.section == CMMoreInfoSection) {
        return 163;
    } else if (indexPath.section == CMDeliveryAddressSection) {
        return 42;
    } else if (indexPath.section == CMComfortButtonSection) {
        return 52;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TEST CREATE CM CAMPAIGN
    if (indexPath.section == CMHomeCampaignSection) {
        CMHomeCampaignTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMHomeCampaignIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.avatarImageView.image = [_campaign avatarImage];
        cell.descriptionLabel.text = [_campaign desc];
        cell.priceLabel.text = [_campaign priceString];
        return cell;
    } else if (indexPath.section == CMMoreInfoSection) {
        CMMoreInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMMoreInfoIdentifier];
        cell.moreInfoDescription.text = [_campaign info];
        return cell;
    } else if (indexPath.section == CMDeliveryAddressSection) {
        CMDeliveryAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMDeliveryAddressIdentifier];
        addressCell = cell;
        cell.currentAddress.text = destAddress;
        cell.estimatedTime.text = destTime;
        return cell;
    } else if (indexPath.section == CMComfortButtonSection) {
        CMComfortButtonTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMComfortButtonIdentifier];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CMDeliveryAddressSection) {
        CMAddressSearchViewController *addressSearchVC = [[CMAddressSearchViewController alloc] init];
        addressSearchVC.delegate = self;
        CMMenuNavigationController *navController =
        [[CMMenuNavigationController alloc] initWithRootViewController:addressSearchVC];
        [self presentViewController:navController animated:YES completion:nil];
    }
}



#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

#pragma mark - Navigation Bar

- (void)initNavBar
{
   // self.navigationItem.title = @"More Information";
    
}

#pragma mark - Comfort Button Delegate

- (void)comfortButtonPressed:(id)sender {
    NSLog(@"Comfort Button Pressed");
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Contacting...";
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.progress = 0;

    CMOrder *newOrder = [CMOrder createNewOrderWithCampaign:_campaign
                                                 withSeller:[_campaign owner]
                                                 withGeo:destGeo
                                                withAddress:destAddress];
    [CMUtil attemptOrder:newOrder withBlock:^(BOOL accepted, CMTracker *tracker) {
        globalTracker = tracker;
        NSDictionary *userInfo = @{@"order":newOrder, @"tracker":tracker};
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkForTracker:)
                                       userInfo:userInfo repeats:YES];
    }];
}

- (void) checkForTracker: (NSTimer*) sender {
    hud.progress += 0.083333;
    NSDictionary *userInfo = sender.userInfo;
    CMOrder *currentOrder = userInfo[@"order"];
    CMTracker *currentTracker = userInfo[@"tracker"];
    [currentOrder refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (hud.progress >= 1.0) {
            [sender invalidate];
            [hud hide:YES];
            [currentOrder deleteInBackground];
            [currentTracker deleteInBackground];
        } else if ([(NSNumber*)object[@"isAccepted"] boolValue]) {
            [sender invalidate];
            [hud hide:YES afterDelay:1.0];
            [currentTracker refresh];
            CMUserMapViewController *map = [[CMUserMapViewController alloc] initWithNibName:nil bundle:nil];
            map.tracker = currentTracker;
            [currentTracker.campaign fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                map.campaign = (CMCampaign*)object;
                [self.navigationController pushViewController:map animated:YES];
            }];
        }
    }];
}

#pragma mark - Address Button Touched


- (void)addressButtonPressed:(id)sender {
    NSLog(@"Address Button Pressed");
}

- (void) getAddressOfCurrentLocation:(void (^)(NSString *address, NSString *dTime))completionBlock;

{
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            CLLocation *currentloc = [[CLLocation alloc] initWithLatitude:geoPoint.latitude longitude:geoPoint.longitude];
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder reverseGeocodeLocation:currentloc completionHandler:^(NSArray *placemarks, NSError *error)
             {
                 if(placemarks && placemarks.count > 0)
                 {
                     CLPlacemark *placemark= [placemarks objectAtIndex:0];
                     // address defined in .h file
                     destGeo = geoPoint;
                     NSString *address = [NSString stringWithFormat:@"%@ , %@ , %@, %@", [placemark thoroughfare], [placemark locality], [placemark administrativeArea], [placemark country]];
                     NSLog(@"New Address Is:%@", address);
                     completionBlock(address, @"2 min");
                 }
             }];
        }
    }];
    
}

#pragma mark - Notification Center

- (void)orderAccepted:(id)object
{
    [hud hide:YES];
    CMUserMapViewController *map = [[CMUserMapViewController alloc] initWithNibName:nil bundle:nil];
    map.tracker = globalTracker;
    map.campaign = _campaign;
    [self.navigationController pushViewController:map animated:YES];
}

- (void) setSelectedAddress:(NSString *)address {
    destAddress = address;
    addressCell.currentAddress.text = address;
    [addressCell.currentAddress setNeedsDisplay];
}

@end
