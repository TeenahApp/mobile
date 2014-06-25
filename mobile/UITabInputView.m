//
//  UITabInputView.m
//  mobile
//
//  Created by Hussam Al-Zughaibi on 7/28/1435 AH.
//  Copyright (c) 1435 AH TeenahApp Org. All rights reserved.
//

#import "UITabInputView.h"

@implementation UITabInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithDelegate:(id)delegate hasAttachButton:(BOOL)hasAttachButton
{
    self = [super init];
    
    if (self) {
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
        
        self.screenRect = [[UIScreen mainScreen] bounds];
        
        self.screenWidth = self.screenRect.size.width;
        self.screenHeight = self.screenRect.size.height;
        
        // Set the main frame of the tab input.
        
        self.defaultKBY = self.screenHeight-kTabInputHeight;
        
        self.frame = CGRectMake(0, self.defaultKBY, self.screenWidth, kTabInputHeight);
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        // Set the borders of the view.
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = .25f;
        
        [self addSubview:view];
        
        CGFloat inputWidth = (self.bounds.size.width-(kTabPadding)) * kTextFieldWidthPercentage/100;
        CGFloat doneWidth = (self.bounds.size.width-(kTabPadding)) * kDoneButtonWidthPercentage/100;
        
        CGFloat inputW = inputWidth;
        CGFloat inputX = kTabPadding;
        
        if (hasAttachButton == YES)
        {
            inputW -= kTabInputHeight-(kTabPadding);
            inputX += kTabInputHeight-(kTabPadding);
        }
        
        // Text field.
        self.textField = [[UITextField alloc] initWithFrame:
                                   CGRectMake(inputX, kTabPadding, inputW, kTabInputHeight-(kTabPadding*2))];
        
        self.textField.placeholder = @"قُل خيراً.";
        self.textField.font = [UIFont systemFontOfSize:16];

        self.textField.delegate = self;
        
        [self addSubview:self.textField];
        
        // Done button.
        self.doneButton = [[UIButton alloc] initWithFrame:
                           CGRectMake(inputWidth+(kTabPadding*2), kTabPadding/2, doneWidth+(kTabPadding*3.8), kTabInputHeight-(kTabPadding))];
        
        self.doneButton.backgroundColor = [UIColor colorWithRed:(138/255.0) green:(174/255.0) blue:(223/255.0) alpha:1];
        
        [self.doneButton setTitle:@"إرسال" forState:UIControlStateNormal];
       
        [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.delegate = delegate;
        
        [self.doneButton addTarget:self.delegate action:@selector(didTouchDoneButton) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.doneButton];
        
        if (hasAttachButton == YES)
        {
            self.attachButton = [[UIButton alloc] initWithFrame:CGRectMake(kTabPadding/2, kTabPadding/2, kTabInputHeight-(kTabPadding), kTabInputHeight-(kTabPadding))];
        
            [self.attachButton setImage:[UIImage imageNamed:@"Paper"] forState:UIControlStateNormal];
        
            self.delegate = delegate;
            
            [self.attachButton addTarget:self.delegate action:@selector(didTouchAttachButton) forControlEvents:UIControlEventTouchUpInside];
        
            [self addSubview:self.attachButton];
        }
    }
    return self;
}

-(void)keyboardOnScreen:(NSNotification *)notification
{

    NSDictionary * userInfo = [notification userInfo];
    
    // Get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect temp = self.frame;
    temp.origin.y -= keyboardSize.height;
    
    self.frame = temp;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect temp = self.frame;
    temp.origin.y = self.defaultKBY;
    
    self.frame = temp;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
