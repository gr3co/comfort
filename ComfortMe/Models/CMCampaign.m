//
//  CMCampaign.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCampaign.h"

@implementation CMCampaign

- (id) initWithParseObject:(PFObject*) object {
    if ((self = [self initWithUser:object[@"owner"]
                  withAvatarImage:[UIImage imageWithData:[object[@"avatar"] getData]]
                        withPrice:[((NSNumber*)object[@"price"]) unsignedIntegerValue]
                  withHeaderImage:[UIImage imageWithData:[object[@"header"] getData]]
                  withDescription:object[@"description"]
                      withMoreInfo:object[@"info"]]) != nil) {
        _parseObject = object;
    }
    return self;
}

- (id)initWithUser:(NSString *)user withAvatarImage:(UIImage *)avatarImage withPrice:(NSUInteger)price withHeaderImage:(UIImage *)headerImage withDescription:(NSString *)description withMoreInfo:(NSString *)moreInfo {
    if ((self = [super init]) != nil) {
        _headerImage = headerImage;
        _avatar = avatarImage;
        _user = [PFUser objectWithoutDataWithObjectId:user];
        _price = price;
        _description = description;
        _moreInfo = moreInfo;
    }
    return self;
}

- (PFObject*) getParseObject {
    if (_parseObject) {
        return _parseObject;
    }
    PFObject *object = [PFObject objectWithClassName:@"CMCampaign"];
    [object setObject:_user forKey:@"owner"];
    [object setObject:[PFFile fileWithData:UIImagePNGRepresentation(_avatar)] forKey:@"avatar"];
    [object setObject:[NSNumber numberWithInteger:_price] forKey:@"price"];
    [object setObject:[PFFile fileWithData:UIImagePNGRepresentation(_headerImage)] forKey:@"header"];
    [object setObject:_moreInfo forKey:@"info"];
    [object setObject:_description forKey:@"description"];
    [object saveInBackground];
    _parseObject = object;
    return object;
}

@end
