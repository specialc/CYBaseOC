//
//  CY_PythiaProtocolCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaProtocolCell.h"

static void *FrameChanged = &FrameChanged;

@interface CY_PythiaProtocolCell ()
@property (nonatomic, strong) NSAttributedString *richContent;
@end

@implementation CY_PythiaProtocolCell

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame" context:FrameChanged];
}

#pragma mark - 页面构造

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    {
        CY_CheckButton *checkButton = [[CY_CheckButton alloc] init];
        checkButton.cc_checkedImage = @"icon_checked".cc_image;
        _cc_checkButton.cc_uncheckedImage = @"icon_unchecked".cc_image;
        [checkButton addTarget:self action:@selector(handleCheckButtonCheckedChanged:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:checkButton];
        self.cc_checkButton = checkButton;
    }
    {
        CY_BaseLabel *autoLayoutLabel = [[CY_BaseLabel alloc] init];
        autoLayoutLabel.numberOfLines = 0;
        autoLayoutLabel.hidden = YES;
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
    [self addObserver:self forKeyPath:@"frame" options:options context:FrameChanged];
}

- (void)cc_layoutConstraints {
    [self.cc_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.height.equalTo(16 + 14);
        make.width.equalTo(16 + 14);
        make.centerY.equalTo(self.autoLayoutLabel.mas_top).offset(11);
    }];
    
    [self.autoLayoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cc_checkButton.mas_right).offset(1);
        make.right.equalTo(-15);
        make.top.equalTo(8);
        make.bottom.equalTo(-8);
    }];
}

#pragma mark - Setter And Getter

- (NSMutableArray *)attrStringArray {
    if (!_attrStringArray) {
        _attrStringArray = [[NSMutableArray alloc] init];
    }
    return _attrStringArray;
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
                [weakSelf handleLinkTapWithText:text flag:linkFlag];
            };
            [attrString yy_setTextHighlight:highlight range:attrString.yy_rangeOfAll];
        }
        [string appendAttributedString:attrString];
    }
    
    string.yy_minimumLineHeight = 20;
    return [string copy];
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.richLabel && self.richContent && self.autoLayoutLabel.width) {
        self.richLabel.frame = self.autoLayoutLabel.frame;
        YYTextLinePositionSimpleModifier *modifier = [[YYTextLinePositionSimpleModifier alloc] init];
        modifier.fixedLineHeight = 20;
        YYTextContainer *container = [[YYTextContainer alloc] init];
        container.size = CGSizeMake(self.autoLayoutLabel.width, CGFLOAT_MAX);
        container.linePositionModifier = modifier;
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self.richContent];
        self.richLabel.textLayout = layout;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == FrameChanged) {
        [self layoutSubviews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Handle

- (void)handleCheckButtonCheckedChanged:(CY_CheckButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_protocolCell:didSelectCheckButtonWithChecked:)]) {
        [self.delegate cc_protocolCell:self didSelectCheckButtonWithChecked:sender.cc_checked];
    }
}

- (void)handleLinkTapWithText:(NSAttributedString *)text flag:(NSString *)flag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_protocolCell:didSelectLink:flag:)]) {
        [self.delegate cc_protocolCell:self didSelectLink:text.string flag:flag];
    }
}

#pragma mark - RichString 操作

- (void)appendNormalText:(NSString *)text {
    [self appendRichStringWithText:text textColor:rgba(186, 186, 186, 1) textFont:@"13px".cc_font isLink:NO linkFlag:nil];
}

- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag {
    [self appendRichStringWithText:text textColor:rgba(0, 148, 236, 1) textFont:@"13px".cc_font isLink:YES linkFlag:linkFlag];
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

- (void)appendRichString:(CY_PythiaLinkString *)richString {
    [self.attrStringArray addObject:richString];
    self.richContent = [self createAttributedStringWithAttributedStringArray:[self.attrStringArray copy]];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}

- (void)clean {
    [self.attrStringArray removeAllObjects];
    self.richContent = [[NSAttributedString alloc] init];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}

@end
