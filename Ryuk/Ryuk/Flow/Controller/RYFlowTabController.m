//
//  RYFlowTabController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowTabController.h"
#import "RYBaseConfig.h"
#import "RYFlowPageModel.h"
#import "RYFlowStatuseCell.h"

#define API_MY_TIMELINE @"https://api.weibo.com/2/statuses/home_timeline.json"
#define API_FRIEND_TIMELINE @"https://api.weibo.com/2/friendships/groups/timeline.json"

@interface RYFlowTabController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) long long since_id;
@property (nonatomic, assign) long long max_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger feature;
@property (nonatomic, strong) NSMutableArray <RYStatuse *>*statuses;
@property (nonatomic, strong) UITableView *tvFlow;
@property (nonatomic, strong) UIButton *btPost;

@end

@implementation RYFlowTabController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setDefault];
    [self.tvFlow.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
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
    
    NSDictionary *param;
    if (header) {
        param = @{
          @"since_id" : @(self.since_id),//若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
          @"count" : @20,//单页返回的记录条数，最大不超过100，默认为20。
          @"page" : @(self.page),//返回结果的页码，默认为1。
          @"base_app" : @0,//是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
          @"feature" : @(self.feature),//过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
          @"trim_user" : @0 //返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
          };
    } else {
        param = @{
                  @"max_id" : @(self.max_id),//若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
                  @"count" : @20,//单页返回的记录条数，最大不超过100，默认为20。
                  @"page" : @(self.page),//返回结果的页码，默认为1。
                  @"base_app" : @0,//是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
                  @"feature" : @(self.feature),//过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
                  @"trim_user" : @0 //返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
                  };
    }
    
    __weak typeof(self) weakSelf = self;
    [RYNetworkManager ry_getWithUrl:API_MY_TIMELINE
                  requestDictionary:param
                      responseModel:[RYFlowPageModel class]
                           useCache:NO
                  completionHandler:^(id data) {
                      [weakSelf.tvFlow.mj_header endRefreshing];
                      [weakSelf.tvFlow.mj_footer endRefreshing];
                      
                      weakSelf.since_id = ((RYFlowPageModel *)data).since_id;
                      weakSelf.max_id = ((RYFlowPageModel *)data).max_id;
                      NSMutableArray *arr = ((RYFlowPageModel *)data).statuses.mutableCopy;
                      if (header) {
                          [arr addObjectsFromArray:weakSelf.statuses];//把原来的加在后面
                          weakSelf.statuses = arr;
                          weakSelf.tvFlow.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                              [weakSelf loadData:NO];
                          }];
                      } else {
                          [weakSelf.statuses addObjectsFromArray:arr];//吧新来的加在后面
                          weakSelf.statuses = weakSelf.statuses;
                      }
                  }];
}

#pragma mark - action
- (void)postStatus {
    [RYPoster postStatuse];
}

#pragma mark - UI
- (void)setupUI {
    self.title = @"Ryuk";
//    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.tvFlow];
    [self.tvFlow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btPost];
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

- (UIButton *)btPost {
    if (!_btPost) {
        _btPost = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_btPost setImage:[UIImage imageNamed:@"ios7-compose-outline"] forState:UIControlStateNormal];
        [_btPost addTarget:self action:@selector(postStatus) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btPost;
}

@end
