//
//  CY_TableViewCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"

@interface CY_TableViewCell ()

@end

@implementation CY_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cc_loadViews];
    [self cc_layoutConstraints];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (!self.cc_separatorHidden && self.selectionStyle != UITableViewCellSelectionStyleNone) {
        NSTimeInterval duration = animated ? 0.25 : 0.;
        [UIView animateWithDuration:duration delay:0. options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.cc_separator.alpha = highlighted ? 0.1 : 1.;
        } completion:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (!self.cc_separatorHidden && self.selectionStyle != UITableViewCellSelectionStyleNone) {
        NSTimeInterval duration = animated ? 0.25 :0.;
        [UIView animateWithDuration:duration delay:0. options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.cc_separator.alpha = selected ? 0.1 : 1.;
        } completion:nil];
    }
}

#pragma mark - 构造函数

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cc_loadViews];
        [self cc_layoutConstraints];
    }
    return self;
}

#pragma mark - Subview处理函数

- (void)cc_loadViews {
    self.backgroundColor = UIColor.clearColor;
    {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.cc_bgView = view;
        self.cc_bgView.hidden = YES;
        [self.cc_bgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    
    _cc_separatorColor = [UIColor cc_colorWithRGB:0xF4F4F4];
    _cc_separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _cc_separatorHeight = .5f;
    
    {
        CY_ImageView *imageView = [[CY_ImageView alloc] init];
        [self.contentView addSubview:imageView];
        _cc_separator = imageView;
        _cc_separator.image = self.cc_separatorColor.cc_solidImage;
        [self.cc_separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cc_separatorEdgeInset.left);
            make.right.equalTo(-self.cc_separatorEdgeInset.right);
            make.bottom.equalTo(-self.cc_separatorEdgeInset.bottom);
            make.height.equalTo(self.cc_separatorHeight).priorityHigh();
        }];
    }
    self.cc_separatorHidden = YES;
}

- (void)cc_layoutConstraints {
    
}

#pragma mark - Getter Setter

- (UIColor *)cc_backgroundColor {
    return self.contentView.backgroundColor;
}

- (void)setCc_backgroundColor:(UIColor *)cc_backgroundColor {
    self.contentView.backgroundColor = cc_backgroundColor;
}

- (void)setCc_separatorHidden:(BOOL)cc_separatorHidden {
    _cc_separatorHidden = cc_separatorHidden;
    
    self.cc_separator.hidden = cc_separatorHidden;
    [self.cc_separator bringToFront];
}

- (void)setCc_separatorEdgeInset:(UIEdgeInsets)cc_separatorEdgeInset {
    _cc_separatorEdgeInset = cc_separatorEdgeInset;
    
    [self.cc_separator updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cc_separatorEdgeInset.left);
        make.right.equalTo(-cc_separatorEdgeInset.right);
        make.bottom.equalTo(-cc_separatorEdgeInset.bottom);
    }];
}

- (void)setCc_separatorHeight:(CGFloat)cc_separatorHeight {
    _cc_separatorHeight = cc_separatorHeight;
    
    [self.cc_separator updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.cc_separatorHeight).priority(1000);
    }];
}

- (void)setCc_separatorColor:(UIColor *)cc_separatorColor {
    _cc_separatorColor = cc_separatorColor;
    
    self.cc_separator.image = cc_separatorColor.cc_solidImage;
}

+ (CGFloat)heightForData:(id)data {
    return 44;
}

+ (void)load {
    // 因为10.2中存在计算高度的bug，所以特意加上钩子添加约束
    SEL originalSelector = @selector(systemLayoutSizeFittingSize:);
    SEL swizzledSelector = NSSelectorFromString([@"cc_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
    Method originalMethod = class_getInstanceMethod(UIView.class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(UIView.class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end


// Version比较：sv: system_version tv: targer_version
#define VERSION_GREATER(sv, tv) ({\
NSArray *sr = [sv componentsSeparatedByString:@"."];\
NSArray *tr = [tv componentsSeparatedByString:@"."];\
NSInteger s1 = sr.count > 0 ? [sr[0] integerValue] : 0;\
NSInteger s2 = sr.count > 1 ? [sr[1] integerValue] : 0;\
NSInteger s3 = sr.count > 2 ? [sr[2] integerValue] : 0;\
NSInteger t1 = tr.count > 0 ? [tr[0] integerValue] : 0;\
NSInteger t2 = tr.count > 1 ? [tr[1] integerValue] : 0;\
NSInteger t3 = tr.count > 2 ? [tr[2] integerValue] : 0;\
s1 != t1 ? (s1 > t1) : s2 != t2 ? (s2 > t2) : s3 > t3;\
}) // sv > tv

#define VESSION_LESS(sv, tv) VERSION_GREATER(tv, sv) // sv < tv
#define VERSION_GREATER_OR_EQUAL(sv, tv) ([sv isEqualToString:tv] || VERSION_GREATER(sv, tv)) // sv >= tv
#define VESSION_LESS_OR_EQUAL(sv, tv) ([sv isEqualToString:tv] || VESSION_LESS(sv, tv)) // sv <= tv

@implementation UIView (swizzled)

- (CGSize)cc_systemLayoutSizeFittingSize:(CGSize)targetSize {
    NSString *sversion = [UIDevice currentDevice].systemVersion; //sversion = @"10.2.9";
    
    // 系统版本>=10.2 并且<10.3, 并且是CY_TableCell的contentView
    if (VERSION_GREATER_OR_EQUAL(sversion, @"10.2") && VESSION_LESS(sversion, @"10.3") && [self.superview isKindOfClass:[CY_TableViewCell class]] && [self isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        __block MASConstraint *width = nil;
        [self makeConstraints:^(MASConstraintMaker *make) {
            width = make.width.equalTo(UIScreen.mainScreen.bounds.size.width);
        }];
        // NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:];
        CGSize size = [self cc_systemLayoutSizeFittingSize:targetSize];
        [width uninstall];
        return size;
    }
    return [self cc_systemLayoutSizeFittingSize:targetSize];
}

@end
