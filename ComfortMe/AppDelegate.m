//
//  AppDelegate.m
//  ComfortMe
//
//  Created by Stephen Greco on 9/5/14.
//  Copyright (c) 2014 Stephen Greco. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

#import "AppDelegate.h"
#import "CMMainViewController.h"
#import "REFrostedViewController.h"
#import "REFrostedContainerViewController.h"
#import "CMMenuViewController.h"
#import "CMMenuNavigationController.h"
#import "CMColors.h"
#import "CMLoginViewController.h"
#import "CMIncomingOrderViewController.h"
#import "CMCampaign.h"
#import "CMOrder.h"
#import "CMTracker.h"

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // register subclasses of Parse PFObjects
    [CMCampaign registerSubclass];
    [CMOrder registerSubclass];
    [CMTracker registerSubclass];
    
    // setup parse
    [Parse setApplicationId:@"9EmXusOBQ0My5WecnN95lObeAIsIb5ZYhxXSYM8w"
                  clientKey:@"J4WNM4ykzgG9sFGCy9CWOA6M7HA9LRHycgIuN9xS"];
    
    [PFFacebookUtils initializeFacebook];
    
    // [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    
    // create content and menu controllers
    CMMenuNavigationController *navigationController = [[CMMenuNavigationController alloc] initWithRootViewController:[[CMLoginViewController alloc] init]];
    CMMenuViewController *menuController = [[CMMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // make it root view controller
    self.window.rootViewController = frostedViewController;
    
    navigationController.navigationBar.translucent = NO;
    
    self.navigationController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    // [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x42B7BB)];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = frostedViewController;
    [self.window makeKeyAndVisible];
    
    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                     UIRemoteNotificationTypeAlert |
                                                     UIRemoteNotificationTypeSound)];
    
    
    [[UINavigationBar appearance] setTintColor:[CMColors mainColor]];
    
    // Push notifications
    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notificationPayload) {
        NSLog(@"%@", notificationPayload);
        NSString *type = notificationPayload[@"type"];
        if ([type isEqualToString:@"order"]) {
            // handle orders
        }
    }
        
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}


- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
    
    // Store the deviceToken in the current Installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation setChannels:@[@"orders"]];
    [currentInstallation setObject:[PFUser currentUser] forKey:@"user"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    if (userInfo[@"order"]) {
        CMIncomingOrderViewController *acceptController =
        [[CMIncomingOrderViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:acceptController animated:YES];
    }
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [PFPush handlePush:userInfo];
    if (userInfo[@"order"]) {
        CMOrder *order = [CMOrder objectWithoutDataWithObjectId:userInfo[@"order"]];
        [order fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (error) {
                completionHandler(UIBackgroundFetchResultFailed);
            } else {
                CMIncomingOrderViewController *acceptController =
                [[CMIncomingOrderViewController alloc] initWithOrder:(CMOrder*)object];
                [self.navigationController presentModalViewController:acceptController animated:YES];
                completionHandler(UIBackgroundFetchResultNewData);
            }
        }];
    }
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state.
     This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
     or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates.
     Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state
     information to restore your application to its current state in case it is terminated later.
     If your application supports background execution,
     this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ComfortMe successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ComfortMe failed to subscribe to push notifications on the broadcast channel.");
    }
}

@end
