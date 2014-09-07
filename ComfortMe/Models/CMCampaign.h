//
//  CMCampaign.h
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface CMCampaign : PFObject<PFSubclassing>

@property (nonatomic, strong) PFUser *owner;
@property (nonatomic, strong) PFFile *avatar;
@property (nonatomic, strong) PFFile *header;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *isOn;
@property (nonatomic, strong) NSNumber *isAvailable;

+ (CMCampaign *)createNewCampaignWithOwner:(PFUser *)owner withAvatarImage:(UIImage *)avatarImage withPrice:(NSNumber *)price withHeaderImage:(UIImage *)headerImage withDescription:(NSString *)description withMoreInfo:(NSString *)moreInfo;

-(UIImage *)avatarImage;
-(UIImage *)headerImage;
- (NSString *)ownerName;
- (NSString *)priceString;

@end
