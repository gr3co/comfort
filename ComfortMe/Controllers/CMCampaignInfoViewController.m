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

const NSInteger CMHomeCampaignSection = 0;
const NSInteger CMMoreInfoSection = 1;
const NSInteger CMDeliveryAddressSection = 2;
const NSInteger CMComfortButtonSection = 3;

static NSString *CMHomeCampaignIdentifier = @"CMHomeCampaignTableViewCell";
static NSString *CMMoreInfoIdentifier = @"CMMoreInfoTableViewCell";
static NSString *CMDeliveryAddressIdentifier = @"CMDeliveryAddressTableViewCell";
static NSString *CMComfortButtonIdentifier = @"CMComfortButtonTableViewCell";

@interface CMCampaignInfoViewController ()<APParallaxViewDelegate, CMComfortButtonTableViewCell, CMDeliveryAddressTableViewCell>

@end

@implementation CMCampaignInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = UIColorFromRGB(0xFBFBFB);
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.tableView addParallaxWithImage:[UIImage imageNamed:@"HeaderKitten"] andHeight:187];
        [self.tableView.parallaxView setDelegate:self];
        
        [self.tableView registerClass:[CMHomeCampaignTableViewCell class] forCellReuseIdentifier:CMHomeCampaignIdentifier];
        [self.tableView registerClass:[CMMoreInfoTableViewCell class] forCellReuseIdentifier:CMMoreInfoIdentifier];
        [self.tableView registerClass:[CMDeliveryAddressTableViewCell class] forCellReuseIdentifier:CMDeliveryAddressIdentifier];
        [self.tableView registerClass:[CMComfortButtonTableViewCell class] forCellReuseIdentifier:CMComfortButtonIdentifier];
    }
    return self;
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
        cell.avatarImageView.image = _campaign.avatar;
        cell.descriptionLabel.text = _campaign.description;
        cell.priceLabel.text = [NSString stringWithFormat:@"$%ld", (unsigned long)_campaign.price];
        return cell;
    } else if (indexPath.section == CMMoreInfoSection) {
        CMMoreInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMMoreInfoIdentifier];
        cell.moreInfoDescription.text = _campaign.moreInfo;
        return cell;
    } else if (indexPath.section == CMDeliveryAddressSection) {
        CMDeliveryAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMDeliveryAddressIdentifier];
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
        [self presentViewController:addressSearchVC animated:YES completion:nil];
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
   self.navigationItem.title = @"More Information";
    
}

#pragma mark - Comfort Button Delegate

- (void)comfortButtonPressed:(id)sender {
    NSLog(@"Comfort Button Pressed");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Contacting...";
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.progress = 0;
    
    PFObject *campaignParse = [_campaign getParseObject];
    PFObject *newOrder = [CMOrder newOrder];
    PFUser *seller = campaignParse[@"user"];
    newOrder[@"seller"] = seller;
    newOrder[@"campaign"] = campaignParse;
    [CMOrder attemptOrder:newOrder withBlock:^(BOOL accepted) {
        // Do something
    }];
}

#pragma mark - Address Button Touched


- (void)addressButtonPressed:(id)sender {
    NSLog(@"Address Button Pressed");
}



@end
