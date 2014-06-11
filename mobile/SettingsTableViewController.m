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
}

-(void)goToEditMember
{
    
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
    TSweetResponse * logoutResponse = [[UsersCommunicator shared] logout];
    
    [UICKeyChainStore removeItemForKey:@"usertoken" service:@"com.teenah-app.mobile"];
    [UICKeyChainStore removeItemForKey:@"memberid" service:@"com.teenah-app.mobile"];
    
    [self performSegueWithIdentifier:@"showLoginView" sender:self];
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
}

@end
