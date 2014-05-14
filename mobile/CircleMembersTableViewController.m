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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    TSweetResponse * tsr = [[CirclesCommunicator shared] getMembers:@"1"];
    
    self.members = [[NSMutableArray alloc] init];
    
    for (NSDictionary * memberDictionary in tsr.json)
    {
        TMember * member = [[TMember alloc] init];
        [member fromJson:memberDictionary];
        
        [self.members addObject:member];
    }
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
    // Return the number of rows in the section.
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    // objectAtIndex:indexPath.row
    TMember * member = (TMember *) [self.members objectAtIndex:indexPath.row];
    
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
    
    /*
    cell.imageView.layer.cornerRadius = 20;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderWidth = 4;
    
    cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    */
    
    cell.imageView.image = image;
    
    //cell.imageView
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentMember = (TMember *) [self.members objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ViewMember" sender:nil];
    
    NSLog(@"Clicked: %@", self.currentMember);
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
        
        ViewMemberTableViewController *vc = (ViewMemberTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.member = self.currentMember;
    }

}

@end
