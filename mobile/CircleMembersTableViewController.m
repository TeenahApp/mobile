//
//  CircleMembersTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/13/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CircleMembersTableViewController.h"

@interface CircleMembersTableViewController ()

@end

@implementation CircleMembersTableViewController

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

    [self loadMembers];
}

-(void)loadMembers
{
    self.members = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the members of the circle id.
        TSweetResponse * getMembersResponse = [[CirclesCommunicator shared] getMembers:self.circleId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (getMembersResponse.code == 200)
            {
                for (NSDictionary * tempMember in getMembersResponse.json)
                {
                    TMember * member = [[TMember alloc] initWithJson:tempMember];
                    [self.members addObject:member];
                }
                
                // This is for searching for members.
                self.filteredMembers = [[NSMutableArray alloc] initWithCapacity:self.members.count];
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء جلب الأفراد، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    });
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return self.filteredMembers.count;
    }
    else
    {
        return self.members.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    TMember * member;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        member = [self.filteredMembers objectAtIndex:indexPath.row];
    } else {
        member = [self.members objectAtIndex:indexPath.row];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", member.name]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", member.fullname]];
    
    if (member.photo != nil)
    {
        // TODO: Show wait indicator.
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSURL * photoUrl = [NSURL URLWithString:member.photo];
            
            // Get the member photo.
            NSData * data = [NSData dataWithContentsOfURL:photoUrl];
            UIImage * photo = [[UIImage alloc]initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.imageView setImage:photo];
            });
        });
    }

    return cell;
}

#pragma mark Content Filtering

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredMembers removeAllObjects];
    
    // Filter the array using NSPredicate
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredMembers = [NSMutableArray arrayWithArray:[self.members filteredArrayUsingPredicate:predicate]];
}

- (IBAction)addMember:(id)sender
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
        
        // Check if the mobile is correct.
        NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
        
        NSError *anError = nil;
        NBPhoneNumber *tempMobile = [phoneUtil parseWithPhoneCarrierRegion:chosenMobile error:&anError];
        
        if (anError != nil || [phoneUtil isValidNumber:tempMobile] == NO)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء التأكد من إدخال رقم جوّال بالصياغة الصحيحة." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
            
            [alert show];
            return NO;
        }
        
        // Clean the mobile a bit.
        NSString * mobile = [self mobileFormatWithString:tempMobile];
        
        NSLog(@"mobile = %@", mobile);

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            // Get the member information.
            TSweetResponse * getMemberIdResponse = [[MembersCommunicator shared] getMemberIdByMobile:mobile];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (getMemberIdResponse.code == 200)
                {
                    // Get the member id as an integer.
                    NSInteger memberId = [[getMemberIdResponse.json objectForKey:@"id"] integerValue];

                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        
                        // Try to add the member to the circle.
                        TSweetResponse * createMembersResponse = [[CirclesCommunicator shared] createMembers:self.circleId members:@[@(memberId)]];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (createMembersResponse.code == 201)
                            {
                                [self loadMembers];
                                
                                self.alert = [[UIAlertView alloc]initWithTitle:@"تم" message:@"تمّت عملية إضافة الفرد بنجاح." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                                [self.alert show];
                            }
                            else
                            {
                                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"لا يُمكن إضافة الفرد لأنّه قد يكون أضُيف مسبقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                                [self.alert show];
                            }
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        });
                    });
                }
                else
                {
                    self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"لا يُمكن إضافة الفرد لأنّه ليس مضافاً في قاعدة بيانات تطبيق تينه." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                    [self.alert show];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    return;
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
    }

    return NO;
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

#pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
