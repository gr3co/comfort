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
            PFUser *user = order[@"seller"];
            PFPush *push = [[PFPush alloc] init];
            PFQuery *userQuery = [PFInstallation query];
            NSDictionary *data = @{@"alert": @"You have a new order!", @"id":order.objectId};
            [userQuery whereKey:@"user" equalTo:user];
            [push setChannel:@"orders"];
            [push setQuery:userQuery];
            [push setData:data];
            [push sendPushInBackground];
        }
        completionBlock(succeeded);
    }];
}

@end
