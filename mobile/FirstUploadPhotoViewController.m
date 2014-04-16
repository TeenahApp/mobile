//
//  FirstUploadPhotoViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/12/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "FirstUploadPhotoViewController.h"

@interface FirstUploadPhotoViewController ()

@end

@implementation FirstUploadPhotoViewController

NSString * data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.layer.cornerRadius = 48.0;
    self.imageView.layer.masksToBounds = YES;

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.chosenImage = info[UIImagePickerControllerOriginalImage];

    UIImage * compressedImage = [self compressImage:self.chosenImage scale:0.1];
    
    [self.imageView setImage:compressedImage];

    NSString * base64image = [self encodeToBase64String:compressedImage];
    
    //NSLog(@"%@", base64image);
    
    int size = [base64image length];
    
    // TODO: Check if the chosen file is an image.
    // TODO: Check the size if appropriate.
    //NSLog(@"%d", size);
    
    // Set the image data to be uploaded.
    data = base64image;
    NSLog(@"%@\n\n---------------------------", data);
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadPhoto:(id)sender {
    
    TSweetResponse * tsr = [[MembersCommunicator shared] uploadPhoto:@"2" data:data extension:@"png"];
    
}

- (IBAction)chooseImage:(id)sender {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //self.presentedViewController; self.imagePicker animated:
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(UIImage *)compressImage: (UIImage *) original scale: (CGFloat)scale
{
    // Calculate new size given scale factor.
    CGSize originalSize = original.size;
    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
    
    // Scale the original image to match the new size.
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage* compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:0];
}

- (IBAction)skip:(id)sender {
    
    UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    [self presentViewController:tbc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
