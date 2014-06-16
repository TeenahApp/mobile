//
//  UITabInputView.h
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTabInputHeight 40
#define kPadding 6

#define kTextFieldWidthPercentage 75
#define kDoneButtonWidthPercentage 15

@protocol UITabInputViewDelegate <NSObject>

-(void) didTouchDoneButton;
-(void) didTouchAttachButton;

@end

@interface UITabInputView : UIView <UITextFieldDelegate>

@property (nonatomic, assign) id<UITabInputViewDelegate> delegate;

@property CGRect screenRect;
@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property CGRect keyboardFrame;

@property CGFloat defaultKBY;

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIButton * attachButton;
@property (nonatomic, strong) UIButton * doneButton;

-(id)initWithDelegate:(id)delegate hasAttachButton:(BOOL)hasAttachButton;

@end
