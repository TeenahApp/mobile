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

-(id)initWithDelegate:(id)delegate
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
        
        CGFloat inputWidth = (self.bounds.size.width-(kPadding)) * kTextFieldWidthPercentage/100;
        CGFloat doneWidth = (self.bounds.size.width-(kPadding)) * kDoneButtonWidthPercentage/100;
        
        // Text field.
        self.textField = [[UITextField alloc] initWithFrame:
                                   CGRectMake(kPadding, kPadding, inputWidth, kTabInputHeight-(kPadding*2))];
        
        self.textField.placeholder = @"Have a say.";
        self.textField.font = [UIFont systemFontOfSize:16];

        self.textField.delegate = self;
        
        [self addSubview:self.textField];
        
        // Button.
        self.doneButton = [[FUIButton alloc] initWithFrame:
                           CGRectMake(inputWidth+(kPadding*2), kPadding/2, doneWidth+(kPadding*3.8), kTabInputHeight-(kPadding))];
        
        self.doneButton.buttonColor = [UIColor turquoiseColor];
        
        [self.doneButton setTitle:@"Send" forState:UIControlStateNormal];
       
        [self.doneButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        
        self.delegate = delegate;
        
        [self.doneButton addTarget:self.delegate action:@selector(didTouchDoneButton) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.doneButton];
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
