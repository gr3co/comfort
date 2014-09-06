//
//  CMCampaign.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCampaign.h"

@implementation CMCampaign

- (id)initWithUser:(NSString *)user withAvatarImage:(UIImage *)avatarImage withPrice:(NSUInteger)price withHeaderImage:(UIImage *)headerImage withDescription:(NSString *)description withMoreInfo:(NSString *)moreInfo {
    _headerImage = headerImage;
    _avatar = avatarImage;
    _user = user;
    _price = price;
    _description = description;
    _moreInfo = moreInfo;
    return self;
}

- (PFObject*) getParseObject {
    PFObject *object = [PFObject objectWithClassName:@"CMCampaign"];
    object[@"owner"] = _user;
    object[@"avatar"] = _avatar;
    object[@"price"] = [NSNumber numberWithInteger:_price];
    object[@"header"] = _headerImage;
    object[@"info"] = _moreInfo;
    object[@"description"] = _description;
    [object saveEventually];
    return object;
}

@end
