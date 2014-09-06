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

const NSInteger headerHeight = 150;
static NSString *CMHomeCampaignIdentifier = @"CMHomeCampaignTableViewCell";

@interface CMMainViewController ()<APParallaxViewDelegate>

@end

@implementation CMMainViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [CMColors lightGray];
        
        [self.tableView registerClass:[CMHomeCampaignTableViewCell class] forCellReuseIdentifier:CMHomeCampaignIdentifier];
        
        [self.tableView addParallaxWithImage:[UIImage imageNamed:@"HeaderKitten"] andHeight:headerHeight];
        [self.tableView.parallaxView setDelegate:self];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CMHomeCampaignTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CMHomeCampaignIdentifier];
    cell.avatarImageView.image = [UIImage imageNamed:@"TempAvatar"];
    cell.descriptionLabel.text = @"I will bring my cat for you to play with";
    cell.priceLabel.text = [NSString stringWithFormat:@"$%d", 5];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMCampaignInfoViewController *campaignInfoViewController = [[CMCampaignInfoViewController alloc] initWithNibName:nil bundle:nil];
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




@end
