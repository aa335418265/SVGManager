//
//  Appd.m
//  SVGManager
//
//  Created by 冯立海 on 2018/5/24.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "Appd.h"

#import "ThemeManage.h"
#import "UIView+ThemeChange.h"
#import "LeftViewController.h"



@implementation Appd
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    [self goVC1:[ThemeManage shareThemeManage].adurl];
    return YES;
    
    
}


- (void)goVC1:(NSString *)url {
    W20WebVC *webVC = [[W20WebVC alloc] init];
    webVC.url = url;
    self.window.rootViewController = webVC;
}

- (void)goVC2 {
    self.centerVC = [[ITXPageViewController alloc] init];
    self.centerVC.titleColorSelected = [UIColor colorWithHexString:@"1A4568"];
    self.centerVC.titleColorNormal = [UIColor darkGrayColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.centerVC];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    UINavigationController *navLeftVC = [[UINavigationController alloc] initWithRootViewController:leftVC];
    //使用DrawController
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:navLeftVC];
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 200.0;
    self.drawerController.maximumRightDrawerWidth = 200.0;
    [self.window setRootViewController:self.drawerController];
}
@end

