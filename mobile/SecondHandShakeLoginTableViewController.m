//
//  SecondHandShakeLoginTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/4/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "SecondHandShakeLoginTableViewController.h"

@interface SecondHandShakeLoginTableViewController ()

@end

@implementation SecondHandShakeLoginTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    NSString * trimmedText = [self.smsTokenTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedText isEqual:@""])
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال كلمة المرور المؤقتة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Do something...
        self.loginResponse = [[UsersCommunicator shared] login:self.mobile smsToken:self.smsTokenTextField.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (self.loginResponse.code == 200)
            {
                TSweetRest * restAPI = [TSweetRest shared];
                
                // Set the current user token.
                restAPI.userToken = self.loginResponse.json[@"user_token"];
                
                // Get the member id as an integer.
                self.memberId = [[self.loginResponse.json objectForKey:@"member_id"] integerValue];
                
                // Save the user token to the keychain.
                [UICKeyChainStore setString:restAPI.userToken forKey:@"usertoken" service:@"com.teenah-app.mobile"];
                [UICKeyChainStore setString:[NSString stringWithFormat:@"%ld", (long)self.memberId] forKey:@"memberid" service:@"com.teenah-app.mobile"];
                
                if (self.memberId == 0)
                {
                    [self performSegueWithIdentifier:@"showUpdateInfoFirstTime" sender:sender];
                }
                else
                {
                    [self performSegueWithIdentifier:@"showMainTabBarView" sender:sender];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء التأكد من إدخال كلمة المرور المؤقتة بالصياغة الصحيحة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];

                [alert show];
            }
            
            [self performSegueWithIdentifier:@"showUpdateInfoFirstTime" sender:sender];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showUpdateInfoFirstTime"])
    {
        //UpdateInfoFirstTimeViewController *vc = (UpdateInfoFirstTimeViewController *) [segue destinationViewController];
        
        UINavigationController *navController = [segue destinationViewController];
        
        UpdateInfoFirstTimeViewController *vc = (UpdateInfoFirstTimeViewController *)([navController viewControllers][0]);
        
        [vc initWithNibName:nil bundle:nil];
    }

    else if ([[segue identifier] isEqualToString:@"showMainTabBarView"])
    {
        UITabBarController * tbc = [segue destinationViewController];
        UINavigationController * tbnc = tbc.viewControllers[0];
        
        TreeViewController * tvc = (TreeViewController *)tbnc.viewControllers[0];
        tvc.memberId = self.memberId;
    }
}

@end
