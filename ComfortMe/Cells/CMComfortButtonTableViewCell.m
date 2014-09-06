//
//  CMComfortButtonTableViewCell.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMComfortButtonTableViewCell.h"

@implementation CMComfortButtonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _comfortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btnImage = [UIImage imageNamed:@"ComfortButton"];
        [_comfortButton setImage:btnImage forState:UIControlStateNormal];
        _comfortButton.contentMode = UIViewContentModeScaleToFill;
        _comfortButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 10);
        
        [_comfortButton addTarget:_delegate action:@selector(comfortButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_comfortButton];
    }
    return self;
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
