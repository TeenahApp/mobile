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
    
//    CGRect newBounds = self.tableView.bounds;
//    
//    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
//    self.tableView.bounds = newBounds;
    
    // TODO: Change the circle id to be a variable, thanks to @ecleel.
    TSweetResponse * tsr = [[CirclesCommunicator shared] getMembers:self.circleId];
    
    self.members = [[NSMutableArray alloc] init];
    
    for (NSDictionary * tempMember in tsr.json)
    {
        TMember * member = [[TMember alloc] initWithJson:tempMember];
        [self.members addObject:member];
    }
    
    // This is for searching for members.
    self.filteredMembers = [[NSMutableArray alloc] initWithCapacity:self.members.count];
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
    
    // Configure the cell...
    // objectAtIndex:indexPath.row
    
    TMember * member;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        member = [self.filteredMembers objectAtIndex:indexPath.row];
    } else {
        member = [self.members objectAtIndex:indexPath.row];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", member.name]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", member.fullname]];
    
    // TODO: Load the images in a separate thread.
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
    cell.imageView.layer.masksToBounds = YES;
    
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
    
    NSLog(@"%@", self.filteredMembers);
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
