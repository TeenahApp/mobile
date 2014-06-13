//
//  ViewMediaTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/1/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewMediaTableViewController.h"

@interface ViewMediaTableViewController ()

@end

@implementation ViewMediaTableViewController

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
    
    TSweetResponse * tsr = [[MediasCommunicator shared] getMedia:self.media.mediaId];
    
    // Set the new media variable.
    self.media = [[TMedia alloc] initWithJson:tsr.json];
    
    // Check if the current user has liked the media.
    if (self.media.hasLiked == YES)
    {
        [self.likeButton setEnabled:NO];
    }
    
    TSweetResponse * creatorTSR = [[MembersCommunicator shared] getMember:self.media.createdBy];
    self.media.creator = [[TMember alloc] initWithJson:creatorTSR.json];
    
    NSURL * URL = [NSURL URLWithString:self.media.url];
    
    // Try to load the URL.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData * imageData = [NSData dataWithContentsOfURL:URL];
        
        self.image = [UIImage imageWithData:imageData];
        
        // Load the URL.
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self.imageView setImage:self.image];
        });
        
        // Done.
        
    });
    
    NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
    [longDateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    //NSString * eventTime = [NSString stringWithFormat:@"%@ - %@", [longDateFormatter stringFromDate:self.event.startsAt], [longDateFormatter stringFromDate:self.event.finishesAt]];
    
    self.sections = @[@"Main Info", @"Creator", @"Comments"];
    
    self.data = [@[
                   
                   // Section 0: Main Info.
                   @[
                       
                       @{@"Stats": @[
                                    @{@"label": @"Views", @"count": [NSString stringWithFormat:@"%d", self.media.viewsCount]},
                                    @{@"label": @"Likes", @"count": [NSString stringWithFormat:@"%d", self.media.likesCount]},
                                    @{@"label": @"Cmnts", @"count": [NSString stringWithFormat:@"%d", self.media.commentsCount]},
                                 ]
                         },
                       
                       @{@"Created at": [longDateFormatter stringFromDate:self.media.createdAt]},
                    ],
                   
                   // Section 1: Creator.
                   @[
                       @{@"Creator": self.media.creator},
                    ],
                   
                   // Section 2: Comments.
                   @[
                       @{@"Add": (self.media.commentsCount == 0) ? @"Add a comment." : [NSString stringWithFormat:@"View the %d comments or add.", self.media.commentsCount]},
                    ],
    ] mutableCopy];
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
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    NSDictionary * info = [rows objectAtIndex:indexPath.row];
    
    NSString * key = [[info allKeys] objectAtIndex:0];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        NSArray * columns = [info objectForKey:key];
        
        UIMultiColumnsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StatsCell" forIndexPath:indexPath];
        
        [cell setColumns:columns];
        
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        TMember * creator = (TMember *)[info objectForKey:key];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreatorCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", creator.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", creator.fullname];
        
        // TODO: Stopped in here.
        if (creator.photo != nil)
        {
            // TODO: Show wait indicator.
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                NSURL * photoUrl = [NSURL URLWithString:creator.photo];
                
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
    
    NSString * value = [info objectForKey:key];
    
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        
        cell.textLabel.text = key;
        cell.detailTextLabel.text = value;
        
        return cell;
    }
    
    // It is a comment then.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell" forIndexPath:indexPath];
    cell.textLabel.text = value;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * temp = [self.sections objectAtIndex:section];
    
    if ([temp isEqual:@"Main Info"])
    {
        temp = @"";
    }
    
    return temp;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StatsCell"];
        return cell.bounds.size.height;
    }
    
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
        return cell.bounds.size.height;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"ViewComments" sender:tableView];
    }
}

- (IBAction)like:(id)sender
{
    TSweetResponse * tsr = [[MediasCommunicator shared] likeMedia:self.media.mediaId];
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
        ViewMemberTableViewController *vc = (ViewMemberTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        vc.member = self.media.creator;
    }
    
    else if ([[segue identifier] isEqualToString:@"ViewComments"])
    {
        CommentsTableViewController *vc = (CommentsTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.area = @"media";
        vc.affectedId = self.media.mediaId;
    }
    
}

@end
