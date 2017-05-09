//
//  RYCommentListChildController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/9.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYCommentListChildController.h"
#import "RYBaseConfig.h"
#import "RYStatuseCommentCell.h"
#import "RYFlowPageModel.h"

static NSString *cellID = @"RYStatuseCommentCell";

#define API_GET_COMMENTLIST @"https://api.weibo.com/2/comments/show.json"
#define API_GET_REPOSTLIST @"https://api.weibo.com/2/statuses/repost_timeline.json"

@interface RYCommentListChildController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) long long id;
@property (nonatomic, assign) long long since_id;
@property (nonatomic, assign) long long max_id;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UITableView *tvList;
@property (nonatomic, strong) NSMutableArray <RYComment *>*comments;
@property (nonatomic, strong) NSMutableArray <RYStatuse *>*reposts;

@end

@implementation RYCommentListChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.id = [[self.params objectForKey:@"id"] integerValue];
    self.type = [[self.params objectForKey:@"type"] integerValue];
    self.page = 1;
    [self setupUI];
    [self.tvList.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - data
- (void)loadData:(BOOL)header {
    NSDictionary *param;
    if (header) {
        param = @{
                  @"id" : @(self.id),
                  @"since_id" : @(self.since_id),//若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
                  @"count" : @20,//单页返回的记录条数，最大不超过100，默认为20。
                  @"page" : @(self.page)//返回结果的页码，默认为1。
                  };
    } else {
        param = @{
                  @"id" : @(self.id),
                  @"max_id" : @(self.max_id),//若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
                  @"count" : @20,//单页返回的记录条数，最大不超过100，默认为20。
                  @"page" : @(self.page)//返回结果的页码，默认为1。
                  };
    }
    __weak typeof(self) weakSelf = self;
    [RYNetworkManager ry_getWithUrl:API_GET_COMMENTLIST
                  requestDictionary:param
                      responseModel:[RYFlowPageModel class]
                           useCache:NO
                  completionHandler:^(id data) {
                      [weakSelf.tvList.mj_header endRefreshing];
                      [weakSelf.tvList.mj_footer endRefreshing];
                      
                      weakSelf.since_id = ((RYFlowPageModel *)data).since_id;
                      weakSelf.max_id = ((RYFlowPageModel *)data).max_id;
                      
                      if (weakSelf.since_id == 0 && weakSelf.comments.count > 0) {
                          return;
                      }
                      
                      NSMutableArray *arr = ((RYFlowPageModel *)data).comments.mutableCopy;
                      if (header) {
                          [arr addObjectsFromArray:weakSelf.comments];//把原来的加在后面
                          weakSelf.comments = arr;
                          weakSelf.tvList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                              [weakSelf loadData:NO];
                          }];
                      } else {
                          [weakSelf.comments addObjectsFromArray:arr];//吧新来的加在后面
                          weakSelf.comments = weakSelf.comments;
                      }
                      
                      if (weakSelf.max_id == 0) {
                          weakSelf.tvList.mj_footer = nil;
                      }
                  }];
}

- (void)loadRepostData:(BOOL)header {
    NSDictionary *param;
    if (header) {
        param = @{
                  @"id" : @(self.id),
                  @"since_id" : @(self.since_id),//若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
                  @"count" : @20,//单页返回的记录条数，最大不超过100，默认为20。
                  @"page" : @(self.page)//返回结果的页码，默认为1。
                  };
    } else {
        param = @{
                  @"id" : @(self.id),
                  @"max_id" : @(self.max_id),//若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
                  @"count" : @20,//单页返回的记录条数，最大不超过100，默认为20。
                  @"page" : @(self.page)//返回结果的页码，默认为1。
                  };
    }
    __weak typeof(self) weakSelf = self;
    [RYNetworkManager ry_getWithUrl:API_GET_REPOSTLIST
                  requestDictionary:param
                      responseModel:[RYFlowPageModel class]
                           useCache:NO
                  completionHandler:^(id data) {
                      [weakSelf.tvList.mj_header endRefreshing];
                      [weakSelf.tvList.mj_footer endRefreshing];
                      
                      weakSelf.since_id = ((RYFlowPageModel *)data).since_id;
                      weakSelf.max_id = ((RYFlowPageModel *)data).max_id;
                      
                      if (weakSelf.since_id == 0 && weakSelf.reposts.count > 0) {
                          return;
                      }
                      
                      NSMutableArray *arr = ((RYFlowPageModel *)data).reposts.mutableCopy;
                      if (header) {
                          [arr addObjectsFromArray:weakSelf.reposts];//把原来的加在后面
                          weakSelf.reposts = arr;
                          weakSelf.tvList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                              [weakSelf loadRepostData:NO];
                          }];
                      } else {
                          [weakSelf.reposts addObjectsFromArray:arr];//吧新来的加在后面
                          weakSelf.reposts = weakSelf.reposts;
                      }
                      
                      if (weakSelf.max_id == 0) {
                          weakSelf.tvList.mj_footer = nil;
                      }
                  }];
}

- (void)setComments:(NSMutableArray<RYComment *> *)comments {
    _comments = comments;
    [self.tvList reloadData];
}

- (void)setReposts:(NSMutableArray<RYStatuse *> *)reposts {
    _reposts = reposts;
    [self.tvList reloadData];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.type == 2) {
        return self.reposts.count;
    } else {
        return self.comments.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RYStatuseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (self.type == 2) {
        cell.repost = [self.reposts objectAtIndex:indexPath.section];
    } else {
        cell.comment = [self.comments objectAtIndex:indexPath.section];
    }
    return cell;
}

#pragma mark - UI 
- (void)setupUI {
    self.view.backgroundColor = (self.type == 2) ? [UIColor redColor] : [UIColor cyanColor];
    [self.view addSubview:self.tvList];
    [self.tvList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - lazy
- (UITableView *)tvList {
    if (!_tvList) {
        _tvList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tvList.delegate = self;
        _tvList.dataSource = self;
        _tvList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tvList.showsHorizontalScrollIndicator = NO;
        _tvList.showsVerticalScrollIndicator = NO;
        _tvList.estimatedRowHeight = 100;
        _tvList.rowHeight = UITableViewAutomaticDimension;
        _tvList.backgroundColor = RY_COLOR_GRAY_E8E8E8;
        [_tvList registerClass:[RYStatuseCommentCell class] forCellReuseIdentifier:cellID];
        __weak typeof(self) weakSelf = self;
        _tvList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (weakSelf.type == 2) {
                [weakSelf loadRepostData:YES];
            } else {
                [weakSelf loadData:YES];
            }
        }];
    }
    return _tvList;
}

@end
