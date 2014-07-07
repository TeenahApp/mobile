//
//  ViewMediasViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetEventsCommunicator.h"

#import "TEventMedia.h"
#import "TMedia.h"

#import "ViewMediaTableViewController.h"

@interface ViewMediasViewController : UICollectionViewController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel * noRowsLabel;
@property (nonatomic, strong) UIView * noRowsView;

@property NSInteger eventId;
@property NSInteger circleId;

@property (nonatomic, strong) NSMutableArray * medias;

@property NSInteger selectedMediaId;
@property (nonatomic, strong) TMedia * selectedMedia;

@property (strong, nonatomic) UIImage * chosenImage;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

@property (nonatomic, strong) UIAlertView * alert;

- (UIImage *)compressImage: (UIImage *) original scale: (CGFloat)scale;

@end
