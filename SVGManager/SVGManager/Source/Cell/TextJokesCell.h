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


typedef void(^ReloadCellBlock)(NSIndexPath *indexPath);

@interface TextJokesCell : UITableViewCell
@property(strong,nonatomic)UILabel* lb_updatetime;
@property(strong,nonatomic)UITextView* contentTextView;

@property(strong,nonatomic)UIImageView* all_content_bg;


@property(strong,nonatomic)JokesModel* model;

+(int)cellHeightWithModel:(JokesModel*)model;




@end
