//
//  AppDelegate.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "AppDelegate.h"

#import "ThemeManage.h"
#import "UIView+ThemeChange.h"
#import "LeftViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.centerVC = [[ITXPageViewController alloc] init];
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
    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    return YES;
    



    
    return YES;
}




@end
