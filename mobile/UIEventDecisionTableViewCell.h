//
//  UIEventDecisionTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIEventDecisionTableViewCellDelegate <NSObject>

-(void) didSayWillCome;
-(void) didSayApologize;

@end

@interface UIEventDecisionTableViewCell : UITableViewCell

@property (nonatomic, assign) id<UIEventDecisionTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *willComeButton;
@property (weak, nonatomic) IBOutlet UIButton *apologizeButton;

@end
