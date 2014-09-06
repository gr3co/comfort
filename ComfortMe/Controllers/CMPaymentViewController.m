//
//  CMPaymentViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMPaymentViewController.h"
#import "PKView.h"
#import "CMColors.h"
#import "CMMainViewController.h"

@interface CMPaymentViewController ()

@end

@implementation CMPaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [CMColors lightGray];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.paymentView = [[PKView alloc] initWithFrame:CGRectMake(15, 25, 290, 55)];
    self.paymentView.delegate = self;
    [self.view addSubview:self.paymentView];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"Change Card";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.paymentView = [[PKView alloc] initWithFrame:CGRectMake(15, 25, 290, 45)];
    self.paymentView.delegate = self;
    
    [self.view addSubview:self.paymentView];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PKViewDelegate Methods

- (void) paymentView:(PKView *)paymentView withCard:(PKCard *)card isValid:(BOOL)valid
{
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (IBAction)save:(id)sender
{
    PKCard* card = self.paymentView.card;
    
    NSLog(@"Card last4: %@", card.last4);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);
    
    [[NSUserDefaults standardUserDefaults] setValue:card.last4 forKey:@"card.last4"];
    [self.navigationController popViewControllerAnimated:YES];
    CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
    
}


@end
