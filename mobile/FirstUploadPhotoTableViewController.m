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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.photoButton.layer.masksToBounds = YES;
    self.photoButton.layer.cornerRadius = 48.0f;
    self.photoButton.layer.borderWidth = 3.0f;
    self.photoButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    //self.presentedViewController; self.imagePicker animated:
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    
    //UIImage * compressedImage = [self compressImage:self.chosenImage scale:0.1];
    
    [self.photoButton setBackgroundImage:self.chosenImage forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:NO completion:nil];
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
