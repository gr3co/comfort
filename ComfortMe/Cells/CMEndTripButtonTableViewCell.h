//
//  CMEndTripButtonTableViewCell.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMEndTripButtonDelegate;

@interface CMEndTripButtonTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *endTripButton;
@property (nonatomic, weak) id<CMEndTripButtonDelegate> delegate;

@end

@protocol CMCallButtonDelegate

@required

-(void)endTripButtonPressed:(id)sender;

@end

