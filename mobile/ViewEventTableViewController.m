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
    self.decision = @"notyet";
    
    TSweetResponse * decisionTsr = [[EventsCommunicator alloc] getDecision:self.eventId];
    
    if (decisionTsr.code == 200)
    {
        self.decision = [decisionTsr.json objectForKey:@"decision"];
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
                                        [@{@"label": @"حاضر", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.comingsCount]} mutableCopy],
                                        [@{@"label": @"إعجاب", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.likesCount]} mutableCopy],
                                        @{@"label": @"زيارة", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.viewsCount]},
                                        [@{@"label": @"تعليق", @"count": [NSString stringWithFormat:@"%ld", (long)self.event.commentsCount]} mutableCopy],
                                    ]
                        },
                       
                       @{@"يبدأ في": [longDateFormatter stringFromDate:self.event.startsAt]},
                       @{@"ينتهي في": [longDateFormatter stringFromDate:self.event.finishesAt]},
                    ],
                   
                   // Section 1: Decision.
                   @[
                       [@{@"Decision": self.decision} mutableCopy]
                    ],
                   
                   // Section 2: Creator.
                   @[
                       @{@"Creator": self.event.creator},
                    ],
                   
                   // Section 3: Comments.
                   [@[
                      [@{@"Add": (self.event.commentsCount == 0) ? @"إضافة تعليق" : [NSString stringWithFormat:@"عرض التعليقات الـ %ld أو إضافة", (long)self.event.commentsCount]} mutableCopy],
                    ] mutableCopy],
                   
                   // Section 4: Medias.
                   [@[
                       [@{@"Add": (self.event.medias.count == 0) ? @"إضافة صورة" : [NSString stringWithFormat:@"عرض الـ %lu صور أو إضافة", (long)self.event.medias.count]} mutableCopy],
                    ] mutableCopy],
    ] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Add observer(s).
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEventComments:) name:@"refreshEventComments" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEventMedias:) name:@"refreshEventMedias" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Observers.

-(void)refreshEventComments:(NSNotification *) notification
{
    self.event.commentsCount++;
    
    // Update the likes in the interface.
    [[[[[self.data objectAtIndex:0] objectAtIndex:0] objectForKey:@"Stats"] objectAtIndex:3] setObject:[NSString stringWithFormat:@"%d", self.event.commentsCount] forKey:@"count"];
    
    // Update the comments count in the interface.
    [[[self.data objectAtIndex:3] objectAtIndex:0] setObject:[NSString stringWithFormat:@"عرض التعليقات الـ %ld أو إضافة", (long)self.event.commentsCount] forKey:@"Add"];
    
    // And then, reload the data in the table.
    [self.tableView reloadData];
}

-(void)refreshEventMedias:(NSNotification *) notification
{
    //self.event.medi++;
    
    // Update the comments count in the interface.
    [[[self.data objectAtIndex:4] objectAtIndex:0] setObject:[NSString stringWithFormat:@"عرض الصور الـ %ld أو إضافة", (long)self.event.medias.count] forKey:@"Add"];
    
    // And then, reload the data in the table.
    [self.tableView reloadData];
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
        
        UIMultiColumnsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"statsCell" forIndexPath:indexPath];

        [cell setColumns:columns];
        
        return cell;
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        TMember * creator = (TMember *)[info objectForKey:key];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"creatorCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", creator.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", creator.fullname];
        
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        
        cell.textLabel.text = key;
        cell.detailTextLabel.text = value;
        
        return cell;
    }
    
    else if (indexPath.section == 1)
    {
        if ([value isEqual:@"notyet"])
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"decisionCell" forIndexPath:indexPath];
            
            UIButton * willComeButton = (UIButton *)[cell viewWithTag:11];
            [willComeButton addTarget:self action:@selector(didSayWillCome) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton * apologizeButton = (UIButton *)[cell viewWithTag:22];
            [apologizeButton addTarget:self action:@selector(didSayApologize) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
            
            cell.textLabel.text = @"قرارك";
            
            NSString * yours = @"تنوي الحضور";
            
            if ([value isEqual:@"apologize"])
            {
                yours = @"تعتذر عن الحضور";
            }
            
            cell.detailTextLabel.text = yours;
            
            return cell;
        }
    }

    // It is a comment then.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
    cell.textLabel.text = value;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"statsCell"];
        return cell.bounds.size.height;
    }
    
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
        return cell.bounds.size.height;
    }
}

