//
//  TwoViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "TwoViewController.h"
#import "ImageJokesCell.h"
#import "UIImageView+LBBlurredImage.h"
#import "FLAnimatedImageView+WebCache.h"
#import "JokesModel.h"


@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView* tableView;
@property(strong,nonatomic)NSMutableArray* models;
@property (nonatomic, assign) NSInteger page; ///< 页码
@property (nonatomic, assign) NSInteger pageSize; ///< 页码大小
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.dataSource = self;
    _tableView.delegate = self;

//    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    self.tableView.backgroundView=bgView;
//        [bgView setImageToBlur:[UIImage imageNamed:@"example"] blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:^(NSError *error) {
//            NSLog(@"玻璃效果图片已经好了");
//        }];
    
    //下拉刷新
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewJokes)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJokes)];
    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.view addSubview:_tableView];
    [self loadNewJokes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

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
//        NSLog(@"data = %@", self.models);
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
    JokesModel *model = self.models[indexPath.row];
    CGFloat contentLabelHeight = [model.content heightForFont:[UIFont systemFontOfSize:14] width:self.view.width - 40];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:model.url];
    CGFloat imageHeight =120;
    if (image) {
        if (image.size.width > self.view.width - 10 * 4) {
            imageHeight =  image.size.height * (self.view.width - 10 * 4) / image.size.width;
        }else{
            imageHeight = image.size.height;
        }
    }
    CGFloat updateLabelHeight = [model.updatetime heightForFont:[UIFont systemFontOfSize:11] width:self.view.width - 40];
    CGFloat totalHeight = 16 + 8+ 12 + contentLabelHeight + 24 + imageHeight + 24 + updateLabelHeight +24 + 16;

    return totalHeight  ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageJokesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ImageJokesCell class])];
    if (cell == nil) {
        cell = [[ImageJokesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ImageJokesCell class])];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}





- (void)configureCell:(ImageJokesCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    JokesModel *model = self.models[indexPath.row];
    NSString *imgURL = model.url;
    cell.contentLabel.text = model.content;
    cell.updateTimeLabel.text = model.updatetime;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.indexPath = indexPath;
    cell.liked = [[JokesManager sharedInstance] isLikedHashId:model.hashId];
    cell.collected = [[JokesManager sharedInstance] isColletedHashId:model.hashId];
    cell.likedClickBlock = ^(NSIndexPath *indexPath, BOOL liked) {
        JokesModel *model = self.models[indexPath.row];
        [[JokesManager sharedInstance] likeModel:model liked:liked];
    };
    cell.collectedClickBlock = ^(NSIndexPath *indexPath, BOOL collected) {
        JokesModel *model = self.models[indexPath.row];
        [[JokesManager sharedInstance] colletedModel:model collected:collected];
        if (collected) {
            [BMShowHUD showMessage:@"收藏成功"];
        }else{
            [BMShowHUD showMessage:@"您取消了收藏"];
        }
    };
    @weakify(self);
    
    if (imgURL) {
        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(self);
            if (cacheType == SDImageCacheTypeNone) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }

}


#pragma mark - delegate 相关

#pragma mark - 事件响应

#pragma mark - getters setters

#pragma mark - 接口相关

@end
