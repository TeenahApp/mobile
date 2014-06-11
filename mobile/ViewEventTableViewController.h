//
//  ViewEventTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "TSweetResponse.h"
#import "TSweetEventsCommunicator.h"

#import "TEvent.h"

#import "UIEventStatsTableViewCell.h"
#import "UIEventDecisionTableViewCell.h"
#import "UIMultiColumnsTableViewCell.h"

#import "ViewMemberTableViewController.h"
#import "CommentsTableViewController.h"
#import "ViewEventMediasViewController.h"

@interface ViewEventTableViewController : UITableViewController <UIEventDecisionTableViewCellDelegate>

@property NSInteger eventId;

@property (nonatomic, strong) TEvent * event;

@property (strong, nonatomic) NSArray * sections;

@property (strong, nonatomic) NSMutableArray * data;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) MKPointAnnotation * annotation;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;

@property (strong, nonatomic) TSweetResponse * likeResponse;

@end