//
//  CMEndTripButtonTableViewCell.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMEndTripButtonTableViewCell.h"

@implementation CMEndTripButtonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _endTripButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btnImage = [UIImage imageNamed:@"EndTripButton"];
        [_endTripButton setImage:btnImage forState:UIControlStateNormal];
        _endTripButton.contentMode = UIViewContentModeScaleToFill;
        _endTripButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 10);
        
        [_endTripButton addTarget:_delegate action:@selector(endTripButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_endTripButton];
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
