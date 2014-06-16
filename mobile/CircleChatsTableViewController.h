//
//  CircleChatsTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/16/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "UITabInputView.h"

#import "TSweetResponse.h"
#import "TSweetCirclesCommunicator.h"
#import "TSweetMessagesCommunicator.h"

#import "TCircleMessageMember.h"
#import "TMedia.h"

#import "ViewMediaTableViewController.h"
#import "EventsTableViewController.h"
#import "CircleMembersTableViewController.h"

@interface CircleChatsTableViewController : UITableViewController <UITabInputViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITabInputView * tabInput;

@property NSInteger circleId;

@property (nonatomic, strong) TMedia * selectedMedia;

@property (nonatomic, strong) NSMutableArray * messages;

@property (nonatomic, strong) NSDateFormatter * dateFormatter;

@property (nonatomic, strong) UIActionSheet * actionSheet;

@property (strong, nonatomic) UIImage * chosenImage;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

- (UIImage *)compressImage: (UIImage *) original scale: (CGFloat)scale;

@end