- (IBAction)like:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        self.likeResponse = [[EventsCommunicator shared] likeEvent:self.event.eventId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.likeResponse.code == 204)
            {
                // Check if the action has been taken.
                self.event.hasLiked = YES;
                self.event.likesCount++;
                
                // Update the likes in the interface.
                [[[[[self.data objectAtIndex:0] objectAtIndex:0] objectForKey:@"Stats"] objectAtIndex:1] setObject:[NSString stringWithFormat:@"%d", self.event.likesCount] forKey:@"count"];
                
                [self.likeButton setEnabled:NO];
                
                // Show an alert saying thanks.
                self.alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"شكراً لك، تم تسجيل إعجابك." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                
                [self.tableView reloadData];
            }
            else
            {
                // Show an alert saying error.
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"لا يُمكنك تسجيل إعجابك، ربّما ليس لديك الصلاحيّة أو أنّك قد سجّلت إعجابك مُسبقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    });
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        [self performSegueWithIdentifier:@"showComments" sender:tableView];
    }
    else if (indexPath.section == 4)
    {
        [self performSegueWithIdentifier:@"showMedias" sender:tableView];
    }
}

-(void)didSayWillCome
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * decideResponse = [[EventsCommunicator shared] makeDecision:self.event.eventId decision:@"willcome"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (decideResponse.code == 204)
            {
                // Set some variables.
                self.event.comingsCount++;
                self.decision = @"willcome";

                [[[self.data objectAtIndex:1] objectAtIndex:0] setObject:self.decision forKey:@"Decision"];
                
                // Update the comings in the interface.
                [[[[[self.data objectAtIndex:0] objectAtIndex:0] objectForKey:@"Stats"] objectAtIndex:0] setObject:[NSString stringWithFormat:@"%d", self.event.comingsCount] forKey:@"count"];
                
                // Show an alert saying thanks.
                self.alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"شكراً لك، تم تسجيل قرارك." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                
                [self.tableView reloadData];
            }
            else
            {
                // Show an alert saying error.
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"لا يُمكنك تسجيل قرارك، ربّما ليس لديك الصلاحيّة أو أنّك قد سجّلت قرارك مُسبقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    });
}

-(void)didSayApologize
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        TSweetResponse * decideResponse = [[EventsCommunicator shared] makeDecision:self.event.eventId decision:@"apologize"];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.decision = @"apologize";
//            
//            NSMutableDictionary * decisionSection = [[self.data objectAtIndex:1] objectAtIndex:0];
//            [decisionSection setObject:self.decision forKey:@"Decision"];
//
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self.tableView reloadData];
//        });
//    });

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        TSweetResponse * decideResponse = [[EventsCommunicator shared] makeDecision:self.event.eventId decision:@"apologize"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (decideResponse.code == 204)
            {
                // Set some variables.
                self.decision = @"apologize";
                
                [[[self.data objectAtIndex:1] objectAtIndex:0] setObject:self.decision forKey:@"Decision"];
                
                // Show an alert saying thanks.
                self.alert = [[UIAlertView alloc] initWithTitle:@"تم" message:@"شكراً لك، تم تسجيل قرارك." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
                
                [self.tableView reloadData];
            }
            else
            {
                // Show an alert saying error.
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"لا يُمكنك تسجيل قرارك، ربّما ليس لديك الصلاحيّة أو أنّك قد سجّلت قرارك مُسبقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showMember"])
    {
        ViewMemberTableViewController *vc = (ViewMemberTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        vc.member = self.event.creator;
    }
    
    else if ([[segue identifier] isEqualToString:@"showComments"])
    {
        CommentsTableViewController *vc = (CommentsTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.area = @"event";
        vc.affectedId = self.eventId;
    }
    
    else if ([[segue identifier] isEqualToString:@"showMedias"])
    {
        ViewMediasViewController *vc = (ViewMediasViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.eventId = self.eventId;
        vc.medias = self.event.medias;
    }

}

@end
