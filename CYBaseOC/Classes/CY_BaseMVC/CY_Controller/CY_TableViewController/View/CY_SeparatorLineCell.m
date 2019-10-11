//
//  CY_SeparatorLineCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_SeparatorLineCell.h"

@interface CY_SeparatorLineCell ()
@property (nonatomic, weak) CY_ImageView *cc_lineImageView;
@end

@implementation CY_SeparatorLineCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
        [self loadLineImageView];
        self.cc_lineImage = @"cell_separator_line_bottom".cc_image;
    }
    return self;
}

- (instancetype)initWithLeftMargin:(CGFloat)leftMargin {
    self = [super init];
    if (self) {
        self.cc_leftMargin = leftMargin;
    }
    return self;
}

- (void)loadLineImageView {
    CY_ImageView *imageView = [[CY_ImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.cc_lineImageView = imageView;
    
    [self.cc_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(@1).priorityHigh();
    }];
}

- (void)setCc_leftMargin:(CGFloat)cc_leftMargin {
    self->_cc_leftMargin = cc_leftMargin;
    [self.cc_lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(cc_leftMargin);
    }];
}

- (UIImage *)cc_lineImage {
    return self.cc_lineImageView.image;
}

- (void)setCc_lineImage:(UIImage *)cc_lineImage {
    self.cc_lineImageView.image = cc_lineImage;
}

@end
