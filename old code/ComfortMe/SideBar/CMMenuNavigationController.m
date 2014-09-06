//
//  CMMenuNavigationController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/5/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMMenuNavigationController.h"
#import "REFrostedViewController.h"

@interface CMMenuNavigationController ()

@property (strong, readwrite, nonatomic) CMMenuNavigationController *menuViewController;

@end

@implementation CMMenuNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}


@end
