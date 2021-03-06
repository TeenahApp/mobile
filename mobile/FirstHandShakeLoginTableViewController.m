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
    [self.logoView addGestureRecognizer:gestureRecognizer];
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

- (void)sendTempPassword
{
    // Check if the mobile is correct.
    NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
    
    NSError *anError = nil;
    NBPhoneNumber *tempMobile = [phoneUtil parseWithPhoneCarrierRegion:self.mobileTextField.text error:&anError];
    
    if (anError != nil || [phoneUtil isValidNumber:tempMobile] == NO)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء التأكد من إدخال رقم جوّال بالصياغة الصحيحة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];

        [alert show];
        return;
    }

    // Format the mobile as good as possible.
    self.mobile = [self mobileFormatWithString:tempMobile];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Do something...
        self.tokenizeResponse = [[UsersCommunicator shared] tokenize:self.mobile];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (self.tokenizeResponse.code == 204)
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"تم إرسال كلمة المرور المؤقتة إلى رقم الجوّال المُدخل، قد تصل بعد لحظات، و إذا كانت قد أرسلت لك كلمة مرور مؤقتة قبل قليل فهي صالحة للاستخدام." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                
                [alert show];
                
                [self performSegueWithIdentifier:@"showSecondHandShakeLogin" sender:nil];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء التأكد من إدخال رقم جوّال بالصياغة الصحيحة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                
                [alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

#pragma - Table View

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        [self sendTempPassword];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSecondHandShakeLogin"])
    {
        SecondHandShakeLoginTableViewController *vc = (SecondHandShakeLoginTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        vc.mobile = self.mobile;
    }
}

-(NSString *)mobileFormatWithString:(NBPhoneNumber *)mobile
{
    NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
    
    NSError *anError = nil;
    NSString * stringMobile = [phoneUtil format:mobile numberFormat:NBEPhoneNumberFormatE164 error:&anError];
    
    // Remove the characters.
    stringMobile = [[stringMobile componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    return stringMobile;
}

@end
