//
//  RYCommentListController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYCommentListController.h"
#import "RYBaseConfig.h"

#define API_GET_COMMENTLIST @"https://api.weibo.com/2/comments/show.json"

@interface RYCommentListController ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, assign) NSInteger currentIndex;//当前的segmentedControl Index
@property (nonatomic ,strong) NSMutableArray *loadedFlagArray;

@end

@implementation RYCommentListController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_COMMENTLIST viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.params) {
        self.id = [[self.params objectForKey:@"id"] integerValue];
        self.type = [[self.params objectForKey:@"type"] integerValue];
    }
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

/**
 *  解决加了scrollView之后滑动返回上一级的手势失效的问题
 */
- (void)enableInteractivePop {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    for (UIGestureRecognizer *gesture in _containerView.gestureRecognizers) {
        [gesture requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
}

#pragma mark - function
- (void)segmentedValueChangedHandle:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    [self loadChildViewControllerByIndex:index];
    self.currentIndex = index;
    [_containerView setContentOffset:CGPointMake(index*RY_UI_SCREEN_WID, 0) animated:YES];
}

- (void)loadChildViewControllerByIndex:(NSInteger)index {
    if ([_loadedFlagArray[index] boolValue]) {
        //已经加载过就不在加载
        return;
    }
    Class VCClass;
    switch (index) {
        case 0:
            VCClass = NSClassFromString(@"RYCommentListChildController");
            break;
        case 1:
            VCClass = NSClassFromString(@"RYCommentListChildController");
            break;
        default:
            break;
    }
    if (VCClass == nil)
        return;
    NSDictionary *dic = (self.type == 2) ? @{@"type" : @(2),@"id" : @(self.id)} : @{@"type" : @(1),@"id" : @(self.id)} ;
    UIViewController *vc = [[VCClass alloc] init];
    vc.params = dic;
    [self addChildViewController:vc];
    [_loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
    [_containerView addSubview:vc.view];
    [self setChildViewFrame:vc.view byIndex:index];
}

- (void)setChildViewFrame:(UIView *)childView byIndex:(NSInteger)index {
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.left.equalTo(_containerView).offset(index*_containerView.frame.size.width);
        make.width.equalTo(_containerView);
        make.height.equalTo(_containerView);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = offset.x/RY_UI_SCREEN_WID;
    [self loadChildViewControllerByIndex:page];
    self.currentIndex = page;
    self.segmentedControl.selectedSegmentIndex = page;
}

#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.containerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.containerView.contentSize = CGSizeMake(RY_UI_SCREEN_WID*2, 0);
    
    self.loadedFlagArray = [[NSMutableArray alloc] initWithObjects:@(NO),@(NO),nil];
    [self loadChildViewControllerByIndex:_currentIndex];
}

#pragma mark - lazy
- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        NSArray *titleArr = (self.type == 2) ? @[@"转发",@"评论"] : @[@"评论",@"转发"];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:titleArr];
        [_segmentedControl setFrame:CGRectMake(0, 7, 170, 30)];
        _segmentedControl.tintColor = [UIColor blackColor];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
//        _segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedValueChangedHandle:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.delegate = self;
        _containerView.backgroundColor = self.view.backgroundColor;
        _containerView.pagingEnabled = YES;
        _containerView.scrollsToTop = NO;
    }
    return _containerView;
}

@end
