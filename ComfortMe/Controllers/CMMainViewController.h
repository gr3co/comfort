
//  CMMainViewController.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/5/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"


@interface CMMainViewController : UITableViewController

@property (nonatomic, readonly, getter=isFullscreen) BOOL fullscreen;
@property (nonatomic, readonly, getter=isTransitioning) BOOL transitioning;

@property NSMutableArray *campaigns;

@end
