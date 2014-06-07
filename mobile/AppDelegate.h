//
//  AppDelegate.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/10/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <UICKeyChainStore.h>

#import "FirstHandShakeLoginTableViewController.h"
#import "UpdateInfoFirstTimeViewController.h"
#import "TreeTableViewController.h"

#import "TSweetUsersCommunicator.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
