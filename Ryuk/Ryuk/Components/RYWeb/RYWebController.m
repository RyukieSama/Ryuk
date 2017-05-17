//
//  RYWebController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/17.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYWebController.h"
#import "RYBaseConfig.h"
#import "RYWebView.h"

@interface RYWebController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, copy) NSString *linkString;
@property (nonatomic, strong) UIColor *progressColor;
@property (strong, nonatomic) CALayer *progresslayer;
@property (nonatomic, strong) RYWebView *vWeb;

@end

@implementation RYWebController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_WEBVIEW viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:.8];
    if ([self.params objectForKey:@"url"]) {
        self.linkString = [self.params objectForKey:@"url"];
    }
    
    [self setupUI];
    [self setupWebView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
     [self.vWeb removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - function
- (void)setupWebView {
    [self.vWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - data
- (void)loadData {
    [self.vWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkString ?: @""]]];
}

//#pragma mark - webViewNavi
//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
//// 当内容开始返回时调用
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    
//}
//
//// 页面加载完成之后调用
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    
//}
//
//// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
//// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    
//}
//
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//}

#pragma mark - webVIewUI
//这个协议主要用于WKWebView处理web界面的三种提示框(警告框、确认框、输入框)，下面是警告框的例子:
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.vWeb];
    [self.vWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    NSLog(@"%@",self.progresslayer);
}

#pragma mark - lazy
- (RYWebView *)vWeb {
    if (!_vWeb) {
        _vWeb = [[RYWebView alloc] init];
        _vWeb.navigationDelegate = self;
        _vWeb.UIDelegate = self;
    }
    return _vWeb;
}

- (CALayer *)progresslayer {
    if (!_progresslayer) {
        UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
        progress.backgroundColor = [UIColor clearColor];
        [self.view addSubview:progress];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = self.progressColor.CGColor;
        [progress.layer addSublayer:layer];
        _progresslayer = layer;
    }
    return _progresslayer;
}

@end
