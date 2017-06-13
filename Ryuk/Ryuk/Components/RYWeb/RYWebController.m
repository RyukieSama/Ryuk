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
@property (nonatomic, strong) UIToolbar *tbBar;
@property (nonatomic, strong) UIButton *btBack;
@property (nonatomic, strong) UIButton *btForward;
@property (nonatomic, strong) UIButton *btRefresh;
@property (nonatomic, strong) UIButton *btShare;

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

- (void)webViewBack {
    if (!self.vWeb.canGoBack) {
        return;
    }
    [self.vWeb goBack];
}

- (void)webViewForward {
    if (!self.vWeb.canGoForward) {
        return;
    }
    [self.vWeb goForward];
}

- (void)webViewRefresh {
    [self.vWeb reload];
}

- (void)webViewShare {
    NSLog(@"%s",__FUNCTION__);
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

#pragma mark - webViewNavi
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self setupToolBarState];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"跳转到其他的服务器");
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"是否允许这个导航");
    decisionHandler(WKNavigationActionPolicyAllow);
}

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
    NSLog(@"%s", __FUNCTION__);
    // 确定按钮
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Confirm选择框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    // 按钮
    UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户选择的信息
        completionHandler(NO);
    }];
    UIAlertAction *alertActionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertActionCancel];
    [alertController addAction:alertActionOK];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark TextInput输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(nonnull NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    // 确定按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户输入的信息
        UITextField *textField = alertController.textFields.firstObject;
        completionHandler(textField.text);
    }]];
    // 显示
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UI
- (void)setupUI {
    CGFloat tbHeight = 40;
    [self.view addSubview:self.vWeb];
    [self.vWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(tbHeight);
    }];
    [self.view addSubview:self.tbBar];
    [self.tbBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(tbHeight);
    }];
    NSLog(@"%@",self.progresslayer);
    
    [self setupToolBar];
}

- (void)setupToolBar {
    CGFloat width = [UIScreen mainScreen].bounds.size.width/4;
    [self.tbBar addSubview:self.btBack];
    [self.btBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(width);
    }];
    
    [self.tbBar addSubview:self.btForward];
    [self.btForward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btBack.mas_right);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(width);
    }];
    
    [self.tbBar addSubview:self.btRefresh];
    [self.btRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btForward.mas_right);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(width);
    }];
    
    [self.tbBar addSubview:self.btShare];
    [self.btShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btRefresh.mas_right);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(width);
    }];
    
}

- (void)setupToolBarState {
    self.btBack.enabled = self.vWeb.canGoBack;
    self.btForward.enabled = self.vWeb.canGoForward;
}

#pragma mark - lazy
- (RYWebView *)vWeb {
    if (!_vWeb) {
        _vWeb = [[RYWebView alloc] init];
        _vWeb.navigationDelegate = self;
        _vWeb.UIDelegate = self;
        _vWeb.allowsBackForwardNavigationGestures = YES;//支持手势进退
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

- (UIToolbar *)tbBar {
    if (!_tbBar) {
        _tbBar = [[UIToolbar alloc] init];
        
    }
    return _tbBar;
}

- (UIButton *)btBack {
    if (!_btBack) {
        _btBack = [[UIButton alloc] init];
        [_btBack setTitle:@"B" forState:UIControlStateNormal];
        [_btBack addTarget:self action:@selector(webViewBack) forControlEvents:UIControlEventTouchUpInside];
        [_btBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btBack setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    }
    return _btBack;
}

- (UIButton *)btForward {
    if (!_btForward) {
        _btForward = [[UIButton alloc] init];
        [_btForward setTitle:@"F" forState:UIControlStateNormal];
        [_btForward addTarget:self action:@selector(webViewForward) forControlEvents:UIControlEventTouchUpInside];
        [_btForward setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btForward setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    }
    return _btForward;
}

- (UIButton *)btRefresh {
    if (!_btRefresh) {
        _btRefresh = [[UIButton alloc] init];
        [_btRefresh setTitle:@"R" forState:UIControlStateNormal];
        [_btRefresh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btRefresh addTarget:self action:@selector(webViewRefresh) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btRefresh;
}

- (UIButton *)btShare {
    if (!_btShare) {
        _btShare = [[UIButton alloc] init];
        [_btShare setTitle:@"S" forState:UIControlStateNormal];
        [_btShare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btShare addTarget:self action:@selector(webViewShare) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btShare;
}

@end
