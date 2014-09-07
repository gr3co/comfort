//
//  CMPersonalCampaignInfoViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMPersonalCampaignInfoViewController.h"
#import "CMCampaignVisibilityTableViewCell.h"
#import "CMMainViewController.h"

static NSString *CMCampaignVisibilityIdentifier = @"CMCampaignVisibilityTableViewCell";

@interface CMPersonalCampaignInfoViewController () {
    CMCampaignVisibilityTableViewCell *cvtvc;
}

@end

@implementation CMPersonalCampaignInfoViewController

- (id)initWithCampaign:(CMCampaign *)campaign {
    self = [super initWithCampaign:campaign];
    [self.tableView registerClass:[CMCampaignVisibilityTableViewCell class] forCellReuseIdentifier:CMCampaignVisibilityIdentifier];
    
    // setup cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@" Back" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    cancelButton.enabled = YES;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonSystemItemEdit target:self action:@selector(delete:)];
    deleteButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = deleteButton;
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 183;
    }
    if (indexPath.section == 2) {
        return 74;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TEST CREATE CM CAMPAIGN
    if (indexPath.section == 2) {
        cvtvc = [[CMCampaignVisibilityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMCampaignVisibilityIdentifier];
        cvtvc.campaignSwitch.on = [[self.campaign isOn] boolValue];
        return cvtvc;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)cancel:(id)sender {
    [self.campaign setObject:[NSNumber numberWithBool:cvtvc.campaignSwitch.on] forKey:@"isOn"];
    [self.campaign saveInBackground];
    CMMainViewController *mainVC = [[CMMainViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)delete:(id)sender {
    // TODO : DELETE
    [self.campaign deleteInBackground];
    CMMainViewController *mainVC = [[CMMainViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:mainVC animated:YES];
}

@end
