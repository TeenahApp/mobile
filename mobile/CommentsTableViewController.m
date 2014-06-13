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
    
    [self loadComments];
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"ddMMyyHHmmss"];
}

-(void)loadComments
{
    TSweetResponse * tsr;

    if ([self.area isEqual:@"event"])
    {
        tsr = [[EventsCommunicator shared] getEventComments:self.affectedId];
    }
    
    else if ([self.area isEqual:@"media"])
    {
        tsr = [[MediasCommunicator shared] getMediaComments:self.affectedId];
    }
    
    else if ([self.area isEqual:@"member"])
    {
        tsr = [[MembersCommunicator shared] getMemberComments:self.affectedId];
    }
    
    // Define the comments array.
    self.comments = [[NSMutableArray alloc] init];
    
    if (tsr.code == 200)
    {
        for (NSDictionary * tempComment in tsr.json)
        {
            TComment * comment = [[TComment alloc] initWithJson:tempComment];
            
            [self.comments addObject:comment];
        }
    }
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    TComment * comment = [self.comments objectAtIndex:indexPath.row];

    UILabel * contentLabel = (UILabel *)[cell viewWithTag:44];
    contentLabel.text = comment.content;
    
    UIButton * creatorButton = (UIButton *)[cell viewWithTag:22];
    [creatorButton setTitle:comment.creator.displayName forState:UIControlStateNormal];
    
    UILabel * createdAtLabel = (UILabel *)[cell viewWithTag:33];
    [createdAtLabel setText:[self.dateFormatter stringFromDate:comment.createdAt]];
    
    UILabel * likesLabel = (UILabel *)[cell viewWithTag:55];
    likesLabel.text = [NSString stringWithFormat:@"%ld",(long)comment.likesCount];
    
    UIButton * likeButton = (UIButton *)[cell viewWithTag:66];
    
    if (comment.hasLiked == YES)
    {
        [likeButton setEnabled:NO];
    }
    else
    {
        self.currentComment = comment;
        [likeButton addTarget:self action:@selector(likeComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImageView * imageView = (UIImageView *)[cell viewWithTag:11];
    
    if (comment.creator.photo != nil)
    {
        // TODO: Show wait indicator.
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSURL * photoUrl = [NSURL URLWithString:comment.creator.photo];
            
            // Get the member photo.
            NSData * data = [NSData dataWithContentsOfURL:photoUrl];
            UIImage * photo = [[UIImage alloc]initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:photo];
            });
        });
    }
    
    return cell;
}

-(void)didTouchDoneButton
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
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
        else if ([self.area isEqual:@"member"])
        {
            tsr = [[MembersCommunicator shared] commentOnMember:self.affectedId comment:self.tabInput.textField.text];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (tsr.code == 204)
            {
                NSLog(@"Done.");
                
                self.tabInput.textField.text = @"";
                [self dismissKeyboard];
                
                [self loadComments];

                [self.tableView reloadData];
                [self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
}

-(void)likeComment:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * tsr;
        
        if ([self.area isEqual:@"event"])
        {
            tsr = [[EventsCommunicator shared] likeCommentOnEvent:self.affectedId commentId:self.currentComment.commentId];
        }
        else if ([self.area isEqual:@"media"])
        {
            tsr = [[MediasCommunicator shared] likeCommentOnMedia:self.affectedId commentId:self.currentComment.commentId];
        }
        else if ([self.area isEqual:@"member"])
        {
            tsr = [[MembersCommunicator shared] likeCommentOnMember:self.affectedId commentId:self.currentComment.commentId];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // TODO: Check if the response code is not successful.
            if (tsr.code == 204)
            {
                self.currentComment.likesCount++;
            }
            
            [self.tableView reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TComment * comment = [self.comments objectAtIndex:indexPath.row];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 100)];
    
    label.numberOfLines = 0;
    
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = comment.content;
    label.backgroundColor = [UIColor redColor];
    
    [label sizeToFit];
    
    // Return.
    return label.frame.size.height + 40 + 20;
}

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
