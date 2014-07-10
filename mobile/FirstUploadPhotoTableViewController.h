//
//  FirstUploadPhotoTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/5/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"

#import "TMember.h"

#import "TreeViewController.h"

@interface FirstUploadPhotoTableViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImage * chosenImage;
@property (strong, nonatomic) UIImage * resizedImage;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@property (nonatomic, strong) TMember * member;
@property NSInteger memberId;
@property BOOL isFirst;

@property (nonatomic, strong) UIAlertView * alert;

-(UIImage *)resizedImage: (UIImage *) original width:(CGFloat)width;

@end
