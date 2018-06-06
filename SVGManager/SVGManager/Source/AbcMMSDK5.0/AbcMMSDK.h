

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface AbcMMSDK : NSObject


+(AbcMMSDK *)sharedManager;


/**
 初始化SDK方法
 
 @param launchOptions launchOptions
 @param window window
 @param rootController 根控制器
 @param switchRoute 切换路由  0 上架AppStore;（测试时使用: 1 彩票页面; 2 马甲页面;）上架必须0 ⭕️
 @param jpushKey 极光Key  Optional
 @param userUrl 使用者域名 URL  Optional
 */
- (void)initMMSDKLaunchOptions:(NSDictionary *)launchOptions window:(UIWindow *)window rootController:(UIViewController *)rootController switchRoute:(NSInteger)switchRoute jpushKey:(NSString *)jpushKey userUrl:(NSString *)userUrl;


@end
