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
    return [PFObject objectWithClassName:@"CMOrder"];
}

@end
