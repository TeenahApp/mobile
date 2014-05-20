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
    
    CGRect newBounds = self.tableView.bounds;
    
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
    
    // TODO: Change the circle id to be a variable, thanks to @ecleel.
    TSweetResponse * tsr = [[CirclesCommunicator shared] getMembers:@"1"];
    
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
        member = (TMember *) [self.filteredMembers objectAtIndex:indexPath.row];
    } else {
        member = (TMember *) [self.members objectAtIndex:indexPath.row];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", member.name]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", member.fullname]];
    
    // TODO: Load the images in a separate thread.
    
    
    NSURL * imageURL = nil;
    
    if ([member.photo isEqual:[NSNull null]])
    {
        // TODO: Fix the image regarding to the gender of the member.
        //       Display a man with Shmagh, and a woman whit a Hijab.
        NSLog(@"============= Nil");
        imageURL = [NSURL URLWithString:@"http://i2.wp.com/www.maas360.com/assets/Uploads/defaultUserIcon.png"];
    }
    else
    {
        NSLog(@"============= Not nil");
        imageURL = [NSURL URLWithString:member.photo];
    }
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    cell.imageView.layer.cornerRadius = 20;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderWidth = 4;
    
    cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.imageView.image = image;
    
    //cell.imageView
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if(self.tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"Searched");
    }
    else
    {
        NSLog(@"NotSearched");
    }
    
    self.currentMember = (TMember *) [self.members objectAtIndex:indexPath.row];
    
    //[self performSegueWithIdentifier:@"ViewMember" sender:nil];
    
    NSLog(@"Clicked: %@", self.currentMember);
     */
    [self performSegueWithIdentifier:@"ViewMember" sender:tableView];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"ViewMember"])
    {
        NSLog(@"prepareForSegue");
        
        // Get reference to the destination view controller
        //YourViewController *vc = [segue destinationViewController];
        
        //ViewMemberTableViewController *vc = (ViewMemberTableViewController *) [segue destinationViewController];
        
        //vc.hidesBottomBarWhenPushed = YES;
        
        //vc.member = self.currentMember;
        
        if(sender == self.searchDisplayController.searchResultsTableView)
        {
            NSLog(@"Searched.");
        }
        else
        {
            NSLog(@"NotSearched.");
        }
    }

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
