//
//  CMIncomingOrder.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol CMIncomingOrderView;

@interface CMIncomingOrderView : UIView

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) PFImageView *avatarImageView;
@property (strong, nonatomic) UILabel *milesLabel;
@property (strong, nonatomic) UIButton *acceptButton;
@property (strong, nonatomic) UIButton *declineButton;

@property (nonatomic, weak) id<CMIncomingOrderView> delegate;


@end

@protocol CMIncomingOrderView

@required

-(void)acceptButtonPressed:(id)sender;
-(void)declineButtonPressed:(id)sender;

@end