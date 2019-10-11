//
//  CY_WebCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/25.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"

@class CY_WebCell;

@protocol CY_WebCellDelegate <NSObject>

@optional
- (void)cc_WebCell:(CY_WebCell *)webCell didFinishLoad:(UIWebView *)webView;
- (void)cc_WebCell:(CY_WebCell *)webCell didReceivedJSCallBack:(NSString *)URLString;

@end

@interface CY_WebCell : CY_TableViewCell <UIWebViewDelegate>
@property (nonatomic, weak) id<CY_WebCellDelegate> delegate;
@property (nonatomic, strong) NSString *URLString;
@property (nonatomic, copy) void(^didFinishLoad)();
@end
