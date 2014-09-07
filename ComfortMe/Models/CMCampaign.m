//
//  CMCampaign.m
//  ComfortMe
//
//  Created by Lucy Guo on 9/6/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import "CMCampaign.h"

@implementation CMCampaign
@dynamic owner;
@dynamic avatar;
@dynamic price;
@dynamic header;
@dynamic desc;
@dynamic info;
@dynamic isOn;
@dynamic isAvailable;

+ (NSString *)parseClassName
{
    return @"CMCampaign";
}

+ (CMCampaign *)createNewCampaignWithOwner:(PFUser *)owner withPrice:(NSNumber *)price withHeaderImage:(UIImage *)headerImage withDescription:(NSString *)description withMoreInfo:(NSString *)moreInfo
{
    CMCampaign *cobj  = [[CMCampaign alloc] init];
    
    // setting fields
    cobj.owner = owner;
    cobj.avatar = [owner objectForKey:@"fbProfilePic"];
    cobj.header = [PFFile fileWithData:UIImageJPEGRepresentation(headerImage, 0.8)];
    cobj.desc = description;
    cobj.info = moreInfo;
    cobj.price = price;
    cobj.isOn = [NSNumber numberWithBool:YES];
    cobj.isAvailable = [NSNumber numberWithBool:YES];
    // saving in bg
    [cobj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Can't save campaign object: %@", error);
        }
    }];

    return cobj;
}

-(UIImage *)headerImage
{
    NSData *headerData = [self.header getData];
    return [UIImage imageWithData:headerData];
}

- (NSString *)ownerName
{
    if (self.owner) {
        return [self.owner objectForKey:@"fbName"];
    }
    return @"";
}

- (NSString *)priceString
{
    return [NSString stringWithFormat:@"$%@", self.price];
}

@end
