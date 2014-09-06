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

- (id) initWithOrder:(CMOrder *)order {
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        self.order = order;
        [self.order[@"owner"] fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            [self setupName];
            [self setupAvatar];
            [self setupMiles];
        }];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        orderView = [[CMIncomingOrderView alloc] initWithFrame:self.view.bounds];
        self.view = orderView;
    }
    return self;
}

- (void)setupName
{
    orderView.nameLabel.text = [NSString stringWithFormat:@"%@ \nneeds comforting!", self.order[@"owner"][@"fbName"]];
}

- (void)setupAvatar
{
    orderView.avatarImageView.file = self.order[@"owner"][@"fbProfilePic"];
    // orderView.avatarImageView.image = [UIImage imageNamed:@"TempAvatarLarge"];
    [orderView.avatarImageView loadInBackground];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderAccepted" object:self.order];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)declineButtonPressed:(id)sender
{
    NSLog(@"Decline Button Pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
