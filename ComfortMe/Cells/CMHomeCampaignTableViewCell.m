//
//  CMHomeCampaignTableViewCell.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMHomeCampaignTableViewCell.h"
#import "CMColors.h"

@implementation CMHomeCampaignTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        [self setupAvatar];
        [self setupDescription];
        [self setupPriceLabel];
        
    }
    return self;
}

- (void)setupAvatar
{
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
    // _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_avatarImageView];
    
//    NSDictionary *views = NSDictionaryOfVariableBindings(_avatarImageView);
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_avatarImageView]" options:0 metrics:nil views:views]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_avatarImageView]" options:0 metrics:nil views:views]];
    
}

- (void)setupDescription
{
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:14];
    _descriptionLabel.textColor = UIColorFromRGB(0x2B2B2B);
    _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_descriptionLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionLabel, _avatarImageView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_avatarImageView]-15-[_descriptionLabel]-75-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[_descriptionLabel]" options:0 metrics:nil views:views]];

}

- (void)setupPriceLabel
{
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.numberOfLines = 0;
    _priceLabel.font = [UIFont fontWithName:@"Avenir" size:23];
    _priceLabel.textColor = [CMColors mainColor];
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_priceLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_priceLabel, _descriptionLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_descriptionLabel]-22-[_priceLabel]-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_priceLabel]" options:0 metrics:nil views:views]];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
