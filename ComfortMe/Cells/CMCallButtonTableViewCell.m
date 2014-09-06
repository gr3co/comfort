//
//  CMCallButtonTableViewCell.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCallButtonTableViewCell.h"

@implementation CMCallButtonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btnImage = [UIImage imageNamed:@"ComfortButton"];
        [_callButton setImage:btnImage forState:UIControlStateNormal];
        _callButton.contentMode = UIViewContentModeScaleToFill;
        _callButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 10);
        
        [_callButton addTarget:_delegate action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_callButton];
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
