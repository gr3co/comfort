//
//  CMDeliveryAddressTableViewCell.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMDeliveryAddressTableViewCell;

@interface CMDeliveryAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) UILabel *currentAddress;
@property (nonatomic, strong) UILabel *estimatedTime;
@property (nonatomic, weak) id<CMDeliveryAddressTableViewCell> delegate;

@end

@protocol CMDeliveryAddressTableViewCell

@required

-(void)addressButtonPressed:(id)sender;

@end
