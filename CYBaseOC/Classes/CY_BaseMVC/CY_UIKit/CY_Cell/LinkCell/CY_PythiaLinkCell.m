//
//  CY_PythiaLinkCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaLinkCell.h"
#import "CY_PythiaLinkString.h"

static void *PythiaLinkCellFrameChanged = &PythiaLinkCellFrameChanged;

@interface CY_PythiaLinkCell ()
@property (nonatomic, strong) NSAttributedString *richContent;
@end

@implementation CY_PythiaLinkCell

#pragma mark - 析构函数

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame" context:PythiaLinkCellFrameChanged];
}

#pragma mark - 页面构造

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cc_minimumCellHeight = 44;
    _cc_leftPadding = 15;
    _cc_topPadding = 8;
    _cc_bottomPadding = 8;
    _cc_rightPadding = 15;
    
    {
        UILabel *autoLayoutLabel = [[UILabel alloc] init];
        self.autoLayoutLabel.numberOfLines = 0;
        self.autoLayoutLabel.hidden = YES;
        [self.contentView addSubview:autoLayoutLabel];
        self.autoLayoutLabel = autoLayoutLabel;
    }
    {
        YYLabel *richLabel = [[YYLabel alloc] init];
        richLabel.numberOfLines = 0;
        richLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        [self.contentView addSubview:richLabel];
        self.richLabel = richLabel;
    }
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"frame" options:options context:PythiaLinkCellFrameChanged];
}

- (void)cc_layoutConstraints {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.width.equalTo(self.contentView.superview);
        make.height.greaterThanOrEqualTo(self.cc_minimumCellHeight).priorityHigh();
    }];
    
    [self.autoLayoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cc_leftPadding);
        make.right.equalTo(-self.cc_rightPadding);
        make.top.equalTo(self.cc_topPadding).priorityMedium();
        make.bottom.equalTo(-self.cc_bottomPadding).priorityMedium();
        make.centerY.equalTo(0).priorityLow();
    }];
    
    [self.richLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.autoLayoutLabel).offset(0);
    }];
}

#pragma mark - Getter and Setter

#pragma mark - 行

- (void)setCc_minimumCellHeight:(CGFloat)cc_minimumCellHeight {
    _cc_minimumCellHeight = cc_minimumCellHeight;
    [self cc_layoutConstraints];
}

#pragma mark - 外边距

- (void)setCc_topPadding:(CGFloat)cc_topPadding {
    self->_cc_topPadding = cc_topPadding;
    [self cc_layoutConstraints];
}

- (void)setCc_bottomPadding:(CGFloat)cc_bottomPadding {
    self->_cc_bottomPadding = cc_bottomPadding;
    [self cc_layoutConstraints];
}

- (void)setCc_leftPadding:(CGFloat)cc_leftPadding {
    self->_cc_leftPadding = cc_leftPadding;
    [self cc_layoutConstraints];
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.richLabel && self.richContent && self.richLabel.width) {
        YYTextLinePositionSimpleModifier *modifier = [[YYTextLinePositionSimpleModifier alloc] init];
        modifier.fixedLineHeight = 20;
        YYTextContainer *container = [[YYTextContainer alloc] init];
        container.size = CGSizeMake(self.richLabel.width, CGFLOAT_MAX);
        container.linePositionModifier = modifier;
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self.richContent];
        self.richLabel.textLayout = layout;
    }
}

#pragma mark - Setter And Getter

- (NSMutableArray *)attrStringArray {
    if (!_attrStringArray) {
        _attrStringArray = [[NSMutableArray alloc] init];
    }
    return _attrStringArray;
}

#pragma mark - RichString 操作

- (void)appendNormalText:(NSString *)text {
    [self appendRichStringWithText:text textColor:@"#999999".cc_color textFont:@"13px".cc_font isLink:NO linkFlag:nil];
}

- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag {
    [self appendRichStringWithText:text textColor:@"#2D99FA".cc_color textFont:@"13px".cc_font isLink:YES linkFlag:linkFlag];
}

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font {
    [self appendRichStringWithText:text textColor:textColor textFont:font isLink:NO linkFlag:nil];
}

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font isLink:(BOOL)isLink linkFlag:(NSString *)linkFlag {
    CY_PythiaLinkString *richString = [[CY_PythiaLinkString alloc] init];
    richString.string = text;
    richString.color = textColor;
    richString.font = font;
    richString.isLink = isLink;
    richString.linkFlag = linkFlag;
    [self appendRichString:richString];
}

- (void)appendButton:(UIButton *)button font:(UIFont *)font {
    CY_PythiaLinkString *richString = [[CY_PythiaLinkString alloc] init];
    richString.font = font;
    richString.button = button;
    [self appendRichString:richString];
}

- (void)appendRichString:(CY_PythiaLinkString *)richString {
    [self.attrStringArray addObject:richString];
    self.richContent = [self createAttributedStringWithAttributedStringArray:[self.attrStringArray copy]];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}

- (void)removeRichString {
    [self.attrStringArray removeAllObjects];
    self.richContent = [[NSAttributedString alloc] init];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}

#pragma mark - 创建 AttributedString

- (NSAttributedString *)createAttributedStringWithAttributedStringArray:(NSArray *)attributedStringArray {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for (CY_PythiaLinkString *richString in attributedStringArray) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
        if (richString.string) {
            [attrString yy_appendString:richString.string];
        }
        if (richString.color) {
            attrString.yy_color = richString.color;
        }
        if (richString.font) {
            attrString.yy_font = richString.font;
        }
        if (richString.isLink) {
            CC_WeakSelf
            NSString *linkFlag = richString.linkFlag;
            YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
            highlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                [weakSelf handleAttributedStringLinkTapWithLinkFlag:linkFlag];
            };
            [attrString yy_setTextHighlight:highlight range:attrString.yy_rangeOfAll];
        }
        if (richString.button) {
            attrString = [NSMutableAttributedString yy_attachmentStringWithContent:richString.button contentMode:UIViewContentModeBottom attachmentSize:richString.button.size alignToFont:richString.font alignment:YYTextVerticalAlignmentCenter];
        }
        [string appendAttributedString:attrString];
    }
    
    string.yy_minimumLineHeight = 20;
    return [string copy];
}

#pragma mark - Handle

- (void)handleAttributedStringLinkTapWithLinkFlag:(NSString *)linkFlag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(linkCell:didSelectLinkWithFlag:)]) {
        [self.delegate linkCell:self didSelectLinkWithFlag:linkFlag];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == PythiaLinkCellFrameChanged) {
        [self layoutSubviews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
