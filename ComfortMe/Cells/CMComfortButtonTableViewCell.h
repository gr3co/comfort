//
//  CMComfortButtonTableViewCell.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMComfortButtonTableViewCell;

@interface CMComfortButtonTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *comfortButton;
@property (nonatomic, weak) id<CMComfortButtonTableViewCell> delegate;

@end

@protocol CMComfortButtonTableViewCell

@required

-(void)comfortButtonPressed:(id)sender;

@end
