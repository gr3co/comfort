//
//  CMOrder.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMOrder.h"

@implementation CMOrder
@dynamic campaign;
@dynamic owner;
@dynamic seller;
@dynamic destGeo;
@dynamic destAddress;
@dynamic isProcessed;
@dynamic tracker;

+ (NSString *)parseClassName
{
    return @"CMOrder";
}

+ (CMOrder *)createNewOrderWithCampaign:(CMCampaign *)campaign
                             withSeller:(PFUser *)seller
                                withGeo:(PFGeoPoint *)geo
                            withAddress:(NSString *)address
{
    CMOrder *object = [[CMOrder alloc] init];
    object.owner = [PFUser currentUser];
    object.campaign = campaign;
    object.seller = seller;
    object.destGeo = geo;
    object.destAddress = address;
    object.isProcessed = @0;
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Can't save new order: %@", error);
        }
    }];
    return object;
}

- (void) acceptWithTracker:(CMTracker *)tracker {
    [self fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        object[@"isProcessed"] = @1;
        object[@"tracker"] = tracker;
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        }];
    }];
}

- (void) deny {
    [self fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        object[@"isProcessed"] = @2;
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        }];
    }];
}

@end
