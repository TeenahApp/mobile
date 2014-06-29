//
//  AddMemberJobViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberJobViewController.h"

@interface AddMemberJobViewController ()

@end

@implementation AddMemberJobViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
        NSMutableDictionary * statuses = [[NSMutableDictionary alloc] init];
        
        statuses = [@{
                      @"ongoing": @"جاري", @"finished": @"متقاعد", @"pending": @"معلّق", @"dropped": @"مستقيل"
                      }
        mutableCopy];
        
        self.form = [[AddMemberJobForm alloc] initWithStatuses:statuses];
        
        self.form.status = @"ongoing";
        
        self.formController.form = self.form;
    }
    return self;
}

-(void)submitAddingJobForm
{
    if (self.form.startYear == 0)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال سنة البدء بطريقة صحيحة." delegate:nil cancelButtonTitle:@"حسناً"otherButtonTitles:nil];
        
        [self.alert show];
        return;
    }
    
    if (![self.form.status isEqual:@"ongoing"] && self.form.finishYear == 0)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال سنة الانتهاء بطريقة صحيحة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        
        [self.alert show];
        return;
    }
    
    if (self.form.title == nil || self.form.company == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء تعبئة المسمّى الوظيفي و جهة العمل." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        
        [self.alert show];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Try to create a job.
        TSweetResponse * createJobResponse = [[MembersCommunicator shared] createJob:self.memberId title:self.form.title startYear:self.form.startYear finishYear:self.form.finishYear status:self.form.status company:self.form.company];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (createJobResponse.code == 201)
            {
                // FIXME: the returning back issue.
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء إضافة الوظيفة، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
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
