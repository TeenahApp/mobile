//
//  UIChatTableViewCell.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 8/9/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIChatTableViewCell : UITableViewCell

//-(void)initWithContent:(TComment *)comment;

+(CGFloat)cellHeightWithContent:(NSString *)content width:(CGFloat)width;
+(UILabel *)getContentLabelWithContent:(NSString *)content width:(CGFloat)width;

@end
