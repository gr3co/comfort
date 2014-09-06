//
//  CMMapInfoTableViewCell.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMMapInfoTableViewCell.h"

@implementation CMMapInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        PFImageView *imageView = [[PFImageView alloc] initWithFrame:
                                  CGRectMake(20, self.contentView.frame.size.height / 2 - 5, 60, 60) ];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 30.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:
                          CGRectMake(48, self.contentView.frame.size.height / 2 - 10, self.frame.size.width - 50, 50)];
        label.font = [UIFont fontWithName:@"Avenir" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentLeft;
        
        UILabel *etaLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(25, self.contentView.frame.size.height / 2 + 20, self.frame.size.width - 50, 50)];
        etaLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:14];
        etaLabel.backgroundColor = [UIColor clearColor];
        etaLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        etaLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        etaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        etaLabel.textAlignment = NSTextAlignmentLeft;
        etaLabel.text = @"5 minutes away";
        
        
        _profileImageView = imageView;
        _profileNameLabel = label;
        _etaLabel = etaLabel;
        
        [self.contentView addSubview:_profileImageView];
        [self.contentView addSubview:_profileNameLabel];
        [self.contentView addSubview:_etaLabel];
        
    }
    return self;
}

- (void) setupViewForUser: (PFUser *) user
{
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        _profileImageView.file = [object objectForKey:@"fbProfilePic"];
        [_profileImageView loadInBackground];
        _profileNameLabel.text = [object objectForKey:@"fbName"];
    }];
}

@end
