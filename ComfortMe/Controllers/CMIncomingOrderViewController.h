//
//  CMIncomingOrderViewController.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMOrder.h"

@interface CMIncomingOrderViewController : UIViewController

@property CMOrder *order;

- (id) initWithOrder:(CMOrder *) order;

@end
