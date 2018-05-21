//
//  AppDelegate.h
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITXPageViewController.h"
#import <UIViewController+MMDrawerController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic, strong) ITXPageViewController *centerVC;

@end

