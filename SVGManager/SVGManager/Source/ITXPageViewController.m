//
//  ITXPageViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ITXPageViewController.h"
#import "FSMainViewController.h"
#import "TwoViewController.h"
@interface ITXPageViewController ()
@property (nonatomic, strong) NSArray *titleData;
@end

@implementation ITXPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.showOnNavigationBar=YES;
    self.menuView.style = WMMenuViewStyleDefault;
    self.menuView.layoutMode = WMMenuViewLayoutModeCenter;
    self.menuView.backgroundColor = [UIColor clearColor];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"最新", @"趣图", @"随机"];
    }
    return _titleData;
}

#pragma mark - 分页控制器代理
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleData[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            return [[OneViewController alloc] init];;
        }
            
            break;
        case 1: {
//            return [[FSMainViewController alloc] init];
            return [[TwoViewController alloc] init];
        }
            
            break;
        case 2: {
            return [[ThreeViewController alloc] init];
        }
            break;
            
        default: {
            UIViewController *vc = [[UIViewController alloc] init];
            return vc;
        }
            break;
    }
}



@end
