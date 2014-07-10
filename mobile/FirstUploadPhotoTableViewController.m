//
//  FirstUploadPhotoTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/5/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "FirstUploadPhotoTableViewController.h"

@interface FirstUploadPhotoTableViewController ()

@end

@implementation FirstUploadPhotoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.photoButton.layer.masksToBounds = YES;
    self.photoButton.layer.cornerRadius = 48.0f;
    self.photoButton.layer.borderWidth = 3.0f;
    self.photoButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        // Get the member information.
        TSweetResponse * memberResponse = [[MembersCommunicator shared] getMember:self.memberId];
            
            // Check if the response code is not successful.
            if (memberResponse.code == 200)
            {
                self.member = [[TMember alloc] initWithJson:memberResponse.json];
                
                // Then load the image.
                if (self.member.photo != nil)
                {
                    // TODO: Show wait indicator.
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        
                        NSURL * photoUrl = [NSURL URLWithString:self.member.photo];
                        
                        // Get the member photo.
                        NSData * data = [NSData dataWithContentsOfURL:photoUrl];
                        UIImage * photo = [[UIImage alloc]initWithData:data];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.photoButton setBackgroundImage:photo forState:UIControlStateNormal];
                        });
                    });
                }
            }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)skip:(id)sender
{
    [self performSegueWithIdentifier:@"showMainTabBarView" sender:sender];
}

- (IBAction)pickPhoto:(id)sender
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    
    self.resizedImage = [self resizedImage:self.chosenImage width:92];
    
    [self.photoButton setBackgroundImage:self.resizedImage forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isFirst == YES)
    {
        return 2;
    }
    
    return 1;
}

- (IBAction)uploadPhoto:(id)sender
{   
    if (self.chosenImage == nil)
    {
        // Show an alert message and return.
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء اختيار صورة ليتم رفعها." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    NSData * data = [NSData dataWithData:UIImagePNGRepresentation(self.resizedImage)];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * uploadResponse = [[MembersCommunicator shared] uploadPhoto:self.memberId data:data extension:@"png"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (uploadResponse.code == 200)
            {
                // Done
                if (self.isFirst == YES)
                {
                    [self performSegueWithIdentifier:@"showMainTabBarView" sender:sender];
                }
                else
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }

                self.alert = [[UIAlertView alloc]initWithTitle:@"تم" message:@"تمّ رفع الصورة بنجاح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء رفع الصورة، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            // Done.
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        });
    });
}

-(UIImage *)resizedImage: (UIImage *) original width:(CGFloat)width
{
    CGFloat originalWidth = original.size.width;
    CGFloat originalHeight = original.size.height;
    
    CGFloat ratio = width/originalWidth;
    
    CGFloat newHeight = originalHeight * ratio;
    CGSize newSize = CGSizeMake(width, newHeight);
    
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showMainTabBarView"])
    {
        UITabBarController * tbc = [segue destinationViewController];
        UINavigationController * tbnc = tbc.viewControllers[0];
        
        TreeViewController * tvc = (TreeViewController *)tbnc.viewControllers[0];
        tvc.memberId = self.memberId;
    }
}

@end
