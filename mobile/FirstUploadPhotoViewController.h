//
//  FirstUploadPhotoViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/12/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSweetResponse.h"
#import "TSweetMembersCommunicator.h"

@interface FirstUploadPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage * chosenImage;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

@property (weak, nonatomic) NSString * data;

- (UIImage *)compressImage: (UIImage *) original scale: (CGFloat)scale;
- (NSString *)encodeToBase64String:(UIImage *)image;

@end
