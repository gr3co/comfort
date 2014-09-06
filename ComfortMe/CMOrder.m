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
            // TODO: make pushing work
            // TODO: make time out if not accepted
            
            /*PFUser *user = order[@"seller"];
            PFPush *push = [[PFPush alloc] init];
            PFQuery *query = [PFInstallation query];
            [query whereKey:@"user" equalTo:user.objectId];
            [push setChannel:@"orders"];
            [push setQuery:query];
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
