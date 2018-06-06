//
//  Appd.h
//  SVGManager
//
//  Created by 冯立海 on 2018/5/24.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITXPageViewController.h"
#import <UIViewController+MMDrawerController.h>

@interface Appd : UIResponder <UIApplicationDelegate>
@property(nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic, strong) ITXPageViewController *centerVC;
@property (strong, nonatomic) UIWindow *window;
@end
