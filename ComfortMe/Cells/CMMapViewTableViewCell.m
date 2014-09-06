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
        
        if (iPhone5) {
            _mapView.frame = CGRectMake(0, 0, 320, 320*1.1f);
        }
        else {
            _mapView.frame = CGRectMake(0, 0, 320, .9f * 320);
        }

    }
    return self;
}

@end
