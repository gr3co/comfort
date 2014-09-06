//
//  CMIncomingOrder.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMIncomingOrderView.h"

@implementation CMIncomingOrderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        // Initialization code
        [self setupNameLabel];
        [self setupAvatar];
        [self setupMilesLabel];
        [self setupAcceptButton];
        [self setupDeclineButton];
    }
    return self;
}

- (void)setupNameLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:26];
    _nameLabel.textColor = UIColorFromRGB(0x2B2B2B);
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nameLabel]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupAvatar
{
    _avatarImageView = [[PFImageView alloc] init];
    _avatarImageView.frame = CGRectMake(self.frame.size.width/2 - 125/2, 160, 125, 125);
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    UIBezierPath *circularPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _avatarImageView.frame.size.width, _avatarImageView.frame.size.height) cornerRadius:MAX(_avatarImageView.frame.size.width, _avatarImageView.frame.size.height)];
    
    circle.path = circularPath.CGPath;
    _avatarImageView.layer.mask = circle;
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor blackColor].CGColor;
    circle.strokeColor = [UIColor blackColor].CGColor;
    circle.lineWidth = 0;
    _avatarImageView.layer.mask = circle;
    
    [self addSubview:_avatarImageView];
    
    
//    NSDictionary *views = NSDictionaryOfVariableBindings(_avatarImageView, _nameLabel);
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-95-[_avatarImageView]" options:0 metrics:nil views:views]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-15-[_avatarImageView]" options:0 metrics:nil views:views]];
}

- (void)setupMilesLabel
{
    _milesLabel = [[UILabel alloc] init];
    _milesLabel.numberOfLines = 1;
    _milesLabel.textAlignment = NSTextAlignmentCenter;
    _milesLabel.textColor = UIColorFromRGB(0x707070);
    _milesLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:14];
    _milesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_milesLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_milesLabel, _avatarImageView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[_milesLabel]-40-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatarImageView]-15-[_milesLabel]" options:0 metrics:nil views:views]];
    
}

- (void)setupAcceptButton
{
    _acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImage = [UIImage imageNamed:@"AcceptButton"];
    [_acceptButton setImage:btnImage forState:UIControlStateNormal];
    _acceptButton.contentMode = UIViewContentModeScaleToFill;
    _acceptButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_acceptButton addTarget:_delegate action:@selector(acceptButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_acceptButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_acceptButton, _milesLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_acceptButton]" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_milesLabel]-55-[_acceptButton]" options:0 metrics:nil views:views]];
}

- (void)setupDeclineButton
{
    _declineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImage = [UIImage imageNamed:@"DeclineButton"];
    [_declineButton setImage:btnImage forState:UIControlStateNormal];
    _declineButton.contentMode = UIViewContentModeScaleToFill;
    _declineButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_declineButton addTarget:_delegate action:@selector(declineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_declineButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_milesLabel, _declineButton);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_declineButton]-15-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_milesLabel]-55-[_declineButton]" options:0 metrics:nil views:views]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
