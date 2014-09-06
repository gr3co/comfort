//
//  CMCampaign.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCampaign.h"

@implementation CMCampaign

@synthesize headerImage, description, user, avatar, price;

- (id)initWithUser:(NSString *)user withAvatarImage:(UIImage *)avatarImage withPrice:(NSUInteger)price withHeaderImage:(UIImage *)headerImage withDescription:(NSString *)description {
    self.headerImage = headerImage;
    self.avatar = avatarImage;
    self.user = user;
    self.price = price;
    self.description = description;
    return self;
}

@end
