//
//  CMMapInfoTableViewCell.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CMMapInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) PFImageView *profileImageView;
@property (nonatomic, strong) UILabel *profileNameLabel;
@property (nonatomic, strong) UILabel *etaLabel;


@end
