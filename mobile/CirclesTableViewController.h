//
//  CirclesTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "TSweetResponse.h"
#import "TSweetCirclesCommunicator.h"

#import "CircleChatsTableViewController.h"
#import "AddCircleTableViewController.h"

#import "TCircle.h"

@interface CirclesTableViewController : UITableViewController

@property (strong, nonatomic) TCircle * currentCircle;

@property (strong, nonatomic) NSMutableArray * circles;

@property (weak, nonatomic) IBOutlet UINavigationItem *titleNavigationItem;

@property (nonatomic, strong) UIAlertView * alert;

@end
