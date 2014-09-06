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

+ (PFObject*) newOrder {
    PFObject *object = [PFObject objectWithClassName:@"CMOrder"];
    object[@"owner"] = [PFUser currentUser];
    return object;
}

+ (void) attemptOrder:(PFObject*)order withBlock:(void (^)(BOOL,CMTracker*))completionBlock {
    [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
           /* PFUser *user = order[@"seller"];
            PFPush *push = [[PFPush alloc] init];
            PFQuery *query = [PFInstallation query];
            PFQuery *userQuery = [PFUser query];
            [userQuery whereKey:@"objectId" equalTo:user.objectId];
            [query whereKey:@"user" matchesQuery:userQuery];
            [push setQuery:query];
            [push setChannel:@"orders"];
            NSDictionary *data = @{@"alert": @"You have a new order!", @"order":order.objectId};
            [push setData:data];
            [push sendPushInBackground];*/
        }
        CMTracker *tracker = [[CMTracker alloc] initWithLocation:CLLocationCoordinate2DMake(42.293, -83.717)];
        tracker[@"order"] = order;
        [tracker saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                completionBlock(succeeded, tracker);
        }];
    }];
}

@end
