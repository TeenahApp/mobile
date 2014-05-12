//
//  CirclesTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetCirclesCommunicator.h"
#import "CircleViewController.h"

@interface CirclesTableViewController : UITableViewController

@property (strong, nonatomic) NSDictionary * currentCircle;

@property (strong, nonatomic) NSMutableArray * circles;

@property (weak, nonatomic) IBOutlet UINavigationItem *titleNavigationItem;

@end
