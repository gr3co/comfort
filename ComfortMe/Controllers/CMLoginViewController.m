//
//  CMLoginViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMLoginViewController.h"
#import "CMMainViewController.h"

@interface CMLoginViewController () {
    UIImageView *captionView;
    UIImageView *logoView;
    UIButton *facebookButton;
}

@end

@implementation CMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupBackgroundView];
        [self setupLogo];
        [self setupCaption];
        [self setupFacebookLogin];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupBackgroundView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"LoginBG"];
    [self.view insertSubview:imageView atIndex:0];
}

- (void)setupLogo
{
    logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"LoginLogo"];
    logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:logoView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(logoView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[logoView]-60-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[logoView]" options:0 metrics:nil views:views]];
}

- (void)setupCaption
{
    captionView = [[UIImageView alloc] init];
    captionView.image = [UIImage imageNamed:@"LoginCaption"];
    captionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:captionView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(logoView, captionView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[captionView]-30-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logoView]-35-[captionView]" options:0 metrics:nil views:views]];
}

- (void)setupFacebookLogin
{
    facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton setImage:[UIImage imageNamed:@"LoginFacebookButton"] forState:UIControlStateNormal];
    facebookButton.contentMode = UIViewContentModeScaleAspectFill;
    [facebookButton addTarget:self action:@selector(loginFacebookTouched:) forControlEvents:UIControlEventTouchUpInside];
    facebookButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:facebookButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(facebookButton, captionView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[facebookButton]-25-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[captionView]-30-[facebookButton]" options:0 metrics:nil views:views]];
}

- (void)loginFacebookTouched:(id)sender
{
    CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden { return YES; }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
