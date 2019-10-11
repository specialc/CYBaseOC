//
//  CY_PythiaSeparatorLineCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/25.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaSeparatorLineCell.h"

@interface CY_DashLine : UIView
@property (nonatomic, strong) UIColor *color;
@end

@implementation CY_DashLine

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context, rect.size.height);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGFloat lengths[] = {10, 10};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    CGContextMoveToPoint(context, 0, CGRectGetHeight(rect) * 0.5);
    CGContextAddLineToPoint(context, rect.size.width, CGRectGetHeight(rect) * 0.5);
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end



@interface CY_PythiaSeparatorLineCell ()

@end

@implementation CY_PythiaSeparatorLineCell

@dynamic cc_separatorHeight;

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cc_separatorHidden = NO;
}

- (void)cc_layoutConstraints {
    [self.cc_separator mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cc_separatorEdgeInset.left);
        make.right.equalTo(-self.cc_separatorEdgeInset.right);
        make.top.equalTo(self.cc_separatorEdgeInset.top).priorityMedium();
        make.bottom.equalTo(-self.cc_separatorEdgeInset.bottom);
        make.height.equalTo(self.cc_separatorHeight).priority(1000);
    }];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.width.equalTo(self.contentView.superview);
        make.height.greaterThanOrEqualTo(1);
    }];
}

- (void)setCc_separatorHeight:(CGFloat)cc_separatorHeight {
    super.cc_separatorHeight = cc_separatorHeight;
    [self cc_layoutConstraints];
}

@end
