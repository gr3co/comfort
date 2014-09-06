//
//  CMPaymentViewController.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKView.h"

@interface CMPaymentViewController : UIViewController<PKViewDelegate>
@property (strong, nonatomic) PKView* paymentView;

@end
