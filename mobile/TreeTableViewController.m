//
//  TreeTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/6/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "TreeTableViewController.h"

@interface TreeTableViewController ()

@end

@implementation TreeTableViewController

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

    [self updateMember:self.memberId];
    
    UIColor * teenahAppBlueColor = [UIColor colorWithRed:(138/255.0) green:(174/255.0) blue:(223/255.0) alpha:1];
    
    self.navigationController.navigationBar.barTintColor = teenahAppBlueColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    self.tabBarController.tabBar.tintColor = teenahAppBlueColor;
    
    self.relationStrings = @{
                       @"father": @"أب", @"stepfather": @"زوج الأم", @"father-in-law": @"أب الزوج", @"mother": @"أم", @"stepmother": @"زوج الأم", @"mother-in-law": @"أم الزوج", @"sister": @"أخت", @"brother": @"أخ", @"son": @"ابن", @"stepson": @"ابن الزوج", @"daughter": @"ابنة", @"stepdaughter": @"ابنة الزوج", @"son-in-law": @"زوج البنت", @"daughter-in-law": @"زوجة الابن", @"wife": @"زوجة", @"husband": @"زوج"
    };

    self.relations = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMember:) name:@"refreshMember" object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.memberId == 0)
    {
        UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"com.teenah-app.mobile"];
        [self updateMember:[store[@"memberid"] integerValue]];
    }
}

-(void)refreshMember:(NSNotification *) notification
{
    if (self.memberId != 0)
    {
        [self updateMember:self.memberId];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 1;
    }
    else
    {
        return self.member.children.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.member.father == nil)
        {
            UITableViewCell * familyCell = [tableView dequeueReusableCellWithIdentifier:@"familyCell" forIndexPath:indexPath];
            
            [familyCell.textLabel setText:[NSString stringWithFormat:@"عائلة %@", self.member.name]];

            return familyCell;
        }
        else
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"relatedNodeCell" forIndexPath:indexPath];
            
            cell.textLabel.text = self.member.father.displayName;
            cell.detailTextLabel.text = self.member.father.displayYears;
            
            return cell;
        }

    }
    else if (indexPath.section == 1)
    {
        UITreeNodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nodeCell" forIndexPath:indexPath];
        
        [cell.dispalyNameButton setTitle:self.member.displayName forState:UIControlStateNormal];
        [cell.dobdodLabel setText:self.member.displayYears];

        if (self.member.photo != nil)
        {
            // TODO: Show wait indicator.
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                NSURL * photoUrl = [NSURL URLWithString:self.member.photo];
                
                // Get the member photo.
                NSData * data = [NSData dataWithContentsOfURL:photoUrl];
                UIImage * photo = [[UIImage alloc]initWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.photo setImage:photo];
                });
            });
        }
        
        return cell;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"relatedNodeCell" forIndexPath:indexPath];
        
        TMember * relatedMember = (TMember *)[self.member.children objectAtIndex:indexPath.row];
        
        cell.textLabel.text = relatedMember.name;
        cell.detailTextLabel.text = relatedMember.displayYears;
        
        if (relatedMember.photo != nil)
        {
            // TODO: Show wait indicator.
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                NSURL * photoUrl = [NSURL URLWithString:relatedMember.photo];

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
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        TMember * relatedMember = (TMember *)[self.member.children objectAtIndex:indexPath.row];
        
        [self updateMember:relatedMember.memberId];
    }
    else if (indexPath.section == 0)
    {
        if (self.member.father != nil)
        {
            [self updateMember:self.member.father.memberId];
        }
    }
    else
    {
        [self performSegueWithIdentifier:@"showMemberView" sender:self];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nodeCell"];
        return cell.frame.size.height;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"relatedNodeCell"];
        return cell.frame.size.height;
    }
}

-(void)updateMember:(NSInteger)memberId
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        NSLog(@"tree");
        TSweetResponse * memberResponse = [[MembersCommunicator shared] getMember:memberId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Check if the response code is not successful.
            if (memberResponse.code == 200)
            {
                self.member = [[TMember alloc] initWithJson:memberResponse.json];
            }
            
            // Flush the relations that the user can add.
            [self.relations removeAllObjects];
            
            // Check if the member has already a father.
            if (self.member.father == nil && self.member.isRoot == NO)
            {
                [self.relations addObject:@"father"];
            }
            
            // Check if the member has already a mother.
            if (self.member.mother == nil)
            {
                [self.relations addObject:@"mother"];
            }
            
            [self.relations addObject:@"brother"];
            [self.relations addObject:@"sister"];
            [self.relations addObject:@"son"];
            [self.relations addObject:@"daughter"];
            
            // Check if the member is a male/female.
            if ([self.member.gender isEqual: @"male"])
            {
                [self.relations addObject:@"wife"];
            }
            else
            {
                [self.relations addObject:@"husband"];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    });
}


- (IBAction)addRelation:(id)sender
{
    // Fullfill the action sheet.
    self.actionSheet = [[UIActionSheet alloc]init];
    
    self.actionSheet.title = [NSString stringWithFormat:@"إضافة علاقة ل%@", self.member.name];
    self.actionSheet.delegate = self;
    
    for (NSString * relation in self.relations)
    {
        [self.actionSheet addButtonWithTitle:[self.relationStrings objectForKey:relation]];
    }

    self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"إلغاء"];
    
    // Show the action sheet.
    [self.actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < self.relations.count)
    {
        self.currentRelation = [self.relations objectAtIndex:buttonIndex];
        [self performSegueWithIdentifier:@"showAddRelation" sender:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqual:@"showMemberView"])
    {
        ViewMemberTableViewController * vc = (ViewMemberTableViewController *)[segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.member = self.member;
    }
    
    else if ([[segue identifier] isEqual:@"showAddRelation"])
    {
        AddMemberRelationViewController * vc = (AddMemberRelationViewController *)[segue destinationViewController];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.memberA = self.member.memberId;
        vc.relation = self.currentRelation;
        vc.acceptedRelations = self.relations;
        
        id tempVC = [vc initWithNibName:nil bundle:nil];
    }
}


@end
