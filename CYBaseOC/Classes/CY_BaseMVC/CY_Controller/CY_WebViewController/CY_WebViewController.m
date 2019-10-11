//
//  CY_WebViewController.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_WebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface CY_WebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgressView *webViewProgressView;
@property (nonatomic, strong) NJKWebViewProgress *webViewProgressProxy;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, assign, getter=isLoadCompleted) BOOL loadCompleted;

@end

@implementation CY_WebViewController

+ (instancetype)cc_webVCWithURLString:(NSString *)URLString {
    CY_WebViewController *webVC = [[CY_WebViewController alloc] init];
    webVC.cc_URLString = URLString;
    return webVC;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _autoTitle = YES;
        _scalesPageToFit = NO;
        _javaScriptObservers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self.cc_webView stopLoading];
    self.cc_webView.delegate = nil;
    self.cc_webView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // HTMLString
    if (self.cc_HTMLString) {
        NSURL *url = [NSURL URLWithString:self.cc_URLString];
        [self.cc_webView loadHTMLString:self.cc_HTMLString baseURL:url];
    }
    // Data
    else if (self.cc_data) {
        NSURL *url = [NSURL URLWithString:self.cc_URLString];
        [self.cc_webView loadData:self.cc_data MIMEType:self.cc_MIMEType textEncodingName:@"UTF-8" baseURL:url];
    }
    // URL
    else if (self.cc_URLString && !self.cc_HTMLString && !self.cc_data) {
        NSURL *url = [NSURL URLWithString:self.cc_URLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.cc_webView loadRequest:request];
    }
}

#pragma mark - 页面构造

- (void)cc_loadNavigationBar {
    [super cc_loadNavigationBar];
    
    [self cc_setNavBarLeftSecondButtonTitle:@"关闭"];
    self.cc_navBar.cc_leftSecondButton.hidden = YES;
}

- (void)cc_loadViews {
    [super cc_loadViews];
    
    // 进度条
    self.webViewProgressProxy = [[NJKWebViewProgress alloc] init];
    self.webViewProgressProxy.webViewProxyDelegate = self;
    self.webViewProgressProxy.progressDelegate = self;
    
    UIWebView *webView = [[UIWebView alloc] init];
    self.cc_webView = webView;
    [self.view addSubview:self.cc_webView];
    self.cc_webView.delegate = self.webViewProgressProxy;
    
    // 解决iOS9上webView有黑边的问题，原因不明
    // http://stackoverflow.com/questions/21420137/black-line-appearing-at-bottom-of-uiwebview-how-to-remove
    self.cc_webView.opaque = NO;
    self.cc_webView.backgroundColor = [UIColor clearColor];
    self.cc_webView.scalesPageToFit = self.scalesPageToFit;
    
    self.webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.webViewProgressView];
    self.webViewProgressView.progressBarView.backgroundColor = rgba(255, 32, 32, 1);
}

- (void)cc_layoutConstraints {
    [self.cc_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.cc_navBar.mas_bottom);
    }];
    [self.webViewProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.cc_webView);
        make.height.equalTo(2);
    }];
}

#pragma mark - NavBar按钮点击

- (void)cc_navBarLeftButtonClicked:(id)sender {
    if (self.cc_webView.canGoBack) {
        [self.cc_webView goBack];
        self.cc_navBar.cc_leftSecondButton.hidden = NO;
    }
    else {
        [super cc_navBarLeftButtonClicked:sender];
    }
}

- (void)cc_navBarLeftSecondButtonClicked:(id)sender {
    [self cc_navBarLeftButtonClicked:sender];
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.webViewProgressView setProgress:progress animated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    LogInfo(@"UIWebView准备加载: %s %@", __FUNCTION__, request);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    LogInfo(@"UIWebView开始加载: %s %@", __FUNCTION__, webView.request);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    LogInfo(@"UIWebView加载完毕: %s %@", __FUNCTION__, webView.request);
    if (self.isAutoTitle) {
        NSString *title = [self.cc_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }
    [self.webViewProgressView setProgress:1 animated:YES];
    if (!self.isLoadCompleted) {
        self.loadCompleted = YES;
        [self delayMount:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    LogError(@"UIWebView加载失败: %s %@", __FUNCTION__, error);
}

#pragma mark - Methods

- (void)delayMount:(UIWebView *)webView {
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
        self.loadCompleted = YES;
        [self mountJavaScriptAtWebView:webView];
    }
    else {
        self.loadCompleted = NO;
        weakify_self
        __weak UIWebView *weakWebView = webView;
        dispatch_delay(1.5, ^{
            strongify_self
            [self delayMount:weakWebView];
        });
    }
}

- (void)mountJavaScriptAtWebView:(UIWebView *)webView {
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        LogError(@"JS Error: %@", exception);
    };
    
    for (NSString *key in self.javaScriptObservers.allKeys) {
        PythiaJavaScriptCallback block = self.javaScriptObservers[key];
        JSValue *jv = self.context[key];
        if (![[jv toString] isEqualToString:@"undefined"]) {
            continue;
        }
        
        self.context[key] = ^{
            LogError(@"%@", [NSThread currentThread]);
            JSValue *this = [JSContext currentThis];
            NSArray *args = [JSContext currentArguments];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block(this, args);
                }
            });
        };
    }
}

@end
