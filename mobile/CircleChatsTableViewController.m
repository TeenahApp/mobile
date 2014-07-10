//
//  CircleChatsTableViewController.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/16/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "CircleChatsTableViewController.h"

@interface CircleChatsTableViewController ()

@end

@implementation CircleChatsTableViewController

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

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
    
    self.actionSheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"إلغاء" destructiveButtonTitle:nil otherButtonTitles:@"عرض الإحصائيات", @"عرض المناسبات", @"استعراض الأفراد", @"مغادرة الدائرة", nil];

    // Define the messages array.
    self.messages = [[NSMutableArray alloc] init];
        
        // Get the latest unread messages.
        TSweetResponse * getLatestReadResponse = [[CirclesCommunicator shared] getLatestRead:self.circleId];
            
            if (getLatestReadResponse.code == 200)
            {
                for (NSDictionary * tempCMM in getLatestReadResponse.json)
                {
                    TCircleMessageMember * circleMessageMember = [[TCircleMessageMember alloc] initWithJson:tempCMM];
                    [self.messages addObject:circleMessageMember];
                }
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء جلب الرسائل، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"ddMMyyHHmmss"];
}

-(void)viewDidAppear:(BOOL)animated
{
    // Display the tab input in the bottom of the view.
    self.tabInput = [[UITabInputView alloc] initWithDelegate:self hasAttachButton:YES];
    [self.view.superview addSubview:self.tabInput];
    
    [self getUnreadMessages];
}

-(void)getUnreadMessages
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Try to fetch the new messages.
        TSweetResponse * getLatestUnreadResponse = [[CirclesCommunicator shared] getLatestUnread:self.circleId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (getLatestUnreadResponse.code == 200)
            {
                for (NSDictionary * tempCMM in getLatestUnreadResponse.json)
                {
                    TCircleMessageMember * circleMessageMember = [[TCircleMessageMember alloc] initWithJson:tempCMM];
                    [self.messages addObject:circleMessageMember];
                }
            }
            else
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"خطأ" message:@"حدث خطـأ أثناء جلب الرسائل، الرجاء المحاولة مرّة أخرى." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            if (self.tableView.contentSize.height > self.tableView.frame.size.height)
            {
                CGPoint offset = CGPointMake(0, (self.tableView.contentSize.height - self.tableView.frame.size.height) + 80);
                [self.tableView setContentOffset:offset animated:YES];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    });
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
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCircleMessageMember * circleMM = [self.messages objectAtIndex:indexPath.row];
    
    if (circleMM.message.medias.count > 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chatImageCell" forIndexPath:indexPath];
        
        // Set the author of the message.
        UIButton * creatorButton = (UIButton *)[cell viewWithTag:22];
        UIImageView * imageView = (UIImageView *)[cell viewWithTag:11];
        
        [creatorButton setTitle:circleMM.message.creator.displayName forState:UIControlStateNormal];
        
        TMessageMedia * messageMedia = (TMessageMedia *)[circleMM.message.medias objectAtIndex:0];
        
        // TODO: Show wait indicator.
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSURL * photoUrl = [NSURL URLWithString:messageMedia.media.taste];
            
            // Get the member photo.
            NSData * data = [NSData dataWithContentsOfURL:photoUrl];
            UIImage * photo = [[UIImage alloc]initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:photo];
            });
        });
        
        return cell;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chatTextCell" forIndexPath:indexPath];
    
    // Set the content of the message.
    UILabel * content = (UILabel *)[cell viewWithTag:33];
    content.text = circleMM.message.content;
    
    // Set the author of the message.
    UIButton * creatorButton = (UIButton *)[cell viewWithTag:11];
    [creatorButton setTitle:circleMM.message.creator.displayName forState:UIControlStateNormal];
    
    // Set the time of the message.
    UILabel * createdAtLabel = (UILabel *)[cell viewWithTag:22];
    [createdAtLabel setText:[self.dateFormatter stringFromDate:circleMM.createdAt]];
    
    // Check if the message is not read.
    if ([circleMM.status isEqual:@"read"])
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:(251/255.0) green:(255/255.0) blue:(190/255.0) alpha:1];
    }
    
    return cell;
}

-(void)didTouchDoneButton
{
    NSArray * circles = @[[NSString stringWithFormat:@"%ld", (long)self.circleId]];
    
    NSString * trimmedText = [self.tabInput.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedText isEqual:@""])
    {
        self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"الرجاء كتابة نص لتتمكن من إرساله." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
        [self.alert show];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Send the message.
        TSweetResponse * sendTextResponse = [[MessagesCommunicator shared] sendText:self.tabInput.textField.text circles:circles];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (sendTextResponse.code == 204)
            {
                // Read the unread messages.
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self getUnreadMessages];
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"حدث خطأ أثناء إرسال الرسالة، الرجاء المحاولة لاحقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            self.tabInput.textField.text = @"";
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });


    [self dismissKeyboard];

