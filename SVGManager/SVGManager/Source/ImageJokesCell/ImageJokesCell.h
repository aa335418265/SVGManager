//
//  ImageJokesCell.h
//  SVGManager
//
//  Created by 冯立海 on 2018/5/19.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView+WebCache.h"

typedef void (^LikeClick)(NSIndexPath *indexPath, BOOL liked);
typedef void (^CollectClick)(NSIndexPath *indexPath, BOOL collected);

@interface ImageJokesCell : UITableViewCell


@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *updateTimeLabel;
@property (nonatomic, strong) FLAnimatedImageView *contentImageView;

@property (nonatomic, assign) BOOL liked;
@property (nonatomic, assign) BOOL collected;

@property (nonatomic, strong) LikeClick likedClickBlock;
@property (nonatomic, strong) CollectClick collectedClickBlock;
@end
