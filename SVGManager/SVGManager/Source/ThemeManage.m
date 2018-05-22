//
//  ThemeManage.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ThemeManage.h"


NSString  * ThemeManageChangeNotification = @"themeManageChangeNotification";

static ThemeManage *themeManage; // 单例

@implementation ThemeManage

#pragma mark - 单例的初始化

+ (ThemeManage *)shareThemeManage {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManage = [[ThemeManage alloc] init];
    });
    return themeManage;
}


#pragma mark 重写isNight的set方法

- (void)setIsNight:(BOOL)isNight {
    
    _isNight = isNight;
    
    if (self.isNight) { // 夜间模式改变相关颜色
        self.tableViewbgImage = [UIImage imageNamed:@"example"];
        self.contentColor = [UIColor lightGrayColor];
        self.likedImage =[UIImage imageNamed:@"liked2"];
        self.collectedImage =[UIImage imageNamed:@"collected2"];

    } else{
        
        self.tableViewbgImage = [UIImage imageWithColor:[UIColor whiteColor]];
        self.contentColor = [UIColor darkGrayColor];
        self.likedImage =[UIImage imageNamed:@"liked"];
        self.collectedImage =[UIImage imageNamed:@"collected"];
        

    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeManageChangeNotification object:nil];


}



@end
