//
//  UpdateMemberInfoViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/11/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UpdateMemberInfoViewController.h"

@interface UpdateMemberInfoViewController ()

@end

@implementation UpdateMemberInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        NSMutableDictionary * maritalStatuses = [[NSMutableDictionary alloc] init];
        
        maritalStatuses = [@{
                      @"single": @"أعزب", @"married": @"متزوج", @"widow": @"أرملة", @"divorced": @"مطلّقة"
        } mutableCopy];
        
        self.form = [[UpdateMemberInfoForm alloc] initWithMaritalStatuses:maritalStatuses];

        self.form.displayName = self.member.displayName;
        self.form.maritalStatus = self.member.maritalStatus;
        
        self.form.isAlive = self.member.isAlive;
        
        self.form.dob = self.member.dob;
        self.form.pob = self.member.pob;
        self.form.dod = self.member.dod;
        self.form.pod = self.member.pod;
        
        self.form.email = self.member.email;
        
        self.formController.form = self.form;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFields
{
    //refresh the form
    self.formController.form = self.formController.form;
    [self.tableView reloadData];
}

-(void)submitUpdatingMemberInfoForm
{
    NSLog(@"ms = %@", self.form.maritalStatus);
    
    if (self.form.maritalStatus == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال الحالة الاجتماعيّة." delegate:nil cancelButtonTitle:@"حسناً"otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    // Emptify everything.
    NSDate * dob = (NSDate *)[NSNull null];
    NSString * pob = (NSString *)[NSNull null];
    NSDate * dod = (NSDate *)[NSNull null];
    NSString * pod = (NSString *)[NSNull null];
    NSString * email = (NSString *)[NSNull null];
    
    if (self.form.dob != nil)
    {
        dob = self.form.dob;
    }
    
    if (self.form.pob != nil)
    {
        pob = self.form.pob;
    }
    
    if (self.form.dod != nil)
    {
        dod = self.form.dod;
    }
    
    if (self.form.pod != nil)
    {
        pod = self.form.pod;
    }
    
    if (self.form.email != nil)
    {
        email = self.form.email;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        self.updateResponse = [[MembersCommunicator shared] updateMember:self.member.memberId maritalStatus:self.form.maritalStatus dob:dob pob:pob dod:dod pod:pod email:email];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.updateResponse.code == 204)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else if (self.updateResponse.code == 400)
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"الرجاء التأكّد من تعبئة الحقول بشكلٍ صحيح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء تحديث معلومات الفرد، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
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
