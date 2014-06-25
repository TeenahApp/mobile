//
//  AddMemberRelationViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/22/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddMemberRelationViewController.h"

@interface AddMemberRelationViewController ()

@end

@implementation AddMemberRelationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
        NSMutableDictionary * relations = [[NSMutableDictionary alloc] init];
        
        NSDictionary * relationStrings = @{
                                 @"father": @"أب", @"stepfather": @"زوج الأم", @"father-in-law": @"أب الزوج", @"mother": @"أم", @"stepmother": @"زوج الأم", @"mother-in-law": @"أم الزوج", @"sister": @"أخت", @"brother": @"أخ", @"son": @"ابن", @"stepson": @"ابن الزوج", @"daughter": @"ابنة", @"stepdaughter": @"ابنة الزوج", @"son-in-law": @"زوج البنت", @"daughter-in-law": @"زوجة الابن", @"wife": @"زوجة", @"husband": @"زوج"
        };
        
        for (NSString * relation in self.acceptedRelations)
        {
            [relations setObject:[relationStrings objectForKey:relation] forKey:relation];
        }
        
        // Create the forms.
        self.form = [[AddMemberRelationForm alloc] initWithRelations:relations];
        
        // Set the variables.
        self.form.relationship = self.relation;
        self.form.isAlive = YES;
        self.form.secondRelationship = @"full";

        self.formController.form = self.form;
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

- (IBAction)back:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitAddingMemberRelationForm
{
    NSString * mobile = @"";
    NSDate * dob = (NSDate *)[NSNull null];
    NSDate * dod = (NSDate *)[NSNull null];
    
    if ([self.form.name isEqual:@""])
    {
        self.form.name = nil;
    }
    
    if (self.form.dob != nil)
    {
        dob = self.form.dob;
    }
    
    if (self.form.dod != nil)
    {
        dod = self.form.dod;
    }
    
    if (self.form.mobile != nil)
    {
        mobile = self.form.mobile;
    }
    
    if (![mobile isEqual:@""])
    {
        mobile = [self mobileFormatWithString:mobile];
    }
    
    // Validation.
    if (self.form.name == nil)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء إدخال اسم الفرد." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    NSString * secondRelationship = @"";
    
    if ([self.form.relationship isEqual:@"father"])
    {
        if (self.form.isRoot == YES)
        {
            secondRelationship = @"root";
        }
    }
    
    if ([self.form.relationship isEqual:@"brother"] || [self.form.relationship isEqual:@"sister"])
    {
        secondRelationship = self.form.secondRelationship;
    }
    
    // Send the adding request.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * createMemberRelationResponse = [[MembersCommunicator shared]createRelation:self.memberA isAlive:self.form.isAlive name:self.form.name relation:self.relation secondRelation:secondRelationship mobile:mobile dob:dob dod:dod];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (createMemberRelationResponse.code == 201)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"لم يتم إضافة الفرد، تأكّد من إدخال البيانات بشكل صحيح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)updateFields
{
    //refresh the form
    self.formController.form = self.formController.form;
    [self.tableView reloadData];
}

-(void)showContacts
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - ABPeoplePicker

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    // Ensure that the user picked a phone property.
    if(property == kABPersonPhoneProperty)
    {
        ABMultiValueRef phone = ABRecordCopyValue(person, property);
        
        NSString * chosenMobile = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, ABMultiValueGetIndexForIdentifier(phone, identifier));
        NSString * chosenFirstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        
        // Clean the mobile a bit.
        NSString * mobile = [self mobileFormatWithString:chosenMobile];
        
        self.form.name = chosenFirstName;
        self.form.mobile = mobile;
        
        [self updateFields];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    return NO;
}

-(NSString *)mobileFormatWithString:(NSString *)mobile
{
    // Special case.
    if (mobile.length == 10)
    {
        return [NSString stringWithFormat:@"966%lld", [mobile longLongValue]];
    }
    
    // Remove the characters.
    mobile = [[mobile componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    // Remove the leading zeros.
    mobile = [NSString stringWithFormat:@"%lld", [mobile longLongValue]];
    
    return mobile;
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
