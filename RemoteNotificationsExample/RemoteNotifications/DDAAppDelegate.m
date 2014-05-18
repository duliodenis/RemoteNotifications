//
//  DDAAppDelegate.m
//  RemoteNotifications
//
//  Created by Dulio Denis on 5/18/14.
//  Copyright (c) 2014 ddApps. All rights reserved.
//

#import "DDAAppDelegate.h"
#import <Parse/Parse.h>

@implementation DDAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Your Parse App ID String"
                  clientKey:@"Your Parse Client Key"];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    return YES;
}

#pragma mark - Device token registration for push notifications

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    NSString *valueToSave = @"Push";
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"RemoteNotification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark - Silent Notification App Delegate Method

- (void)           application:(UIApplication *)application
  didReceiveRemoteNotification:(NSDictionary *)userInfo
        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Remote Notification userInfo is %@", userInfo);
    
    NSNumber *contentID = userInfo[@"content-id"];
    NSLog(@"Content ID = %@", contentID);
    
    NSString *valueToSave = @"Silent";
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"RemoteNotification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
