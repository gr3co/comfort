//
//  CMHomeCampaignTableViewCell.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CMHomeCampaignTableViewCell : UITableViewCell

@property (nonatomic, strong) PFImageView *avatarImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end
