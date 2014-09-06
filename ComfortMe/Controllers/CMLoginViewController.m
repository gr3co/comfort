//
//  CMLoginViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMLoginViewController.h"
#import "CMMainViewController.h"

#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>

#define FORCE_REGISTER true
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
    NSArray *permissionsArray = @[@"user_about_me"];
    // login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"User cancelled the FB Login Process.");
            } else {
                NSLog(@"Some error occured during FB Login Process.");
            }
            return;
        }
        if (user.isNew || ![user objectForKey:@"registered"] || FORCE_REGISTER) {
            NSLog(@"User just joined the app. Successful login.");
            PFUser *currentUser = [PFUser currentUser];
            if (![currentUser objectForKey:@"fbId"]) {
                FBRequest *request = [FBRequest requestForMe];
                [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        NSDictionary *userData = (NSDictionary *)result;
                        [currentUser setObject:userData[@"id"] forKey:@"fbId"];
                        [currentUser setObject:userData[@"name"] forKey:@"fbName"];
                        NSString *url = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=square", userData[@"id"]];
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                        
                        PFFile *image = [PFFile fileWithName:@"profile.png" data:imageData];
                        [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (succeeded) {
                                [[PFUser currentUser] setObject:image forKey:@"fbProfilePic"];
                                [currentUser saveInBackground];
                            } else {
                                NSLog(@"parse error --saving profile image%@", error);
                            }
                        }];
                        CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
                        [self.navigationController pushViewController:mainViewController animated:YES];
                    }
                }];
            }
        } else {
            NSLog(@"Successful login.");
        }
        CMMainViewController *mainViewController = [[CMMainViewController alloc] init];
        [self.navigationController pushViewController:mainViewController animated:YES];
    }];
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
