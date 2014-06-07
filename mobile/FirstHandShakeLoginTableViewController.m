//
//  FirstHandShakeLoginTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/3/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "FirstHandShakeLoginTableViewController.h"

@interface FirstHandShakeLoginTableViewController ()

@end

@implementation FirstHandShakeLoginTableViewController

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
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    // Focus on mobileTextField and display keyboard.
    //[self.mobileTextField becomeFirstResponder];
}

- (void)hideKeyboard
{
    [self.mobileTextField resignFirstResponder];
}

- (IBAction)sendTempPassword:(id)sender
{
    // TODO: Validate the input of the user.
    // TODO: Check if the mobile is correct.
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Do something...
        self.tokenizeResponse = [[UsersCommunicator shared] tokenize:self.mobileTextField.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // TODO: Check if the response code is not successful.
//            if (self.tokenizeResponse.code == 204)
//            {
//                [self performSegueWithIdentifier:@"showSecondHandShakeLogin" sender:sender];
//            }
//            else
//            {
//                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء التأكد من إدخال رقم جوّال بالصياغة الصحيحة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
//                
//                [alert show];
//            }
            
            [self performSegueWithIdentifier:@"showSecondHandShakeLogin" sender:sender];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSecondHandShakeLogin"])
    {
        SecondHandShakeLoginTableViewController *vc = (SecondHandShakeLoginTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        vc.mobile = self.mobileTextField.text;
    }
}

@end