//    NSLog(@"didTouchDoneButton has been called.");
//    NSLog(@"text = %@", self.tabInput.textField.text);
}

-(void)didTouchAttachButton
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCircleMessageMember * circleMM = [self.messages objectAtIndex:indexPath.row];
    
    if (circleMM.message.medias.count > 0)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chatImageCell"];
        return cell.frame.size.height;
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 100)];
    
    label.numberOfLines = 0;
    
    //label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = circleMM.message.content;
    label.backgroundColor = [UIColor redColor];
    
    [label sizeToFit];
    
    // Return.
    return label.frame.size.height + 40;
}


-(UIImage *)resizedImage: (UIImage *) original width:(CGFloat)width
{
    CGFloat originalWidth = original.size.width;
    CGFloat originalHeight = original.size.height;
    
    CGFloat ratio = width/originalWidth;
    
    CGFloat newHeight = originalHeight * ratio;
    CGSize newSize = CGSizeMake(width, newHeight);
    
    UIGraphicsBeginImageContext(newSize);
    [original drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSArray * circles = @[[NSString stringWithFormat:@"%ld", (long)self.circleId]];
    
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    
    UIImage * resizedImage = [self resizedImage:self.chosenImage width:320];
    
    // Upload the media.
    NSData * data = [NSData dataWithData:UIImagePNGRepresentation(resizedImage)];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // Get the member information.
        TSweetResponse * sendMediaResponse = [[MessagesCommunicator shared] sendMedia:@"image" data:data extension:@"png" circles:circles];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (sendMediaResponse.code == 204)
            {
                // Read the unread messages.
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self getUnreadMessages];
            }
            else
            {
                self.alert = [[UIAlertView alloc] initWithTitle:@"خطأ" message:@"حدث خطأ أثناء إرسال الرسالة، الرجاء المحاولة لاحقاً." delegate:nil cancelButtonTitle:@"حسناً" otherButtonTitles:nil];
                [self.alert show];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissKeyboard];
    
    TCircleMessageMember * circleMessageMember = (TCircleMessageMember *)[self.messages objectAtIndex:indexPath.row];
    
    if (circleMessageMember.message.medias.count > 0)
    {
        TMessageMedia * messageMedia = (TMessageMedia *)[circleMessageMember.message.medias objectAtIndex:0];
        
        self.selectedMedia = messageMedia.media;
        
        [self performSegueWithIdentifier:@"showMedia" sender:nil];
    }
}

-(void)dismissKeyboard
{
    [self.tabInput.textField resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqual:@"showMedia"])
    {
        ViewMediaTableViewController * vc = (ViewMediaTableViewController *)[segue destinationViewController];
        vc.media = self.selectedMedia;
    }
    else if ([[segue identifier] isEqual:@"showCircleEvents"])
    {
        EventsTableViewController * vc = (EventsTableViewController *)[segue destinationViewController];
        vc.circleId = self.circleId;
    }
    else if ([[segue identifier] isEqual:@"showCircleMembers"])
    {
        CircleMembersTableViewController * vc = (CircleMembersTableViewController *)[segue destinationViewController];
        vc.circleId = self.circleId;
    }
    else if ([[segue identifier] isEqual:@"showCircleStats"])
    {
        ViewCircleStatsTableViewController * vc = (ViewCircleStatsTableViewController *)[segue destinationViewController];
        vc.circleId = self.circleId;
    }
}

- (IBAction)moreToggle:(id)sender
{
    [self.actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            [self performSegueWithIdentifier:@"showCircleStats" sender:nil];
        }
        break;
            
        case 1:
        {
            [self performSegueWithIdentifier:@"showCircleEvents" sender:nil];
        }
        break;
            
        case 2:
        {
            [self performSegueWithIdentifier:@"showCircleMembers" sender:nil];
        }
        break;
            
        case 3:
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"لحظة من فضلك" message:@"هل أنت متأكد من أنّك تريد مغادرة الدائرة؟" delegate:self cancelButtonTitle:@"تراجع" otherButtonTitles:@"نعم", nil];
            
            [alert show];
        }
        break;
            
        default:
        break;
    }
    
    // 0. Stats.
    // 1. Events.
    // 2. Members.
    // 3. Leave the circle.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            // Get the member information.
            TSweetResponse * leaveCircleResponse = [[CirclesCommunicator shared]leave:self.circleId];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });

    }
}

@end
