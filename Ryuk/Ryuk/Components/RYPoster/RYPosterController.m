//
//  RYPosterController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYPosterController.h"
#import "RYBaseConfig.h"
#import "RYPostToolBar.h"

#define KEYBOARD_OFFSET 515/2
#define TOOLBAR_HEIGHT 50

@interface RYPosterController ()<UITextViewDelegate,RYPostToolBarDelegate>

@property (nonatomic, strong) UIButton *btClose;
@property (nonatomic, strong) UIButton *btPost;
@property (nonatomic, strong) RYPostToolBar *tbToolBar;
@property (nonatomic, assign) BOOL isKetboardShowed;

@end

@implementation RYPosterController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_POSTSTATUSE viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
//    [self.tvText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tvText endEditing:YES];
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - action
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)post {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.isKetboardShowed = YES;
    self.tbToolBar.isKetboardShowed = YES;
    [self keyboardUp];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    self.isKetboardShowed = NO;
    self.tbToolBar.isKetboardShowed = NO;
    [self keyboardDown];
    return YES;
}

#pragma mark - posterDelegate
- (void)postToolBarKeyboardClick {
    if (self.isKetboardShowed) {
        [self.tvText endEditing:YES];
    } else {
        [self.tvText becomeFirstResponder];
    }
}

- (void)postToolBarAlbumClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)postToolBarAtClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)postToolBarEmojiClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)postToolBarTopicClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)postToolBarLocationClick {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - UI
- (void)keyboardUp {
    //工具条
    [self.tbToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-KEYBOARD_OFFSET);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    
    }];
}

- (void)keyboardDown {
    //工具条
    [self.tbToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setupUI {
    self.title = @"发布";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btPost];
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btClose];
    //工具条
    [self.view addSubview:self.tbToolBar];
    [self.tbToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(TOOLBAR_HEIGHT);
        make.bottom.mas_equalTo(0);
    }];
    //输入部分
    [self.view addSubview:self.tvText];
    [self.tvText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(60);
        make.bottom.mas_equalTo(self.tbToolBar.mas_top);
    }];
}

#pragma mark - lazy
- (UIButton *)btClose {
    if (!_btClose) {
        _btClose = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_btClose setImage:[UIImage imageNamed:@"ios7-close-empty"] forState:UIControlStateNormal];
        [_btClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btClose;
}

- (UIButton *)btPost {
    if (!_btPost) {
        _btPost = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_btPost setImage:[UIImage imageNamed:@"ios7-paperplane-outline"] forState:UIControlStateNormal];
        [_btPost addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btPost;
}

- (UITextView *)tvText {
    if (!_tvText) {
        _tvText = [[UITextView alloc] init];
        _tvText.font = RY_FONT(16);
        _tvText.textColor = [UIColor blackColor];
        _tvText.scrollEnabled = YES;
        _tvText.delegate = self;
    }
    return _tvText;
}

- (RYPostToolBar *)tbToolBar {
    if (!_tbToolBar) {
        _tbToolBar = [[RYPostToolBar alloc] init];
        _tbToolBar.delegate = self;
    }
    return _tbToolBar;
}

@end
