//
//  CMCallButtonTableViewCell.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMCallButtonDelegate;

@interface CMCallButtonTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, weak) id<CMCallButtonDelegate> delegate;

@end

@protocol CMCallButtonDelegate

@required

-(void)callButtonPressed:(id)sender;

@end

