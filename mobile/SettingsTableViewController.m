//
//  SettingsTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/3/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

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
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    
    NSString *build = infoDictionary[(NSString*)kCFBundleVersionKey];

    // Set the version number.
    [self.appVersionLabel setText:build];
    
    UIColor * teenahAppBlueColor = [UIColor colorWithRed:(138/255.0) green:(174/255.0) blue:(223/255.0) alpha:1];
    
    self.navigationController.navigationBar.barTintColor = teenahAppBlueColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"com.teenah-app.mobile"];
    self.memberId = [store[@"memberid"] integerValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        [self goToEditMember];
    }
    
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        [self goToUploadPhoto];
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self goToLogoutMember];
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        [self goToTeenahAppWebsite];
    }
    else if (indexPath.section == 3 && indexPath.row == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/matej"]];
    }
    else if (indexPath.section == 3 && indexPath.row == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/kevinzhow"]];
    }
    else if (indexPath.section == 3 && indexPath.row == 2)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/kishikawakatsumi"]];
    }
    else if (indexPath.section == 3 && indexPath.row == 3)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/nicklockwood"]];
    }
}

-(void)goToEditMember
{
    [self performSegueWithIdentifier:@"showUpdateMember" sender:nil];
}

-(void)goToUploadPhoto
{
    [self performSegueWithIdentifier:@"showUploadPhotoView" sender:self];
}

-(void)goToTeenahAppWebsite
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.teenah-app.com/about.html"]];
}

-(void)goToLogoutMember
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * logoutResponse = [[UsersCommunicator shared] logout];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (logoutResponse.code == 204)
            {
                [UICKeyChainStore removeItemForKey:@"usertoken" service:@"com.teenah-app.mobile"];
                [UICKeyChainStore removeItemForKey:@"memberid" service:@"com.teenah-app.mobile"];
                
                [self performSegueWithIdentifier:@"showLoginView" sender:self];
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء تسجيل الخروج، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
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
    if ([[segue identifier] isEqual:@"showUploadPhotoView"])
    {
        FirstUploadPhotoTableViewController * fuptvc = (FirstUploadPhotoTableViewController *)[segue destinationViewController];
        
        fuptvc.memberId = self.memberId;
        fuptvc.isFirst = NO;
        
        fuptvc.hidesBottomBarWhenPushed = YES;
    }
    
    else if ([[segue identifier] isEqual:@"showUpdateMember"])
    {
        UpdateMemberInfoViewController * vc = (UpdateMemberInfoViewController *)[segue destinationViewController];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            TSweetResponse * getMemberResponse = [[MembersCommunicator shared] getMember:self.memberId];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (getMemberResponse.code == 200)
                {
                    TMember * member = [[TMember alloc] initWithJson:getMemberResponse.json];
                    
                    vc.member = member;
                    vc.hidesBottomBarWhenPushed = YES;
                    
                    id tempVC = [vc initWithNibName:nil bundle:nil];
                    
                    // Done.
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                }
                else
                {
                    self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطأ أثناء جلب معلومات الفرد، الرجاء المحاولة لاحقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                }
                
            });
        });
        
    }
}

@end
