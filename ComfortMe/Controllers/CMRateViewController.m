//
//  CMRateViewController.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMRateViewController.h"
#import "CMColors.h"

@interface CMRateViewController () {
    UILabel *rateLabel;
}

@end

@implementation CMRateViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [CMColors lightGray];
        [self setupAvatar];
        [self setupRateLabel];
        [self setupRating];
    }
    return self;
}

- (void)setupAvatar
{
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 120/2, 70, 120, 120)];
    avatar.image = [UIImage imageNamed:@"TempAvatarLarge"];
    [self.view addSubview:avatar];
}

- (void)setupRateLabel
{
    rateLabel = [[UILabel alloc] init];
    rateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rateLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:18.0f];
    rateLabel.textColor = UIColorFromRGB(0x4C4C4C);
    rateLabel.text = @"Rate your experience to help our community!";
    rateLabel.textAlignment = NSTextAlignmentCenter;
    rateLabel.numberOfLines = 0;
    rateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:rateLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(rateLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[rateLabel]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[rateLabel]-100-|" options:0 metrics:nil views:views]];
}

- (void)setupRating
{
    RateView* rateVw = [RateView rateViewWithRating:5.0f];
    rateVw.starFillMode = StarFillModeHorizontal;
    rateVw.delegate = self;
    rateVw.canRate = YES;
    rateVw.tag = 88888;
    rateVw.starSize = 50;
    rateVw.translatesAutoresizingMaskIntoConstraints = NO;
    
    rateVw.starFillColor = [CMColors mainColor];

    
    [self.view addSubview:rateVw];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(rateVw);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[rateVw]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-290-[rateVw]-100-|" options:0 metrics:nil views:views]];
    
    UIButton *ratingDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingDoneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [ratingDoneButton addTarget:_delegate action:@selector(ratingDoneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"DoneRating"];
    [ratingDoneButton setImage:btnImage forState:UIControlStateNormal];
    ratingDoneButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:ratingDoneButton];
    
    views = NSDictionaryOfVariableBindings(ratingDoneButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[ratingDoneButton]-5-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-380-[ratingDoneButton]-140-|" options:0 metrics:nil views:views]];

}

#pragma mark
#pragma mark<RateViewDelegate Methods>
#pragma mark

-(void)rateView:(RateView*)rateView didUpdateRating:(float)rating
{
    NSLog(@"rateViewDidUpdateRating: %.1f", rating);
}

@end
