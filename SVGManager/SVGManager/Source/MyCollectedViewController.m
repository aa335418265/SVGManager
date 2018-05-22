//
//  MyCollectedViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "MyCollectedViewController.h"

#import "ImageJokesCell.h"
#import "UIImageView+LBBlurredImage.h"
#import "FLAnimatedImageView+WebCache.h"
#import "JokesModel.h"


@interface MyCollectedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView* tableView;
@property(strong,nonatomic)NSMutableArray* models;

@end

@implementation MyCollectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"我的收藏";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundView=bgView;
    [bgView setImageToBlur:[ThemeManage shareThemeManage].tableViewbgImage blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    

    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:ThemeManageChangeNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)themeChange  {
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundView=bgView;
    [bgView setImageToBlur:[ThemeManage shareThemeManage].tableViewbgImage blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.models = [[JokesManager sharedInstance].collectedModels mutableCopy];
    
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
    CGFloat imageHeight =0;
    CGFloat imageTop = 0;
    if (image) {
        imageTop = 24;
        if (image.size.width > self.view.width - 10 * 4) {
            imageHeight =  image.size.height * (self.view.width - 10 * 4) / image.size.width;
        }else{
            imageHeight = image.size.height;
        }
    }
    CGFloat updateLabelHeight = [model.updatetime heightForFont:[UIFont systemFontOfSize:11] width:self.view.width - 40];
    CGFloat totalHeight = 16 + 8+ 12 + contentLabelHeight + imageTop + imageHeight + 24 + updateLabelHeight +24 + 16;
    
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
