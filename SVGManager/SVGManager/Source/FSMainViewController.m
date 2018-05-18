//
//  FSMainViewController.m
//  FSAutoAdjust-cellHeightDemo
//
//  Created by huim on 2017/7/7.
//  Copyright © 2017年 shunFSKi. All rights reserved.
//

#import "FSMainViewController.h"
#import "FSTestTableViewCell.h"
#import "UITableViewCell+FSAutoCountHeight.h"
#import "FSEntity.h"
#import <MJRefresh.h>
#import "JokesModel.h"

#define FSWeakSelf __weak typeof(self) weakSelf = self;

@interface FSMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, assign) NSInteger page; ///< 页码
@property (nonatomic, assign) NSInteger pageSize; ///< 页码大小
@property(strong,nonatomic)NSMutableArray* models;
@end

@implementation FSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    [self loadNewJokes];
}

- (void)setupSubViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.bottom.right.mas_equalTo(self.view);
    }];

    @weakify(self)
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadNewJokes];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreJokes];
    }];
    
}

#pragma mark - Btn


#pragma mark - data
- (void)loadNewJokes {
    self.page = 1;
    self.pageSize = 20;
    NSString *path = [NSString stringWithFormat:@"/joke/img/text.php?key=2090f75b96a8333becd2811aaf427295&page=%ld&pagesize=%ld",(long)self.page, (long)self.pageSize];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"v.juhe.cn"];
    MKNetworkOperation *op = [engine operationWithPath:path];
    
    @weakify(self);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        NSDictionary *response = [completedOperation responseJSON];
        NSDictionary *result = [response objectForKey:@"result"];
        NSArray *models = [[JokesModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"data"] context:nil] mutableCopy];
        if (models.count >0) {
            self.models = [NSMutableArray arrayWithArray:models];
            [self.tableView reloadData];
        }
        NSLog(@"data = %@", self.models);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"请求错误:%@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
}

- (void)loadMoreJokes {
    self.page ++;
    NSString *path = [NSString stringWithFormat:@"/joke/img/text.php?key=2090f75b96a8333becd2811aaf427295&page=%ld&pagesize=%ld",(long)self.page, (long)self.pageSize];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"v.juhe.cn"];
    MKNetworkOperation *op = [engine operationWithPath:path];
    
    @weakify(self);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        NSDictionary *response = [completedOperation responseJSON];
        NSDictionary *result = [response objectForKey:@"result"];
        NSArray *models = [JokesModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"data"] context:nil];
        if (self.models.count >0) {
            [self.models addObjectsFromArray:models];
            [self.tableView reloadData];
        }
        NSLog(@"data = %@", self.models);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        self.page--;
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"请求错误:%@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
}


#pragma mark - UITableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    JokesModel *model = self.models[indexPath.row];
    CGFloat height = [self.title isEqualToString:@"keyCache"]?[FSTestTableViewCell FSCellHeightForTableView:tableView indexPath:indexPath cacheKey:model.identifier cellContentViewWidth:0 bottomOffset:0]:[FSTestTableViewCell FSCellHeightForTableView:tableView indexPath:indexPath cellContentViewWidth:0 bottomOffset:0];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        FSTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[FSTestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.model = self.models[indexPath.row];
        return cell;

}




@end
