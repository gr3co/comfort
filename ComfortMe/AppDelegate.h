//
//  AppDelegate.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/5/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "CMMenuNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CMMenuNavigationController *navigationController;

@end
