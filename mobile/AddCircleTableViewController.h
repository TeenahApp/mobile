//
//  AddCircleTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/23/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCircleTableViewController : UITableViewController

// To hold the members to be added to the new circle.
@property (strong, nonatomic) NSMutableArray * members;
@property (strong, nonatomic) NSMutableArray * secondSectionData;

@property (strong, nonatomic) NSArray * sections;
@property (strong, nonatomic) NSMutableArray * data;

@end
