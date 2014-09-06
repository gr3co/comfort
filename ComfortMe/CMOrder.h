//
//  CMOrder.h
//  ComfortMe
//
//  Created by Stephen Greco on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "CMCampaign.h"

@interface CMOrder : PFObject<PFSubclassing>

@property (nonatomic, strong) CMCampaign *campaign;
@property (nonatomic, strong) PFUser *owner;
@property (nonatomic, strong) PFUser *seller;

+ (CMOrder *)createNewOrderWithCampaign:(CMCampaign *)campaign withSeller:(PFUser *)seller;
//- (void)contactSeller:(void (^)(BOOL accepted, CMTracker *tracker))completionBlock;
//
//+ (PFObject*) newOrder;
//
//+ (void) attemptOrder:(PFObject*)order withBlock:(void (^)(BOOL accepted, CMTracker *tracker))completionBlock;

@end
