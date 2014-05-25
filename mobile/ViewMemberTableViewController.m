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
    [super viewDidLoad];
    
    self.canAddEducation = YES;
    self.canAddJob = YES;
    
    self.sections = @[@"Avatar", @"Main Info", @"Personal", @"Contact", @"Relations", @"Educations", @"Jobs"];
    
    NSMutableArray * mainInfos = [[NSMutableArray alloc]init];
    NSMutableArray * relations = [[NSMutableArray alloc]init];
    NSMutableArray * educations = [[NSMutableArray alloc]init];
    NSMutableArray * jobs = [[NSMutableArray alloc]init];
    
    self.data = [@[
                  // Section 0: Avatar:
                  @[
                      @{@"Avatar": self.member.photo},
                    ],
                  
                  // Section 1: Main Info:
                  mainInfos,
                  
                  // Section 2: Personal:
                  @[
                      @{@"Pulse": [NSString stringWithFormat:@"%d", self.member.isAlive]},
                      @{@"Nick Name": [NSString stringWithFormat:@"%@", self.member.nickname]},
                    ],
                  
                  // Section 3: Contact:
                  @[
                      @{@"Location": [NSString stringWithFormat:@"%@", self.member.location]},
                      @{@"Mobile": [NSString stringWithFormat:@"%@", self.member.mobile]},
                      @{@"Email:": @"hossam_zee@yahoo.com"}, // TODO: Email
                      @{@"Home Phone": [NSString stringWithFormat:@"%@", self.member.homePhone]},
                      @{@"Work Phone": [NSString stringWithFormat:@"%@", self.member.workPhone]},
                    ],
                  
                  // Section 4: Relations:
                  relations,
                  
                  // Section 5: Educations:
                  educations,
                  
                  // Section 6: Jobs:
                  jobs,
                  
    ] mutableCopy];
    
    // Date Formatter.
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MM yyyy"];

    // Avatar.
    NSURL * imageURL = nil;
    
    if (![self.member.photo isEqual:[NSNull null]])
    {
        imageURL = [NSURL URLWithString:self.member.photo];
    }
    
    self.image = [[UIAvatarView alloc] initWithURL:imageURL frame:CGRectMake(0, 0, 60, 60)];
    
    // Main infos
    [mainInfos addObject:@{@"Fullname": [NSString stringWithFormat:@"%@", self.member.fullname]}];
    [mainInfos addObject:@{@"Age": [NSString stringWithFormat:@"%@", self.member.age]}];
    [mainInfos addObject:@{@"DOB": [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.member.dob]]}];
    [mainInfos addObject:@{@"DOD": [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.member.dod]]}];
    
    // Relations.
    for (NSDictionary * relatedMember in self.member.relations)
    {
        NSString * memberName = relatedMember[@"first_member"][@"name"];
        NSString * memberRelation = relatedMember[@"relationship"];

        [relations addObject:@{memberRelation: memberName}];
    }
    
    NSLog(@"educations count = %d", self.member.educations.count);
    
    // Educations.
    for (TMemberEducation * education in self.member.educations)
    {
        NSMutableString * years = [NSMutableString stringWithFormat:@"%d - ", education.startYear];
        NSMutableString * degreeMajor = [NSMutableString stringWithString:education.degree];
        
        if (education.finishYear == 0)
        {
            [years appendString:@"Present"];
        }
        else
        {
            [years appendFormat:@"%d", education.finishYear];
        }
        
        if (education.major != nil)
        {
            [degreeMajor appendFormat:@", %@", education.major.name];
        }
        
        // Add the education to education list.
        [educations addObject:@{years: degreeMajor}];
    }
    
    if (self.canAddEducation == YES)
    {
        [educations addObject:@{@"Add": [NSString stringWithFormat:@"%ld", (long)self.member.memberId]}];
    }
    
    // Jobs.
    for (TMemberJob * job in self.member.jobs)
    {
        NSMutableString * years = [NSMutableString stringWithFormat:@"%d - ", job.startYear];
        NSMutableString * titleCompany = [NSMutableString stringWithFormat:@"%@ at %@", job.title, job.company.name];
        
        if (job.finishYear == 0)
        {
            [years appendString:@"Present"];
        }
        else
        {
            [years appendFormat:@"%d", job.finishYear];
        }
        
        // Add the education to education list.
        [jobs addObject:@{years: titleCompany}];
    }

    if (self.canAddJob == YES)
    {
        [jobs addObject:@{@"Add": [NSString stringWithFormat:@"%ld", (long)self.member.memberId]}];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callMobile:(id)sender
{
    NSLog(@"Call");
    
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
    // Return the number of rows in the section.
    /*
    NSString *sectionTitle = [self.data.allKeys objectAtIndex:section];
    NSArray *sectionRows = [self.data objectForKey:sectionTitle];
    return sectionRows.count;
     */
    
    NSArray * rows = [self.data objectAtIndex:section];
    return rows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * temp = [self.sections objectAtIndex:section];
    
    if ([temp  isEqual: @"Main Info"] || [temp  isEqual: @"Avatar"])
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
    NSString * value = [info objectForKey:key];
    
    NSLog(@"key = %@, section = %d, row = %d", key, indexPath.section, indexPath.row);
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UIAvatarCellTableViewCell * cell = (UIAvatarCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"AvatarCell" forIndexPath:indexPath];

        cell.photo.image = self.image.image;
        
        return cell;
    }
    
    else if (indexPath.section == 5 || indexPath.section == 6)
    {
        if (indexPath.row == rows.count - 1 && [key isEqual:@"Add"])
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EducationCell" forIndexPath:indexPath];

            cell.textLabel.text = value;
            cell.detailTextLabel.text = key;
            
            return cell;
        }
    }
    
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

        [cell.textLabel setText:(NSString *)key];
        [cell.detailTextLabel setText:value];
        
        return cell;
    }

    //return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 120;
    }
    else
    {
        return tableView.rowHeight;
    }
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
    NSArray * rows = [self.data objectAtIndex:indexPath.section];
    NSDictionary * info = [rows objectAtIndex:indexPath.row];
    
    NSString * key = [[info allKeys] objectAtIndex:0];
    
    if (indexPath.section == 5 && indexPath.row == rows.count - 1 && [key isEqual:@"Add"])
    {
        [self performSegueWithIdentifier:@"AddEducation" sender:nil];
    }

    else if (indexPath.section == 6 && indexPath.row == rows.count - 1 && [key isEqual:@"Add"])
    {
        [self performSegueWithIdentifier:@"AddJob" sender:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Called");
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //sender.
    
    if ([[segue identifier] isEqualToString:@"AddEducation"])
    {
        // Get reference to the destination view controller
        AddMemberEducationViewController *vc = (AddMemberEducationViewController *) [segue destinationViewController];
        vc.memberId = self.member.memberId;
        
        NSLog(@"member_id = %d", vc.memberId);
        
        [vc initWithNibName:nil bundle:nil];
        
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    else if ([[segue identifier] isEqualToString:@"AddJob"])
    {
        // Get reference to the destination view controller
        AddMemberJobViewController *vc = (AddMemberJobViewController *) [segue destinationViewController];
        vc.memberId = self.member.memberId;
        
        NSLog(@"member_id = %d", vc.memberId);
        
        [vc initWithNibName:nil bundle:nil];
        
        vc.hidesBottomBarWhenPushed = YES;
    }

}

@end
