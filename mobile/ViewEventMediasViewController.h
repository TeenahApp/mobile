//
//  ViewEventMediasViewController.h
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

#import "UIMediaCollectionViewCell.h"

#import "ViewMediaTableViewController.h"

@interface ViewEventMediasViewController : UICollectionViewController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property NSInteger eventId;
@property (nonatomic, strong) NSMutableArray * medias;

@property NSInteger selectedMediaId;
@property (nonatomic, strong) TMedia * selectedMedia;

@property (strong, nonatomic) UIImage * chosenImage;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

@property (weak, nonatomic) NSString * data;

- (UIImage *)compressImage: (UIImage *) original scale: (CGFloat)scale;
- (NSString *)encodeToBase64String:(UIImage *)image;

@end