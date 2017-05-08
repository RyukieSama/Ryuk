//
//  RYReAndCommentController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYReAndCommentController.h"
#import "RYBaseConfig.h"
#import "RYPostToolBar.h"

#define API_GIVE_COMMENT @"https://api.weibo.com/2/comments/create.json"
#define API_REPOST @"https://api.weibo.com/2/statuses/repost.json"

@interface RYReAndCommentController ()

@property (nonatomic, assign) NSInteger type;

@end

@implementation RYReAndCommentController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_REANDCOMMENT viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = [[self.params objectForKey:@"type"] integerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - function
- (void)post {
    if (self.type == 1) {
        [self giveComment];
    } else {
        [self repost];
    }
}

- (void)giveComment {
    if (self.tvText.text.length < 1) {
        NSLog(@"字数为0");
        return;
    }
    
    if (self.tvText.text.length > 140) {
        NSLog(@"字数超出限制");
        return;
    }
    
    
    //[(self.tvText.text ?: @"") stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
    NSDictionary *param = @{
                            @"comment" : (self.tvText.text ?: @""), //评论内容，必须做URLencode，内容不超过140个汉字。
                            @"id" : [self.params objectForKey:@"id"],//需要评论的微博ID。
                            @"comment_ori" : @"0" //当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
                            };
    
    [RYNetworkManager ry_postWithUrl:API_GIVE_COMMENT
                   requestDictionary:param
                       responseModel:nil
                            useCache:NO
                   completionHandler:^(id data) {
                       
                   }];
    [self dismiss];
}

- (void)repost {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - UI
- (void)setupUI {
    [super setupUI];
    if (self.type == 1) {
        self.title = @"评论";
    } else {
        self.title = @"转发";
    }
}

#pragma mark - lazy


@end
