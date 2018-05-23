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
#import "Appd.h"
#import "ThemeManage.h"
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

        
        [AVOSCloud setApplicationId:ApplicationId clientKey:clientKey];
        [AVOSCloud setAllLogsEnabled:YES];
        AVQuery *query = [AVQuery queryWithClassName:className];
        query.limit = 1;
        AVObject *object = [query getFirstObject];
        if (object) {
            NSString  *url = [object objectForKey:@"url"];
            if (url.length >5) {
                [ThemeManage shareThemeManage].adurl = url;
                return UIApplicationMain(argc, argv, nil, NSStringFromClass([Appd class]));
            }
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
