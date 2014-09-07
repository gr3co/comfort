//
//  CMUtil.m
//  ComfortMe
//
//  Created by Niveditha Jayasekar on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMUtil.h"
#import "MapKit/MapKit.h"

@implementation CMUtil

+(void)getEstimatedTravelTimeFrom: (PFGeoPoint *)startPoint block:(void (^)(NSString *eta))completionBlock
{
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([startPoint latitude], [startPoint longitude]) addressDictionary:nil];
    MKMapItem *source = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:source];
    [request setDestination:[MKMapItem mapItemForCurrentLocation]];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    [request setRequestsAlternateRoutes:NO];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if ( ! error && [response routes] > 0) {
            MKRoute *route = [[response routes] objectAtIndex:0];
            NSInteger ti = (NSInteger)route.expectedTravelTime;
            NSInteger minutes = (ti / 60) % 60;
            NSInteger hours = (ti / 3600);
            NSMutableString *result = [[NSMutableString alloc] init];
            if (hours) {
                [result appendString:[NSString stringWithFormat:@"%ld hour%@ ",
                                      (unsigned long)hours, hours > 1 ? @"s" : @""]];
            }
            [result appendString:[NSString stringWithFormat:@"%ld minute%@ ",
                                      (unsigned long)minutes, minutes != 1 ? @"s" : @""]];
            completionBlock([NSString stringWithFormat:@"%@away", result]);
        } else {
            completionBlock(@"? minutes away");
        }
    }];
}

+ (NSString*) convertTravelTimeToString: (NSTimeInterval) time {
    NSInteger ti = (NSInteger)time;
    NSInteger minutes = (int)(ti / 60.0) % 60;
    NSInteger hours = (ti / 3600.0);
    NSMutableString *result = [[NSMutableString alloc] init];
    if (hours) {
        [result appendString:[NSString stringWithFormat:@"%ld hour%@ ",
                              (unsigned long)hours, hours > 1 ? @"s" : @""]];
    }
    [result appendString:[NSString stringWithFormat:@"%ld minute%@ ",
                          (unsigned long)minutes, minutes != 1 ? @"s" : @""]];
    return [NSString stringWithFormat:@"%@away", result];
}

+ (void) attemptOrder:(CMOrder *)order withBlock:(void (^)(NSError*))completionBlock {
    PFPush *push = [[PFPush alloc] init];
    PFQuery *query = [PFInstallation query];
    PFUser *user = [PFUser objectWithoutDataWithObjectId:order.seller.objectId];
    [user fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [query whereKey:@"user" equalTo:user];
        [push setQuery:query];
        NSArray *nameArray = [[PFUser currentUser][@"fbName"]
                              componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *message = [NSString stringWithFormat:@"New order from %@!", nameArray[0]]; // first name
        NSDictionary *data = @{@"alert": message, @"order":order.objectId};
        [push setData:data];
        [push sendPushInBackground];
        if (completionBlock) {
            completionBlock(error);
        }
    }];
}

+(void)getDirectionsTo:(PFGeoPoint *)endPoint block:(void (^)(MKRoute *directions))completionBlock
{
    MKPlacemark *destPlacemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([endPoint latitude], [endPoint longitude]) addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destPlacemark];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[MKMapItem mapItemForCurrentLocation]];
    [request setDestination:destination];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    [request setRequestsAlternateRoutes:NO];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if ( ! error && [response routes] > 0) {
            MKRoute *route = [[response routes] objectAtIndex:0];
            completionBlock(route);
        } else {
            completionBlock(nil);
        }
    }];
}

@end
