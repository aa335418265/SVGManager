//
//  W20WebVC.m
//  W20WebVC
//
//  Created by ___liangdahong on 2018/5/9.
//  Copyright © 2018年 ( https://liangdahong.com/ ). All rights reserved.
//

#import "W20WebVC.h"
#import <Masonry.h>

UIImage * bm_image(UIImage *self) {
    UIColor *color = [UIColor colorWithRed:68/255.0 green:121/255.0 blue:250/255.0 alpha:1];
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@interface W20WebVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView; ///< webView
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIView *bottomNavView;

@end

@implementation W20WebVC


#pragma mark -

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomNavView.mas_top);
    }];
    [_homeButton setImage:bm_image([UIImage imageNamed:@"home"]) forState:UIControlStateNormal];
    [_reloadButton setImage:bm_image([UIImage imageNamed:@"refresh"]) forState:UIControlStateNormal];
    [_clearButton setImage:bm_image([UIImage imageNamed:@"clear"]) forState:UIControlStateNormal];
    
    [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backButton setImage:bm_image([UIImage imageNamed:@"back"]) forState:UIControlStateSelected];
    
    [_nextButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_nextButton setImage:bm_image([UIImage imageNamed:@"next"]) forState:UIControlStateSelected];
    _backButton.selected = NO;
    _nextButton.selected = NO;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - Public Method

#pragma mark - Action

- (IBAction)homeButtonClick {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)backButtonClick {
    [self.webView goBack];
}

- (IBAction)nextButtonClick {
    [self.webView goForward];
}

- (IBAction)reloadButtonClick {
    [self.webView reload];
}

- (IBAction)clearButtonClick {
    [self.webView removeFromSuperview];
    self.webView = nil;
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _backButton.selected = NO;
        _nextButton.selected = NO;
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"已清除" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
        [self.view addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(self.bottomNavView.mas_top);
        }];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    });
}

#pragma mark - Custom Delegate

#pragma mark - System Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *reqUrl = request.URL.absoluteString;
    if ([reqUrl hasPrefix:@"alipays://"]
        || [reqUrl hasPrefix:@"alipay://"]
        || [reqUrl hasPrefix:@"mqqapi://"]
        || [reqUrl hasPrefix:@"mqqapis://"]
        || [reqUrl hasPrefix:@"weixin://"]
        || [reqUrl hasPrefix:@"weixins://"]) {
        if (![[UIApplication sharedApplication] openURL:request.URL]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"未检测到客户端，请安装后重试。" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _backButton.selected = NO;
                _nextButton.selected = NO;
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self reloadMyUI];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self reloadMyUI];
}

#pragma mark - Getters Setters
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - Private Method

- (void)reloadMyUI {
    _backButton.selected = self.webView.canGoBack;
    _nextButton.selected = self.webView.canGoForward;
}

@end
