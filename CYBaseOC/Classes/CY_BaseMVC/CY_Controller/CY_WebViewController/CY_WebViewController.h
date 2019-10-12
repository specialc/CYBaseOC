//
//  CY_WebViewController.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CY_Lib.h"

@interface CY_WebViewController : CY_BaseViewController <UIWebViewDelegate>

+ (instancetype)cc_webVCWithURLString:(NSString *)URLString;

@property (nonatomic, weak) UIWebView *cc_webView;


/**
 *  if HTMLString is nil, webView will be send -[UIWebView loadRequest:]
 *  if HTMLString is not nil, webView will be send -[UIWebView loadHTMLString:baseURL:]
 */
@property (nonatomic, copy) NSString *cc_URLString;


/**
 *  if not nil webView will be send -[UIWebView loadHTMLString:baseURL:]
 *  if HTMLString is not nil and URLString is not nil, the baseURL is URLString
 */
@property (nonatomic, copy) NSString *cc_HTMLString;

@property (nonatomic, strong) NSData *cc_data;
@property (nonatomic, copy) NSString *cc_MIMEType;


/**
 * default is true
 */
@property (nonatomic, assign, getter=isAutoTitle) BOOL autoTitle;
@property (nonatomic, assign) BOOL scalesPageToFit;


typedef void (^PythiaJavaScriptCallback)(JSValue *js_this, NSArray *js_args);
typedef void (^PythiaJavaScriptCallbackReturn)(JSValue *js_this, NSArray *js_args);


/**
 * 监听js调用
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, PythiaJavaScriptCallback> *javaScriptObservers;

@end


