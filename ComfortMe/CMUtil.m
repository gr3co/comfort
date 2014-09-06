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
            completionBlock([NSString stringWithFormat:@"%02ld:%02ld", (long)hours, (long)minutes]);
        } else {
            completionBlock(nil);
        }
    }];
}

+ (void) attemptOrder:(CMOrder *)order withBlock:(void (^)(BOOL,CMTracker*))completionBlock {
    // TODO: make pushing work
    // TODO: make time out if not accepted

    PFPush *push = [[PFPush alloc] init];
    PFQuery *query = [PFInstallation query];
    
    PFQuery *userquery = [PFUser query];
    PFUser *user = [PFUser objectWithoutDataWithObjectId:order.seller.objectId];
    [user fetch];
//    PFUser *seller = [userquery getObjectWithId:order.seller.objectId];
    [query whereKey:@"user" equalTo:user];
//    [query whereKey:@"user" equalTo:[order seller]];
//    [query whereKey:@"user" matchesQuery:query];
//    [push setChannel:@"orders"];
    [push setQuery:query];
    NSDictionary *data = @{@"alert": @"You have a new order!", @"order":order.objectId};
    [push setData:data];
    [push sendPushInBackground];
    [CMTracker createNewTrackerWithCoordinate:CLLocationCoordinate2DMake(42.293, -83.717) withOrder:order withBlock:completionBlock];

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
