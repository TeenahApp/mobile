//
//  AddEventTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/17/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "TCircle.h"

#import "TSweetResponse.h"
#import "TSweetCirclesCommunicator.h"
#import "UIEditableTextTableViewCell.h"

@interface AddEventTableViewController : UITableViewController <MKMapViewDelegate, UITextFieldDelegate>

@property NSArray * sections;
@property NSMutableArray * data;
@property NSMutableArray * invitedCircles;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property CLLocationCoordinate2D coordinates;
@property MKCoordinateSpan span;
@property MKCoordinateRegion region;
@property MKPointAnnotation * annotationPoint;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSIndexPath * datePickerIndexPath;
@property (assign) NSInteger pickerCellRowHeight;
@property (nonatomic, strong) IBOutlet UIDatePicker * pickerView;

@end
