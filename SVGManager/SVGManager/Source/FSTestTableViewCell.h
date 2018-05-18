//
//  FSTestTableViewCell.h
//  FSAutoAdjust-cellHeightDemo
//
//  Created by 冯顺 on 2017/7/9.
//  Copyright © 2017年 shunFSKi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "JokesModel.h"

@interface FSTestTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) JokesModel *model;

@end
