//
//  AppDelegate.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //$2y$10$gIc/7Z1TbGLOzjbNtXBHrOJzgIk.AzjQGQryBdxPS21Li2q/XJ7ZO
    
    TSweetRest * tsrest = [TSweetRest shared];
    tsrest.userToken = @"$2y$10$gIc/7Z1TbGLOzjbNtXBHrOJzgIk.AzjQGQryBdxPS21Li2q/XJ7ZO";
    
    /*
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    FirstHandShakeLoginViewController * firstHandShakeLoginVC = (FirstHandShakeLoginViewController *) [storyboard instantiateViewControllerWithIdentifier:@"FirstHandShakeLogin"];
    
    [self.window makeKeyAndVisible];
    
    [self.window.rootViewController presentViewController:firstHandShakeLoginVC animated:NO completion:nil];
     */
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController *tbc = [storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    
    [self.window makeKeyAndVisible];
    
    [self.window.rootViewController presentViewController:tbc animated:NO completion:nil];
    
    
    //[[UsersCommunicator shared] dashboard];
    
    /*
     FirstUploadPhotoViewController * fphotovc = (FirstUploadPhotoViewController *) [storyboard instantiateViewControllerWithIdentifier:@"FirstUploadPhoto"];
    
    [self.window makeKeyAndVisible];
    
    [self.window.rootViewController presentViewController:fphotovc animated:NO completion:nil];
    */
     
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
