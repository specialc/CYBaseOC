//
//  CY_ImageCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_ImageCell.h"

@interface CY_ImageCell ()

@end

@implementation CY_ImageCell

- (void)cc_loadViews {
    [super cc_loadViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cc_alignment = CY_ImageCellAlignmentFill;
    _cc_imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.cc_imageView = imageView;
}

- (void)cc_layoutConstraints {
    switch (self.cc_alignment) {
        case CY_ImageCellAlignmentLeft:
        {
            [self.cc_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cc_imageEdgeInsets.left).priorityHigh();
                make.right.lessThanOrEqualTo(-self.cc_imageEdgeInsets.right);
                make.top.equalTo(self.cc_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.cc_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        case CY_ImageCellAlignmentCenter:
        {
            [self.cc_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.cc_imageEdgeInsets.left);
                make.right.lessThanOrEqualTo(-self.cc_imageEdgeInsets.right);
                make.top.equalTo(self.cc_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.cc_imageEdgeInsets.bottom).priorityHigh();
                make.centerX.equalTo(0).priorityHigh();
            }];
        }
            break;
            
        case CY_ImageCellAlignmentRight:
        {
            [self.cc_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.cc_imageEdgeInsets.left);
                make.right.equalTo(-self.cc_imageEdgeInsets.right).priorityHigh();
                make.top.equalTo(self.cc_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.cc_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        case CY_ImageCellAlignmentFill:
        {
            [self.cc_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cc_imageEdgeInsets.left).priorityHigh();
                make.right.equalTo(-self.cc_imageEdgeInsets.right).priorityHigh();
                make.top.equalTo(self.cc_imageEdgeInsets.top).priorityHigh().priorityHigh();
                make.bottom.equalTo(-self.cc_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        case CY_ImageCellAlignmentExtend:
        {
            [self.cc_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cc_imageEdgeInsets.left).priorityHigh();
                make.right.equalTo(-self.cc_imageEdgeInsets.right).priorityHigh();
                make.top.equalTo(self.cc_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.cc_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        default:
            break;
    }
    
    if (self.cc_image && self.cc_alignment != CY_ImageCellAlignmentExtend) {
        CGFloat ratio = self.cc_image.size.height / self.cc_image.size.width;
        [self.cc_imageView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.cc_imageView.mas_width).multipliedBy(ratio);
        }];
    }
    
    if (self.cc_alignment == CY_ImageCellAlignmentExtend) {
        [self.cc_imageView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cc_imageEdgeInsets.left).priorityHigh();
            make.right.equalTo(-self.cc_imageEdgeInsets.right).priorityHigh();
            make.top.equalTo(self.cc_imageEdgeInsets.top).priorityHigh();
            make.bottom.equalTo(-self.cc_imageEdgeInsets.bottom).priorityHigh();
        }];
    }
}

- (UIImage *)cc_image {
    return self.cc_imageView.image;
}

- (void)setCc_image:(UIImage *)cc_image {
    self.cc_imageView.image = cc_image;
    [self cc_layoutConstraints];
}

- (void)setCc_alignment:(CY_ImageCellAlignment)cc_alignment {
    _cc_alignment = cc_alignment;
    [self cc_layoutConstraints];
}

- (void)setCc_imageEdgeInsets:(UIEdgeInsets)cc_imageEdgeInsets {
    _cc_imageEdgeInsets = cc_imageEdgeInsets;
    [self cc_layoutConstraints];
}

@end
