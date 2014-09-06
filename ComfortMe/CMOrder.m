//
//  CMOrder.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMOrder.h"
#import "CMTracker.h"

@implementation CMOrder
@dynamic campaign;
@dynamic owner;
@dynamic seller;

+ (NSString *)parseClassName
{
    return @"CMOrder";
}

+ (CMOrder *)createNewOrderWithCampaign:(CMCampaign *)campaign withSeller:(PFUser *)seller
{
    CMOrder *object = [[CMOrder alloc] init];
    object.owner = [PFUser currentUser];
    object.campaign = campaign;
    object.seller = seller;
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Can't save new order: %@", error);
        }
    }];
    return object;
}

@end
