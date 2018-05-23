//
//  LeftViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftMuneCell.h"
#import "CelanCacheViewController.h"
#import "AboutUsViewController.h"
#import "MyCollectedViewController.h"
#import "AppDelegate.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UIImageView *headerView;
@end

@implementation LeftViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 240)];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 200, 200)];
    iconImageView.image = [UIImage imageNamed:@"le2"];
    [view addSubview:iconImageView];

    
    _tableView.tableHeaderView = view;
    self.headerView = iconImageView;
    [self themeChange];
    _tableView.tableFooterView = [UIView new];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.data = @[
                  @"我的收藏",
                  @"缓存清理",
                  @"关于我们"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:ThemeManageChangeNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)themeChange  {
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundView=bgView;
    [bgView setImageToBlur:[ThemeManage shareThemeManage].tableViewbgImage blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    if ([ThemeManage shareThemeManage].isNight) {
        self.headerView.alpha = 0.75;
    }
    else{
        self.headerView.alpha = 1;
    }
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftMuneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[LeftMuneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.switchBtn.hidden = YES;
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row == 0){
        cell.iconImageView.image = [UIImage imageNamed:@"mycollected"];

    }else if (indexPath.row == 1){
        cell.iconImageView.image = [UIImage imageNamed:@"cache"];

    }else if (indexPath.row == 2){
        cell.iconImageView.image = [UIImage imageNamed:@"about"];
        
    }
    cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.data[indexPath.row]];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        if (indexPath.row == 0) {
            MyCollectedViewController *vc = [[MyCollectedViewController alloc] init];
            [delegate.centerVC.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            CelanCacheViewController *vc = [[CelanCacheViewController alloc] init];
            [delegate.centerVC.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2) {
            AboutUsViewController *vc = [[AboutUsViewController alloc] init];
            [delegate.centerVC.navigationController pushViewController:vc animated:YES];
        }
    }];

}

@end
