//
//  CMIncomingOrderViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMIncomingOrderViewController.h"
#import "CMIncomingOrderView.h"

@interface CMIncomingOrderViewController ()<CMIncomingOrderView> {
    CMIncomingOrderView *orderView;
}

@end

@implementation CMIncomingOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        orderView = [[CMIncomingOrderView alloc] initWithFrame:self.view.bounds];
        self.view = orderView;
        [self setupName];
        [self setupAvatar];
        [self setupMiles];
        
    }
    return self;
}

- (void)setupName
{
    orderView.nameLabel.text = [NSString stringWithFormat:@"Lucy Guo \nneeds comforting!"];
}

- (void)setupAvatar
{
    orderView.avatarImageView.image = [UIImage imageNamed:@"TempAvatarLarge"];
}

- (void)setupMiles
{
    orderView.milesLabel.text = [NSString stringWithFormat:@"%.01f miles away", 2.5];
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

#pragma mark - Delegate methods
-(void)acceptButtonPressed:(id)sender
{
    NSLog(@"Accept Button Pressed");
}

-(void)declineButtonPressed:(id)sender
{
    NSLog(@"Decline Button Pressed");
}

@end
