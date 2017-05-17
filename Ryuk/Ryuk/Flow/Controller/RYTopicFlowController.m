//
//  RYTopicFlowController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/17.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYTopicFlowController.h"
#import "RYBaseConfig.h"
#import "RYFlowStatuseCell.h"

@interface RYTopicFlowController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) long long since_id;
@property (nonatomic, assign) long long max_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger feature;
@property (nonatomic, copy) NSString *topicName;
@property (nonatomic, strong) UITableView *tvFlow;
@property (nonatomic, strong) NSMutableArray <RYStatuse *>*statuses;

@end

@implementation RYTopicFlowController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_TOPIC_FLOW viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.params objectForKey:@"topicName"]) {
        self.topicName = [self.params objectForKey:@"topicName"];
    }
    [self setDefault];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data  
- (void)setStatuses:(NSMutableArray<RYStatuse *> *)statuses {
    _statuses = statuses;
    [self.tvFlow reloadData];
}

- (void)setDefault {
    self.page = 1;
    self.feature = 0;
}

- (void)loadData:(BOOL)header {
    [self.tvFlow.mj_header endRefreshing];
    [self.tvFlow.mj_footer endRefreshing];
}

#pragma mark - UI
- (void)setupUI {
    self.title = self.topicName ?: @"话题";

    [self.view addSubview:self.tvFlow];
    [self.tvFlow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - tableVIew
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.statuses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RYStatuse *statuse = [self.statuses objectAtIndex:indexPath.section];
    RYFlowStatuseCell *cell = [tableView dequeueReusableCellWithIdentifier:statuse.cellID forIndexPath:indexPath];
    cell.statuse = statuse;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - lazy
- (UITableView *)tvFlow {
    if (!_tvFlow) {
        _tvFlow = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tvFlow.delegate = self;
        _tvFlow.dataSource = self;
        _tvFlow.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tvFlow.showsHorizontalScrollIndicator = NO;
        _tvFlow.showsVerticalScrollIndicator = NO;
        _tvFlow.estimatedRowHeight = 100;
        _tvFlow.rowHeight = UITableViewAutomaticDimension;
        _tvFlow.backgroundColor = RY_COLOR_GRAY_E8E8E8;
        //        [_tvFlow registerNib:[UINib nibWithNibName:@"RYFlowStatuseCell" bundle:nil] forCellReuseIdentifier:cellID];
        [_tvFlow registerClass:[RYFlowStatuseCell class] forCellReuseIdentifier:RYStatuseCellIDText];
        [_tvFlow registerClass:[RYFlowStatuseCell class] forCellReuseIdentifier:RYStatuseCellIDTextNoRe];
        [_tvFlow registerClass:[RYFlowStatuseCell class] forCellReuseIdentifier:RYStatuseCellIDNine];
        [_tvFlow registerClass:[RYFlowStatuseCell class] forCellReuseIdentifier:RYStatuseCellIDVideo];
        [_tvFlow registerClass:[RYFlowStatuseCell class] forCellReuseIdentifier:RYStatuseCellIDOne];
        __weak typeof(self) weakSelf = self;
        _tvFlow.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData:YES];
        }];
    }
    return _tvFlow;
}

@end
