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
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.memberId == 0)
    {
        UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"com.teenah-app.mobile"];
        [self updateMember:[store[@"memberid"] integerValue]];
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
            
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
            cell.imageView.layer.masksToBounds = YES;
            
            return cell;
        }

    }
    else if (indexPath.section == 1)
    {
        UITreeNodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nodeCell" forIndexPath:indexPath];
        
        [cell.dispalyNameButton setTitle:self.member.displayName forState:UIControlStateNormal];
        [cell.dobdodLabel setText:self.member.displayYears];
        
        return cell;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"relatedNodeCell" forIndexPath:indexPath];
        
        TMember * relatedMember = (TMember *)[self.member.children objectAtIndex:indexPath.row];
        
        cell.textLabel.text = relatedMember.name;
        cell.detailTextLabel.text = relatedMember.displayYears;
        
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
        cell.imageView.layer.masksToBounds = YES;
        
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
        TSweetResponse * memberResponse = [[MembersCommunicator shared] getMember:memberId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // TODO: Check if the response code is not successful.
            if (memberResponse.code == 200)
            {
                self.member = [[TMember alloc] initWithJson:memberResponse.json];
            }

            [self.tableView reloadData];
            
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
    if ([[segue identifier] isEqual:@"showMemberView"])
    {
        ViewMemberTableViewController * vc = [segue destinationViewController];
        vc.member = self.member;
    }
}


@end
