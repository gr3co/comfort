//
//  CMOrder.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMOrder.h"

@implementation CMOrder

+ (PFObject*) newOrder {
    PFObject *object = [PFObject objectWithClassName:@"CMOrder"];
    object[@"owner"] = [PFUser currentUser];
    return object;
}

+ (void) attemptOrder:(PFObject*)order withBlock:(void (^)(BOOL))completionBlock {
    [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PFObject *campaign = order[@"campaign"];
            PFUser *user = campaign[@"owner"];
            PFPush *push = [[PFPush alloc] init];
            PFQuery *userQuery = [PFInstallation query];
            [userQuery whereKey:@"user" equalTo:user];
            [push setChannel:@"orders"];
            [push setQuery:userQuery];
            [push setMessage:@"You have a new order!"];
            [push sendPushInBackground];
        }
    }];
}

@end
