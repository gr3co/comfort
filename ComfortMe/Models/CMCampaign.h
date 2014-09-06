//
//  CMCampaign.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCampaign : NSObject

@property (nonatomic, strong) UIImage *headerImage;
@property NSString *description;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic) NSUInteger price;
@property (nonatomic, strong) NSString *moreInfo;

- (id)initWithUser:(NSString *)user withAvatarImage:(UIImage *)avatarImage withPrice:(NSUInteger)price withHeaderImage:(UIImage *)headerImage withDescription:(NSString *)description withMoreInfo:(NSString *)moreInfo;

@end
