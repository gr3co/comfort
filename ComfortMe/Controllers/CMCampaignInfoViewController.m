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

const NSInteger CMHomeCampaignSection = 0;
const NSInteger CMMoreInfoSection = 1;
const NSInteger CMDeliveryAddressSection = 2;
const NSInteger CMComfortButtonSection = 3;

static NSString *CMHomeCampaignIdentifier = @"CMHomeCampaignTableViewCell";
static NSString *CMMoreInfoIdentifier = @"CMMoreInfoTableViewCell";
static NSString *CMDeliveryAddressIdentifier = @"CMDeliveryAddressTableViewCell";
static NSString *CMComfortButtonIdentifier = @"CMComfortButtonTableViewCell";

@interface CMCampaignInfoViewController ()<APParallaxViewDelegate>

@end

@implementation CMCampaignInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
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
        return 162;
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
        cell.priceLabel.text = [NSString stringWithFormat:@"$%d", _campaign.price];
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

@end
