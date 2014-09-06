//
//  CMDeliveryAddressTableViewCell.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMDeliveryAddressTableViewCell.h"

@interface CMDeliveryAddressTableViewCell() {
    UIImageView *pin;
}

@end

@implementation CMDeliveryAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupPin];
        [self setupEstimatedTime];
        [self setupCurrentAddress];
    }
    return self;
}

- (void)setupPin
{
    pin = [[UIImageView alloc] init];
    pin.image = [UIImage imageNamed:@"Pin"];
    pin.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:pin];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pin);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[pin]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[pin]" options:0 metrics:nil views:views]];
}

- (void)setupEstimatedTime
{
    _estimatedTime = [[UILabel alloc] init];
    
    _estimatedTime = [[UILabel alloc] init];
    _estimatedTime.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _estimatedTime.textColor = UIColorFromRGB(0x959595);
    _estimatedTime.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_estimatedTime];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_estimatedTime);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_estimatedTime]-20-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_estimatedTime]" options:0 metrics:nil views:views]];
}

- (void)setupCurrentAddress
{
    _currentAddress = [[UILabel alloc] init];
    _currentAddress.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    _currentAddress.textColor = UIColorFromRGB(0x4E4E4E);
    _currentAddress.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_currentAddress];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pin, _currentAddress);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pin]-20-[_currentAddress]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_currentAddress]" options:0 metrics:nil views:views]];
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
