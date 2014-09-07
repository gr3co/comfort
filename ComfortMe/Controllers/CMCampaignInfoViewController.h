//
//  CMCampaignInfoViewController.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"
#import "CMCampaign.h"
#import "CMAddressSearchViewController.h"

@interface CMCampaignInfoViewController : UITableViewController<CMAddressSearchDelegate>

@property (strong, nonatomic) CMCampaign *campaign;
@property (strong, nonatomic) CLLocation *currentLocation;

- (id)initWithCampaign:(CMCampaign *)campaign;
@end
