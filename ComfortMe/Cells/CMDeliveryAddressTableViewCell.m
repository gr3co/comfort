//
//  CMDeliveryAddressTableViewCell.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMDeliveryAddressTableViewCell.h"

@implementation CMDeliveryAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btnImage = [UIImage imageNamed:@"AddressButton"];
        [_addressButton setImage:btnImage forState:UIControlStateNormal];
        _addressButton.contentMode = UIViewContentModeScaleToFill;
        _addressButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 10);
        
        [_addressButton addTarget:_delegate action:@selector(addressButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_addressButton];
    }
    return self;
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
