//
//  CircleViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/8/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSweetCirclesCommunicator.h"
#import "TSweetResponse.h"
#import "PNChart.h"

@interface CircleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *innerView;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (strong, nonatomic) NSDictionary * stats;

@end
