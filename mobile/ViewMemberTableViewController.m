//
//  ViewMemberTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 6/26/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "ViewMemberTableViewController.h"

@interface ViewMemberTableViewController ()

@end

@implementation ViewMemberTableViewController

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
    NSLog(@"viewDidLoad has been called.");
    
    [super viewDidLoad];
    
    NSLog(@"member = %@", self.member);
    
    if (self.member.hasLiked == YES)
    {
        [self.likeButton setEnabled:NO];
    }
    
    self.canAddEducation = YES;
    self.canAddJob = YES;
    
    self.degrees = @{
                     @"elementary": @"إبتدائي", @"intermediate": @"متوسّط", @"secondary": @"ثانوي",
                     @"diploma": @"دبلوم", @"licentiate": @"إجازة", @"bachelor": @"بكالوريوس",
                     @"master": @"ماجستير", @"doctorate": @"دكتوراه",
    };
    
    self.relations = @{
                       @"father": @"أب", @"stepfather": @"زوج الأم", @"father-in-law": @"أب الزوج", @"mother": @"أم", @"stepmother": @"زوج الأم", @"mother-in-law": @"أم الزوج", @"sister": @"أخت", @"brother": @"أخ", @"son": @"ابن", @"stepson": @"ابن الزوج", @"daughter": @"ابنة", @"stepdaughter": @"ابنة الزوج", @"son-in-law": @"زوج البنت", @"daughter-in-law": @"زوجة الابن", @"wife": @"زوجة", @"husband": @"زوج"
    };
    
    NSString * isAliveString = @"حيّ يرزق";
    
    if (self.member.isAlive == NO)
    {
        isAliveString = @"متوفّى";
    }

    self.sections = @[@"Main Info", @"المعلومات الأوليّة", @"الإتصال", @"العلاقات", @"التعليم", @"العمل", @"التعليقات", @""];
    
    NSMutableArray * mainInfos = [[NSMutableArray alloc]init];
    NSMutableArray * personal = [[NSMutableArray alloc]init];
    NSMutableArray * contacts = [[NSMutableArray alloc]init];
    NSMutableArray * relations = [[NSMutableArray alloc]init];
    NSMutableArray * educations = [[NSMutableArray alloc]init];
    NSMutableArray * jobs = [[NSMutableArray alloc]init];
    
    self.data = [@[
                  
                  // Section 0: Main Info:
                  mainInfos,
                  
                  // Section 1: Personal:
                  personal,

                  // Section 2: Contact:
                  contacts,

                  // Section 3: Relations:
                  relations,
                  
                  // Section 4: Educations:
                  educations,
                  
                  // Section 5: Jobs:
                  jobs,
                  
                  // Section 6: Comments.
                  @[
                      @{@"Add": (self.member.commentsCount == 0) ? @"إضافة تعليق" : [NSString stringWithFormat:@"عرض التعليقات الـ %ld أو إضافة", (long)self.member.commentsCount]},
                    ],

                  
                  // Section 8: Update.
                  @[
                      @{@"Update": @""}
                    ],

    ] mutableCopy];
    
    // Date Formatter.
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    
    // Main infos
    [mainInfos addObject:
     @{@"Stats":
           @[
              @{@"label": @"سنة", @"count": [NSString stringWithFormat:@"%ld", (long)self.member.age]},
              @{@"label": @"إعجاب", @"count": [NSString stringWithFormat:@"%ld", (long)self.member.likesCount]},
              @{@"label": @"زيارة", @"count": [NSString stringWithFormat:@"%ld", (long)self.member.viewsCount]},
              @{@"label": @"تعليق", @"count": [NSString stringWithFormat:@"%ld", (long)self.member.commentsCount]}
            ]
       }];

    if (self.member.dob != nil)
    {
        [mainInfos addObject:@{@"تاريخ الميلاد": [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.member.dob]]}];
    }
    
    if (self.member.dod != nil)
    {
        [mainInfos addObject:@{@"تاريخ الوفاة": [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.member.dod]]}];
    }
    
    // Personal.
    [personal addObject:@{@"الاسم الكامل": [NSString stringWithFormat:@"%@", self.member.fullname]}];
    [personal addObject:@{@"النبض": [NSString stringWithFormat:@"%@", isAliveString]}];
    
    if (self.member.pob != nil)
    {
        [personal addObject:@{@"مكان الميلاد": [NSString stringWithFormat:@"%@", self.member.pob]}];
    }
    
    if (self.member.pod != nil)
    {
        [personal addObject:@{@"مكان الوفاة": [NSString stringWithFormat:@"%@", self.member.pod]}];
    }
    
    // Contacts.
    if (self.member.location != nil)
    {
        [contacts addObject:@{@"الإقامة": [NSString stringWithFormat:@"%@", self.member.location]}];
    }
    
    if (self.member.mobile != nil)
    {
        [contacts addObject:@{@"الجوّال": [NSString stringWithFormat:@"%@", self.member.mobile]}];
    }
    
    NSLog(@"email = %@", self.member.email);
    
    if (self.member.email != nil)
    {
        [contacts addObject:@{@"البريد الإلكتروني": [NSString stringWithFormat:@"%@", self.member.email]}];
    }
    
    if (self.member.homePhone != nil)
    {
        [contacts addObject:@{@"هاتف المنزل": [NSString stringWithFormat:@"%@", self.member.homePhone]}];
    }
    
    if (self.member.workPhone != nil)
    {
        [contacts addObject:@{@"هاتف العمل": [NSString stringWithFormat:@"%@", self.member.workPhone]}];
    }
    
    // Relations.
    for (NSDictionary * relatedMember in self.member.relations)
    {
        NSString * memberName = relatedMember[@"first_member"][@"name"];
        NSString * memberRelation = self.relations[relatedMember[@"relationship"]];

        [relations addObject:@{memberRelation: memberName}];
    }

    // Educations.
    for (TMemberEducation * education in self.member.educations)
    {
        NSMutableString * years = [NSMutableString stringWithFormat:@"%ld - ", (long)education.startYear];
        NSString * major = @"";
        
        if (education.finishYear == 0)
        {
            [years appendString:@"الآن"];
        }
        else
        {
            [years appendFormat:@"%ld", (long)education.finishYear];
        }
        
        if (education.major != nil)
        {
            major = education.major.name;
        }
        
        // Add the education to education list.
        [educations addObject:@{@"maintitle": self.degrees[education.degree], @"subtitle": major, @"details": years}];
    }
    
    if (self.canAddEducation == YES)
    {
        [educations addObject:@{@"Add": @"إضافة"}];
    }
    
    // Jobs.
    for (TMemberJob * job in self.member.jobs)
    {
        NSMutableString * years = [NSMutableString stringWithFormat:@"%ld - ", (long)job.startYear];
        
        if (job.finishYear == 0)
        {
            [years appendString:@"الآن"];
        }
        else
        {
            [years appendFormat:@"%ld", (long)job.finishYear];
        }

        // Add the job to job list.
        [jobs addObject:@{@"maintitle": job.title, @"subtitle": job.company.name, @"details": years}];
    }

    if (self.canAddJob == YES)
    {
        [jobs addObject:@{@"Add": @"إضافة"}];
    }
    
    self.image.layer.cornerRadius = 48.0;
    self.image.layer.masksToBounds = YES;
    
    if (self.member.photo != nil)
    {
        // TODO: Show wait indicator.
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSURL * photoUrl = [NSURL URLWithString:self.member.photo];
            
            // Get the member photo.
            NSData * data = [NSData dataWithContentsOfURL:photoUrl];
            UIImage * photo = [[UIImage alloc]initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.image setImage:photo];
            });
        });
    }
    
    // Fill the display name of the member.
    [self.displayNameButton setTitle:self.member.displayName forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callMobile:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.member.mobile]]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rows = [self.data objectAtIndex:section];
    return rows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * temp = [self.sections objectAtIndex:section];
    
    if ([temp  isEqual: @"Main Info"])
    {
        return nil;
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

    else
    {
        if (indexPath.section >= 4)
        {
            if (indexPath.row == rows.count - 1 && [key isEqual:@"Add"])
            {
                NSString * value = [info objectForKey:key];
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gotoCell" forIndexPath:indexPath];
                cell.textLabel.text = value;
                
                return cell;
            }
            
            if (indexPath.row == rows.count - 1 && [key isEqual:@"Update"])
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"updateCell" forIndexPath:indexPath];
                return cell;
            }
            else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"careerCell" forIndexPath:indexPath];

                UILabel * topLabel = (UILabel *)[cell viewWithTag:66];
                [topLabel setText:[info objectForKey:@"maintitle"]];
                
                UILabel * subLabel = (UILabel *)[cell viewWithTag:77];
                [subLabel setText:[info objectForKey:@"subtitle"]];
                
                UILabel * detailsLabel = (UILabel *)[cell viewWithTag:88];
                [detailsLabel setText:[info objectForKey:@"details"]];
            
                return cell;
            }
        }
        else
        {
            NSString * value = [info objectForKey:key];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
            
            [cell.textLabel setText:(NSString *)key];
            [cell.detailTextLabel setText:value];
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
        
        self.likeResponse = [[MembersCommunicator shared] likeMember:self.member.memberId];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            // TODO: Check if the action has been taken.
            self.member.hasLiked = YES;
            [self.likeButton setEnabled:NO];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    NSDictionary * info = [rows objectAtIndex:indexPath.row];
    
    NSString * key = [[info allKeys] objectAtIndex:0];
    
    if (indexPath.section == 4 && indexPath.row == rows.count - 1 && [key isEqual:@"Add"])
    {
        [self performSegueWithIdentifier:@"AddEducation" sender:nil];
    }

    else if (indexPath.section == 5 && indexPath.row == rows.count - 1 && [key isEqual:@"Add"])
    {
        [self performSegueWithIdentifier:@"AddJob" sender:nil];
    }
    
    else if (indexPath.section == 6)
    {
        [self performSegueWithIdentifier:@"showCommentsView" sender:nil];
    }
    
    else if (indexPath.section == 7)
    {
        [self performSegueWithIdentifier:@"updateInfo" sender:nil];
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddEducation"])
    {
        // Get reference to the destination view controller
        AddMemberEducationViewController *vc = (AddMemberEducationViewController *) [segue destinationViewController];
        vc.memberId = self.member.memberId;

        [vc initWithNibName:nil bundle:nil];
        
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    else if ([[segue identifier] isEqualToString:@"AddJob"])
    {
        // Get reference to the destination view controller
        AddMemberJobViewController *vc = (AddMemberJobViewController *) [segue destinationViewController];
        vc.memberId = self.member.memberId;
        
        [vc initWithNibName:nil bundle:nil];
        
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    else if([[segue identifier] isEqualToString:@"updateInfo"])
    {
        UpdateMemberInfoViewController *vc = (UpdateMemberInfoViewController *) [segue destinationViewController];
        vc.member = self.member;
        
        [vc initWithNibName:nil bundle:nil];
    }
    
    else if ([[segue identifier] isEqualToString:@"showCommentsView"])
    {
        CommentsTableViewController *vc = (CommentsTableViewController *) [segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.area = @"member";
        vc.affectedId = self.member.memberId;
    }

}

@end
