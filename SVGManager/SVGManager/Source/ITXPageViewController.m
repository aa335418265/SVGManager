//
//  ITXPageViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ITXPageViewController.h"
#import "TwoViewController.h"
#import "UIViewController+MMDrawerController.h"
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
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu2"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

}

- (void)rightBtn
{
    NSLog(@"搜索");
}
-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"趣图", @"笑话", @"随机"];
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
            
            return [[TwoViewController alloc] init];
        }
            
            break;
        case 1: {
            return [[OneViewController alloc] init];;
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
