//
//  CY_IDCardKeyboardView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_IDCardKeyboardView.h"

#define kLineWidth 0.5
#define kNumFont [UIFont systemFontOfSize:27]

@implementation CY_IDCardKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216);
        
        for (int i=0; i<4; i++) { // 行
            for (int j=0; j<3; j++) { // 列
                UIButton *button = [self createButtonWithX:i Y:j];
                [self addSubview:button];
            }
        }
        
        UIColor *color = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        //
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3.f, 0, kLineWidth, 216)];
        line1.backgroundColor = color;
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3.f*2, 0, kLineWidth, 216)];
        line2.backgroundColor = color;
        [self addSubview:line2];
        
        for (int i = 0; i < 3; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54*(i+1), [UIScreen mainScreen].bounds.size.width, kLineWidth)];
            line.backgroundColor = color;
            [self addSubview:line];
        }
    }
    return self;
}

- (UIButton *)createButtonWithX:(NSInteger)x Y:(NSInteger)y {
    UIButton *button;
    //
    CGFloat frameX = 0;
    CGFloat frameW = 0;
    switch (y) {
        case 0:
            {
                frameX = 0.0;
                frameW = [UIScreen mainScreen].bounds.size.width/3.f;
            }
            break;
            
        case 1:
        {
            frameX = [UIScreen mainScreen].bounds.size.width/3.f;
            frameW = [UIScreen mainScreen].bounds.size.width/3.f;
        }
            break;
            
        case 2:
        {
            frameX = [UIScreen mainScreen].bounds.size.width/3.f*2;
            frameW = [UIScreen mainScreen].bounds.size.width/3.f;
        }
            break;
            
        default:
            break;
    }
    
    CGFloat frameY = 54*x;
    
    //
    button = [[UIButton alloc] initWithFrame:CGRectMake(frameX, frameY, frameW, 54)];
    
    //
    NSInteger num = y+3*x+1;
    button.tag = num;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *colorNormal = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1];
    UIColor *colorHighlighted = [UIColor colorWithRed:186/255.0 green:189/255.0 blue:194/255.0 alpha:1];
    
    if (num == 10 || num == 12) {
        UIColor *colorTemp = colorNormal;
        colorNormal = colorHighlighted;
        colorHighlighted = colorTemp;
    }
    
    [button setBackgroundImage:colorNormal.cc_solidImage forState:UIControlStateNormal];
    [button setBackgroundImage:colorHighlighted.cc_solidImage forState:UIControlStateHighlighted];
    
    if (num < 10) { // "1"-"9"
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, frameW, 28)];
        label.text = [NSString stringWithFormat:@"%ld", (long)num];
        label.textColor = UIColor.blackColor;
        label.backgroundColor = UIColor.clearColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kNumFont;
        [button addSubview:label];
    }
    else if (num == 10) { // "X"
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.text = @"X";
        label.font = [UIFont systemFontOfSize:22];
        label.textColor = UIColor.blackColor;
        label.backgroundColor = UIColor.clearColor;
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
    }
    else if (num == 11) { // "0"
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.text = @"0";
        label.font = kNumFont;
        label.textColor = UIColor.blackColor;
        label.backgroundColor = UIColor.clearColor;
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
    }
    else { // "delete"
        NSBundle *bundle = [NSBundle bundleForClass:[CY_IDCardKeyboardView class]];
        NSString *path = [bundle pathForResource:@"CY_IDCardKeyboardView" ofType:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithPath:path];
        UIImage *img = [UIImage imageNamed:@"icon_delete" inBundle:imageBundle compatibleWithTraitCollection:nil];
        [button setImage:img forState:UIControlStateNormal];
    }
    return button;
}

- (void)clickButton:(UIButton *)sender {
    if (sender.tag == 10) {
        NSString *num = @"X";
        [self.delegate numberKeyboardInput:num];
    }
    else if (sender.tag == 12) {
        [self.delegate numberKeyboardBackspace];
    }
    else {
        NSInteger num = sender.tag;
        if (sender.tag == 11) {
            num = 0;
        }
        [self.delegate numberKeyboardInput:[NSString stringWithFormat:@"%ld", (long)num]];
    }
}

@end



#pragma mark - UITextField+ExtentRange
@implementation UITextField (ExtentRange)

// 获取选定范围
- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

// 设置选中范围
- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

// 设置光标位置
- (void)insertSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    
    // UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location];
    [self setSelectedTextRange:[self textRangeFromPosition:endPosition toPosition:endPosition]];
}

@end
