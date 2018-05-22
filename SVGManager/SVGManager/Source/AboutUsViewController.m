//
//  AboutUsViewController.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "AboutUsViewController.h"
#import "ImageJokesCell.h"
@interface AboutUsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"关于我们";

    [self themeChange];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:ThemeManageChangeNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)themeChange  {
    [self.imageView setImageToBlur:[ThemeManage shareThemeManage].tableViewbgImage blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
