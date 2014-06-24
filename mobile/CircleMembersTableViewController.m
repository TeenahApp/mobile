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
    // Get the members of the circle id.
    TSweetResponse * tsr = [[CirclesCommunicator shared] getMembers:self.circleId];
    
    self.members = [[NSMutableArray alloc] init];
    
    for (NSDictionary * tempMember in tsr.json)
    {
        TMember * member = [[TMember alloc] initWithJson:tempMember];
        [self.members addObject:member];
    }
    
    // This is for searching for members.
    self.filteredMembers = [[NSMutableArray alloc] initWithCapacity:self.members.count];
    
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
    
    // Load the images in a separate thread.
//    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
//    cell.imageView.layer.masksToBounds = YES;
    
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
        
        NSLog(@"mobile = %@", mobile);
        
        // Get the member information.
        TSweetResponse * getMemberIdResponse = [[MembersCommunicator shared] getMemberIdByMobile:mobile];
        
        if (getMemberIdResponse.code == 200)
        {
            // Get the member id as an integer.
            NSInteger memberId = [[getMemberIdResponse.json objectForKey:@"id"] integerValue];
            
            // Try to add the member to the circle.
            TSweetResponse * createMembersResponse = [[CirclesCommunicator shared] createMembers:self.circleId members:@[@(memberId)]];
            
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
