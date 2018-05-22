//
//  ThemeManage.h
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManage : NSObject

#pragma mark - 颜色属性

//
@property(nonatomic, retain) UIImage *tableViewbgImage;
@property(nonatomic, retain) UIImage *likedImage;
@property(nonatomic, retain) UIImage *collectedImage;

@property(nonatomic, retain) UIColor *contentColor;
@property(nonatomic, retain) UIColor *update;


@property(nonatomic, retain) UIColor *bgColor;
@property(nonatomic, retain) UIColor *color1;
@property(nonatomic, retain) UIColor *color2;
@property(nonatomic, retain) UIColor *textColorGray;
@property(nonatomic, retain) UIColor *navBarColor;
@property(nonatomic, retain) UIColor *colorClear;



// 是否是夜间 YES表示夜间, NO为正常
@property(nonatomic, assign) BOOL isNight;

/**
 * 模式管理单例
 */
+ (ThemeManage *)shareThemeManage;




@end

//通知
extern NSString * ThemeManageChangeNotification ;
