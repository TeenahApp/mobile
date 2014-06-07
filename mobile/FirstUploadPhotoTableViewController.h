//
//  FirstUploadPhotoTableViewController.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/5/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstUploadPhotoTableViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImage * chosenImage;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@end
