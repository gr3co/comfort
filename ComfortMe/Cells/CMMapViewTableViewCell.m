//
//  CMMapViewTableViewCell.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMMapViewTableViewCell.h"

@implementation CMMapViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _mapView = [[MKMapView alloc] init];
        _mapView.showsUserLocation = YES;
        _mapView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_mapView];
        
        _mapView.frame = iPhone5 ? CGRectMake(0, 0, 320, 320 * 1.2f) : CGRectMake(0, 0, 320, 320);

    }
    return self;
}

@end
