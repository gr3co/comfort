//
//  CMMainViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/5/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "CMMainViewController.h"
#import "UIScrollView+APParallaxHeader.h"

@interface CMMainViewController ()

@end

@implementation CMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
