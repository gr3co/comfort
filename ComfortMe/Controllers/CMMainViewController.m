//
//  CMMainViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/5/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "CMMainViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "CMColors.h"
#import "CMHomeCampaignTableViewCell.h"
#import "CMCampaignInfoViewController.h"
#import "CMMenuNavigationController.h"
#import "CMUserMapViewController.h"
#import <Parse/Parse.h>
#import "CMPersonalCampaignInfoViewController.h"

const NSInteger headerHeight = 187;
static NSString *CMHomeCampaignIdentifier = @"CMHomeCampaignTableViewCell";

@interface CMMainViewController ()<APParallaxViewDelegate>

@property (nonatomic, assign) NSInteger slide;
@property (nonatomic, strong) NSArray *galleryImages;
@property (nonatomic, getter=isFullscreen) BOOL fullscreen;
@property (nonatomic, getter=isTransitioning) BOOL transitioning;

@end

@implementation CMMainViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [CMColors lightGray];
        
        [self initNavBar];
        [self.tableView addParallaxWithImage:[UIImage imageNamed:@"SlideShowKitten"]
                                   andHeight:headerHeight];
        
        [self.tableView.parallaxView setDelegate:self];
        [self.tableView registerClass:[CMHomeCampaignTableViewCell class]
               forCellReuseIdentifier:CMHomeCampaignIdentifier];
        
        // running campaign query
        PFQuery *query = [CMCampaign query];
        query.limit = 10;
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                _campaigns = [[NSArray alloc] initWithArray:objects];
                [self.tableView reloadData];
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(BOOL)prefersStatusBarHidden { return NO; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _galleryImages = @[@"SlideShowKitten", @"SlideShowSerenade", @"SlideShowPuppy", @"SlideShowPie"];
    
    // First Load
    [self changeSlide];
    
    // Loop gallery - fix loop: http://bynomial.com/blog/?p=67
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.5f target:self selector:@selector(changeSlide) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_campaigns count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CMHomeCampaignTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMHomeCampaignIdentifier];
    
    
    if (cell == nil) {
        cell = [[CMHomeCampaignTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMHomeCampaignIdentifier];
    }
    
    CMCampaign *campaign = _campaigns[indexPath.row];
    
    cell.avatarImageView.image = [campaign avatarImage];
    cell.descriptionLabel.text = [campaign desc];
    cell.priceLabel.text = [campaign priceString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMCampaignInfoViewController *campaignInfoViewController =
    [[CMCampaignInfoViewController alloc] initWithCampaign:_campaigns[indexPath.row]];
    [self.navigationController pushViewController:campaignInfoViewController animated:YES];
    
}



#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

#pragma mark - Navigation Bar

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(CMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"RefreshIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(refresh)];
    
    rbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.rightBarButtonItem = rbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 93.5, 19.5)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
}

- (void)refresh {
    // refresh here
}

#pragma mark - Change slider
- (void)changeSlide
{
    if (_fullscreen == NO && _transitioning == NO) {
        if(_slide > _galleryImages.count-1) _slide = 0;
        
        UIImage *toImage = [UIImage imageNamed:_galleryImages[_slide]];
        [UIView transitionWithView:self.tableView.parallaxView
                          duration:0.6f
                           options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationCurveEaseInOut
                        animations:^{
                            self.tableView.parallaxView.imageView.image = toImage;
                        } completion:nil];
        _slide++;
    }
}




@end
