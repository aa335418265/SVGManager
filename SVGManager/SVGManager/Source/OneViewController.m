//
//  OneViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "OneViewController.h"
#import "TextJokesCell.h"
#import "UIImageView+LBBlurredImage.h"

@interface OneViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView* tableView;
@property(strong,nonatomic)NSMutableArray* models;
@property (nonatomic, assign) NSInteger page; ///< 页码
@property (nonatomic, assign) NSInteger pageSize; ///< 页码大小
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundView=bgView;
    [bgView setImageToBlur:[UIImage imageNamed:@"example"] blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:^(NSError *error) {
        NSLog(@"玻璃效果图片已经好了");
    }];
    
    //下拉刷新
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewJokes)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJokes)];
    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    [self.view addSubview:_tableView];
//    [self loadNewJokes];
    
    
    

}

- (void)loadNewJokes {
    self.page = 1;
    self.pageSize = 20;
    NSString *path = [NSString stringWithFormat:@"/joke/content/text.php?key=2090f75b96a8333becd2811aaf427295&page=%ld&pagesize=%ld",(long)self.page, (long)self.pageSize];
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
//        NSLog(@"data = %@", self.models);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"请求错误:%@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
}

- (void)loadMoreJokes {
    self.page ++;
    NSString *path = [NSString stringWithFormat:@"/joke/content/text.php?key=2090f75b96a8333becd2811aaf427295&page=%ld&pagesize=%ld",(long)self.page, (long)self.pageSize];
    
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



#pragma mark - 设置UI

#pragma mark - 私有方法

#pragma mark - 公有方法

#pragma mark - tableView 相关
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokesModel* model = _models[indexPath.row];
    if(model.cellHeight < 10)
    {
        [TextJokesCell cellHeightWithModel:model];
    }
    return model.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextJokesCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TextJokesCell"];
    if(cell == nil)
    {
        cell = [[TextJokesCell alloc]init];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    JokesModel* model = _models[indexPath.row];
    cell.model = model;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - delegate 相关

#pragma mark - 事件响应

#pragma mark - getters setters

#pragma mark - 接口相关

@end
