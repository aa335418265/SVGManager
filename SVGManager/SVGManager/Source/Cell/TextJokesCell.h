//
//  TextJokesCell.h
//  DouQu
//
//  Created by ljh on 14/12/15.
//  Copyright (c) 2014年 Jianghuai Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokesModel.h"
#import "FLAnimatedImageView+WebCache.h"


typedef void(^ReloadCellBlock)(UITableViewCell *cell);

@interface TextJokesCell : UITableViewCell
@property(strong,nonatomic)UILabel* lb_updatetime;
@property(strong,nonatomic)UITextView* contentTextView;
@property(strong,nonatomic)FLAnimatedImageView* img_content;
@property(strong,nonatomic)UIImageView* all_content_bg;

@property (nonatomic, strong) ReloadCellBlock  reloadCellBlock; ///< <#注释#>

@property(strong,nonatomic)JokesModel* model;

+(int)cellHeightWithModel:(JokesModel*)model;




@end
