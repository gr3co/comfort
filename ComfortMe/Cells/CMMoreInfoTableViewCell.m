//
//  CMMoreInfoTableViewCell.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMMoreInfoTableViewCell.h"
#import "CMColors.h";

@interface CMMoreInfoTableViewCell() {
    UILabel *moreInfoLabel;
}

@end

@implementation CMMoreInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupMoreInfoLabel];
        [self setupMoreInfoDescription];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupMoreInfoLabel
{
    moreInfoLabel = [[UILabel alloc] init];
    moreInfoLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    moreInfoLabel.textColor = [CMColors mainColor];
    moreInfoLabel.text = @"More Information";
    moreInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:moreInfoLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(moreInfoLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[moreInfoLabel]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[moreInfoLabel]" options:0 metrics:nil views:views]];
}

- (void)setupMoreInfoDescription
{
    _moreInfoDescription = [[UILabel alloc] init];
    _moreInfoDescription.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _moreInfoDescription.textColor = UIColorFromRGB(0x1E1E1E);
    _moreInfoDescription.translatesAutoresizingMaskIntoConstraints = NO;
    _moreInfoDescription.numberOfLines = 0;
    _moreInfoDescription.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self.contentView addSubview:_moreInfoDescription];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(moreInfoLabel, _moreInfoDescription);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_moreInfoDescription]-20-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[moreInfoLabel]-10-[_moreInfoDescription]" options:0 metrics:nil views:views]];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
