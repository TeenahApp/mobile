//
//  AddMemberEducationViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/25/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberEducationViewController.h"

@interface AddMemberEducationViewController ()

@end

@implementation AddMemberEducationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        
        NSMutableDictionary * degrees = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * statuses = [[NSMutableDictionary alloc] init];
        
        degrees = [
                   @{
                        @"elementary": @"إبتدائي", @"intermediate": @"متوسّط", @"secondary": @"ثانوي",
                        @"diploma": @"دبلوم", @"licentiate": @"إجازة", @"bachelor": @"بكالوريوس",
                        @"master": @"ماجستير", @"doctorate": @"دكتوراه",
                    }
        mutableCopy];
        
        statuses = [@{
                      @"ongoing": @"جارية", @"finished": @"منتهية", @"pending": @"معلّقة", @"dropped": @"محذوفة"
                    }
        mutableCopy];

        self.form = [[AddMemberEducationForm alloc] initWithDegrees:degrees statuses:statuses];
        
        self.form.degree = @"elementary";
        self.form.status = @"ongoing";
        
        self.formController.form = self.form;
        
        //self.alert = [[UIAlertView alloc] init];
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

-(void)submitAddingEducationForm
{
    // Validation.
    
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
    
    NSString * major = @"";
    
    if (self.form.major != nil)
    {
        major = self.form.major;
    }
    
    TSweetResponse * tsr = [[MembersCommunicator shared] createEducation:self.memberId degree:self.form.degree startYear:self.form.startYear finishYear:self.form.finishYear status:self.form.status major:major];
    
    if (tsr.code == 201)
    {
        // TODO: Fix the returning back issue.
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
