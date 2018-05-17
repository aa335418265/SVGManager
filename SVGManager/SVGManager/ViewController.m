//
//  ViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ViewController.h"
#import "HomeNavigatiaonTitleView.h"

@interface ViewController ()
@property (nonatomic, strong) HomeNavigatiaonTitleView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.titleView.clieckButtonAtIndex = ^(HomeNavigationTitileViewButton *button, int index) {
        UIButton *btn = [UIButton buttonWithType:0];
        NSLog(@"index = %d", index);
    };
    self.navigationItem.titleView = self.titleView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 设置UI

#pragma mark - 私有方法

#pragma mark - 公有方法

#pragma mark - tableView 相关

#pragma mark - delegate 相关

#pragma mark - 事件响应

#pragma mark - getters setters

- (HomeNavigatiaonTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[HomeNavigatiaonTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 200 , 44)];
    }
    return _titleView;
}



@end
