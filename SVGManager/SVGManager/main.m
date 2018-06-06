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
extern void hikari_fco(void);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
