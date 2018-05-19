//
//  ImageJokesCell.h
//  SVGManager
//
//  Created by 冯立海 on 2018/5/19.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView+WebCache.h"

@interface ImageJokesCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *updateTimeLabel;
@property (nonatomic, strong) FLAnimatedImageView *contentImageView;
@end
