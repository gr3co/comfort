//
//  CMRateViewController.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@protocol CMRateViewController;

@interface CMRateViewController : UIViewController<RateViewDelegate> {
}

@property (nonatomic, weak) id<CMRateViewController> delegate;

@end

@protocol CMRateViewController

@required

-(void)ratingDoneButtonPressed:(id)sender;

@end