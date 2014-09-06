//
//  CMMapPin.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CMMapPin : NSObject<MKAnnotation>

- (id) initWithCoordinate: (CLLocationCoordinate2D) coord;

@end
