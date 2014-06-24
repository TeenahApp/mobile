//
//  AddCircleTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/23/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "AddCircleTableViewController.h"

@interface AddCircleTableViewController ()

@end

@implementation AddCircleTableViewController

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
    
    self.members = [[NSMutableArray alloc] init];
    self.secondSectionData = [[NSMutableArray alloc] init];
    
    self.sections = @[@"اسم الدائرة", @"الأفراد", @""];
    
    self.data = [@[
                   @[@"circlename"],
                   
                   self.secondSectionData,
                   
                   @[@"done"],
    ] mutableCopy];
    
    // Add the (add) button to the second section.
    //[self.secondSectionData addObject:@{@"add": @"member"}];
    [self reloadMembers];
}

-(void)reloadMembers
{
    [self.secondSectionData removeAllObjects];
    
    for (NSDictionary * tempMember in self.members)
    {
        [self.secondSectionData addObject:@{@"mobile": [tempMember objectForKey:@"mobile"], @"name":[tempMember objectForKey:@"name"]}];
    }
    
    [self.secondSectionData addObject:@{@"add": @"member"}];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray * rows = [self.data objectAtIndex:section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
        
        self.textField = (UITextField *)[cell viewWithTag:11];
        [self.textField addTarget:self action:@selector(circleNameDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        return cell;
    }
    else
    {
        NSArray * rows = [self.data objectAtIndex:indexPath.section];
        
        if (indexPath.row == rows.count-1)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];
            NSDictionary * member = [self.secondSectionData objectAtIndex:indexPath.row];
            
            cell.detailTextLabel.text = [member objectForKey:@"mobile"];
            cell.textLabel.text = [member objectForKey:@"name"];

            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    
    if (indexPath.section != 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self hideKeyboard];
        
        // Check if the user touched the (Add) cell.
        if (indexPath.section == 1 && indexPath.row == rows.count-1)
        {
            ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
            
            picker.peoplePickerDelegate = self;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
        else if (indexPath.section == 2)
        {
            // Check if the circle name is empty or the members are empty.
            if (self.name == nil)
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"الرجاء تعبئة حقل اسم الدائرة المُراد إنشاؤها." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                return;
            }
            
            if (self.members.count == 0)
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"الرجاء اختيار أفراد لتتمكن من إنشاء الدائرة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                return;
            }
            
            // Get the member ids only not the whole thing.
            NSMutableArray * members = [[NSMutableArray alloc]init];
            
            for (NSDictionary * tempMember in self.members)
            {
                [members addObject:[tempMember objectForKey:@"id"]];
            }
            
            // Attempt to add the circle.
            TSweetResponse * createCircleResponse = [[CirclesCommunicator shared] createCircle:self.name members:members];
            
            if (createCircleResponse.code == 201)
            {
                // Ok.
                self.alert = [[UIAlertView alloc]initWithTitle:@"تم" message:@"تمّ إضافة الدائرة بنجاح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
            else
            {
                // Not ok.
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"لا يُمكن إضافة الدائرة الآن، الرجاء المحاولة لاحقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                return;
            }
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

-(void)circleNameDidChange:(UITextField *)textField
{
    self.name = textField.text;

    if ([self.name isEqual:@""])
    {
        self.name = nil;
    }
}

#pragma mark - ABPeoplePicker

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
        
        // Clean the mobile a bit.
        NSString * mobile = [self mobileFormatWithString:chosenMobile];
        
        // Get the member information.
        TSweetResponse * getMemberIdResponse = [[MembersCommunicator shared] getMemberIdByMobile:mobile];
        
        if (getMemberIdResponse.code == 200)
        {
            // Get the member id as an integer.
            NSInteger memberId = [[getMemberIdResponse.json objectForKey:@"id"] integerValue];
            NSString * name = [getMemberIdResponse.json objectForKey:@"name"];
            BOOL alreadyExists = NO;
            
            // TODO: Check if the member has been alredy added to the members array.
            for (NSDictionary * tempMember in self.members)
            {
                NSString * tempMemberMobile = [tempMember objectForKey:@"mobile"];
                
                if ([mobile isEqual:tempMemberMobile])
                {
                    alreadyExists = YES;
                }
            }
            
            if (alreadyExists == YES)
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"لا يًمكن إضافة هذا الفرد لأنّه قد أُضيف مسبقاً إلى الأفراد." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            else
            {
                [self.members addObject:@{@"mobile": mobile, @"id": @(memberId), @"name": name}];
                [self reloadMembers];
            }
        }
        else
        {
            self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"لا يُمكن إضافة الفرد لأنّه ليس مضافاً في قاعدة بيانات تطبيق تينه." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
            [self.alert show];
        }
        
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

- (void)hideKeyboard
{
    [self.textField resignFirstResponder];
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
