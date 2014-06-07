//
//  SettingsTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/3/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UICKeyChainStore.h>

#import "TSweetResponse.h"
#import "TSweetUsersCommunicator.h"

#import "FirstUploadPhotoTableViewController.h"

@interface SettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;


@end
