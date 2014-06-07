//
//  ViewEventTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/27/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewEventTableViewController.h"

@interface ViewEventTableViewController ()

@end

@implementation ViewEventTableViewController

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

    self.annotation = [[MKPointAnnotation alloc] init];
    
    TSweetResponse * tsr = [[EventsCommunicator shared] getEvent:self.eventId];
    
    if (tsr.code == 200)
    {
        self.event = [[TEvent alloc] initWithJson:tsr.json];
    }
    
    // Get the decision of the current member.
    NSString * decision = @"notyet";
    
    TSweetResponse * decisionTsr = [[EventsCommunicator alloc] getDecision:self.eventId];
    
    if (decisionTsr.code == 200)
    {
        decision = [decisionTsr.json objectForKey:@"decision"];
    }
    
    // Disable the like button if already liked.
    if (self.event.hasLiked == YES)
    {
        [self.likeButton setEnabled:NO];
    }
    
    // Set some initial values.
    self.title = self.event.title;
    
    CLLocation * coordinates = [[CLLocation alloc] initWithLatitude:[self.event.latitude floatValue] longitude:[self.event.longitude floatValue]];
    
    self.mapView.centerCoordinate = coordinates.coordinate;

    self.annotation.coordinate = coordinates.coordinate;
    self.annotation.title = self.event.location;
    
    [self.mapView addAnnotation:self.annotation];
    
    // Display it.
    [self.mapView selectAnnotation:self.annotation animated:YES];
    
    NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
    [longDateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    
    self.sections = @[@"Main Info", @"القرار", @"أُنشئت بواسطة", @"التعليقات", @"الصور"];
    
    self.data = [@[
                   
                   // Section 0: Main Info.
                   @[
                       
                       @{@"Stats": @[
                                        @{@"label": @"حاضر", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.comingsCount]},
                                        @{@"label": @"إعجاب", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.likesCount]},
                                        @{@"label": @"زيارة", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.viewsCount]},
                                        @{@"label": @"تعليق", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.commentsCount]},
                                    ]
                        },
                       
                       @{@"يبدأ في": [longDateFormatter stringFromDate:self.event.startsAt]},
                       @{@"ينتهي في": [longDateFormatter stringFromDate:self.event.finishesAt]},
                    ],
                   
                   // Section 1: Decision.
                   @[
                       @{@"Decision": decision},
                    ],
                   
                   // Section 2: Creator.
                   @[
                       @{@"Creator": self.event.creator},
                    ],
                   
                   // Section 3: Comments.
                   @[
                       @{@"Add": (self.event.commentsCount == 0) ? @"Add a comment." : [NSString stringWithFormat:@"View the %ld comments or add.", (long)self.event.commentsCount]},
                    ],
                   
                   // Section 4: Medias.
                   @[
                       @{@"Add": (self.event.medias.count == 0) ? @"Add a media." : [NSString stringWithFormat:@"View the %lu medias or add.", (long)self.event.medias.count]},
                    ],
    ] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * temp = [self.sections objectAtIndex:section];
    
    if ([temp isEqual:@"Main Info"])
    {
        temp = nil;
    }
    
    return temp;
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
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        TMember * creator = (TMember *)[info objectForKey:key];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreatorCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", creator.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", creator.fullname];
        
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
    
    else if (indexPath.section == 1)
    {
        if ([value isEqual:@"notyet"])
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DecisionCell" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
            
            cell.textLabel.text = @"Yours";
            cell.detailTextLabel.text = value;
            
            return cell;
        }
    }

    // It is a comment then.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell" forIndexPath:indexPath];
    cell.textLabel.text = value;

    return cell;
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

- (IBAction)like:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        self.likeResponse = [[EventsCommunicator shared] likeEvent:self.event.eventId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // TODO: Check if the action has been taken.
            self.event.hasLiked = YES;
            [self.likeButton setEnabled:NO];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        [self performSegueWithIdentifier:@"ViewComments" sender:tableView];
    }
    else if (indexPath.section == 4)
    {
        [self performSegueWithIdentifier:@"ViewMedias" sender:tableView];
    }
}

-(void)didSayWillCome
{
    TSweetResponse * tsr = [[EventsCommunicator shared] makeDecision:self.event.eventId decision:@"willcome"];
}

-(void)didSayApologize
{
    TSweetResponse * tsr = [[EventsCommunicator shared] makeDecision:self.event.eventId decision:@"apologize"];
}

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
        vc.member = self.event.creator;
    }
    
    else if ([[segue identifier] isEqualToString:@"ViewComments"])
    {
        CommentsTableViewController *vc = (CommentsTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.area = @"event";
        vc.affectedId = self.eventId;
    }
    
    else if ([[segue identifier] isEqualToString:@"ViewMedias"])
    {
        ViewEventMediasViewController *vc = (ViewEventMediasViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.eventId = self.eventId;
        vc.medias = self.event.medias;
    }

}

@end
