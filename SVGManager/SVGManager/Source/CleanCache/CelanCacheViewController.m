//
//  CelanCacheViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "CelanCacheViewController.h"
#import <SDImageCache.h>

@interface CelanCacheViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cleanCacheTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cacheTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CelanCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"清理缓存";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self getCacheSize];

    [self themeChange];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:ThemeManageChangeNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)themeChange  {
    [self.imageView setImageToBlur:[ThemeManage shareThemeManage].tableViewbgImage blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    if ([ThemeManage shareThemeManage].isNight) {
        self.cleanCacheTitleLabel.textColor = [UIColor lightGrayColor];
        self.cacheTitleLabel.textColor = [UIColor lightGrayColor];
        self.cacheSizeLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.cleanCacheTitleLabel.textColor = [UIColor darkGrayColor];
        self.cacheTitleLabel.textColor = [UIColor darkGrayColor];
        self.cacheSizeLabel.textColor = [UIColor darkGrayColor];
    }
}


- (IBAction)cleanCache:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您要清除现有缓存吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    @weakify(self);
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);

        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        [self getCacheSize];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)getCacheSize {
    NSUInteger imageCache = [[SDImageCache sharedImageCache] getSize];
    NSString *sizeStr = [self stringWithByteSize:imageCache];
    self.cacheSizeLabel.text =sizeStr;
}


- (NSString *)stringWithByteSize:(NSUInteger)size
{
    NSString *sizeText;
    if (size >= pow(10, 9)) { // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%zdB", size];
    }
    return sizeText;
}
@end

