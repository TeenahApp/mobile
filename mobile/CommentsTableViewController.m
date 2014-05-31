//
//  CommentsTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CommentsTableViewController.h"

@interface CommentsTableViewController ()

@end

#define kCommentInputHeight 40
#define kPadding 4

@implementation CommentsTableViewController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    TSweetResponse * tsr;
    
    //=
    if ([self.area isEqual:@"event"])
    {
        tsr = [[EventsCommunicator shared] getEventComments:self.affectedId];
    }

    else if ([self.area isEqual:@"media"])
    {
        tsr = [[MediasCommunicator shared] getMediaComments:self.affectedId];
    }
    
    // Define the comments array.
    self.sections = [[NSMutableArray alloc] init];
    self.comments = [[NSMutableArray alloc] init];
    
    if (tsr.code == 200)
    {
        for (NSDictionary * tempComment in tsr.json)
        {
            TComment * comment = [[TComment alloc] initWithJson:tempComment];
            
            NSLog(@"%@", comment);
            
            [self.sections addObject:comment.createdAt];
            [self.comments addObject:comment];
        }
    }
    
    //NSLog(@"comments: %@", self.comments);
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tabInput = [[UITabInputView alloc] initWithDelegate:self];
    
    [self.view.superview addSubview:self.tabInput];
}

-(void)dismissKeyboard
{
    [self.tabInput.textField resignFirstResponder];
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
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    TComment * comment = [self.comments objectAtIndex:indexPath.row];

    [cell initWithComment:comment];
    [cell.likeButton addTarget:self action:@selector(likeComment:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TComment * comment = [self.comments objectAtIndex:indexPath.row];
    return [UICommentTableViewCell cellHeightWithContent:comment.content width:self.view.bounds.size.width];
}

-(void)didTouchDoneButton
{
    TSweetResponse * tsr;
    
    // TODO: Done with validation.
    
    if ([self.area isEqual:@"event"])
    {
        tsr = [[EventsCommunicator shared] commentOnEvent:self.affectedId comment:self.tabInput.textField.text];
    }
    else if ([self.area isEqual:@"media"])
    {
        tsr = [[MediasCommunicator shared] commentOnMedia:self.affectedId comment:self.tabInput.textField.text];
    }
    
    if (tsr.code == 204)
    {
        NSLog(@"Done.");
        
        self.tabInput.textField.text = @"";
        [self dismissKeyboard];
    }
}

-(void)likeComment:(id)sender
{
    NSInteger commentId = ((UIButton *)sender).tag;

    TSweetResponse * tsr;
    
    if ([self.area isEqual:@"event"])
    {
        tsr = [[EventsCommunicator shared] likeCommentOnEvent:self.affectedId commentId:commentId];
    }
    else if ([self.area isEqual:@"media"])
    {
        tsr = [[MediasCommunicator shared] likeCommentOnMedia:self.affectedId commentId:commentId];
    }
    
    NSLog(@"Liked this comment.");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
