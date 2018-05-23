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
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *versionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

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
    if ([ThemeManage shareThemeManage].isNight) {
        
        self.versionTitleLabel.textColor = [UIColor lightGrayColor];
        self.actorTitleLabel.textColor = [UIColor lightGrayColor];
        self.emailTitleLabel.textColor = [UIColor lightGrayColor];
        self.versionLabel.textColor = [UIColor lightGrayColor];
        self.actorLabel.textColor = [UIColor lightGrayColor];
        self.emailLabel.textColor = [UIColor lightGrayColor];
        self.contentLabel.textColor = [UIColor lightGrayColor];
        self.iconImageView.alpha = 0.75;
    }else{
        self.versionTitleLabel.textColor = [UIColor darkGrayColor];
        self.actorTitleLabel.textColor = [UIColor darkGrayColor];
        self.emailTitleLabel.textColor = [UIColor darkGrayColor];
        self.versionLabel.textColor = [UIColor darkGrayColor];
        self.actorLabel.textColor = [UIColor darkGrayColor];
        self.emailLabel.textColor = [UIColor darkGrayColor];
        self.contentLabel.textColor = [UIColor darkGrayColor];
        self.iconImageView.alpha = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
