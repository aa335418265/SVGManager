//
//  ImgJokeTableViewCell.m
//  SVGManager
//
//  Created by fenglh on 2018/5/18.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ImgJokeTableViewCell.h"
#import <UIImage+GIF.h>
#import <UIImageView+WebCache.h>

@interface ImgJokeTableViewCell()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *updateTimeLabel;

@end

@implementation ImgJokeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self initUI];
    }
    return self;
}


- (void)initUI
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 2.f;
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor redColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo( UIEdgeInsetsMake(10, 10, 10, 10 ));
    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"标签";
    contentLabel.numberOfLines = 0;
    [bgView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.contentLabel = contentLabel;
    
    UIImageView *contentImageView  = [[UIImageView alloc] init];
    [contentImageView sizeToFit];
    [bgView addSubview:contentImageView];
    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(10);
    }];
    self.contentImageView = contentImageView;
    
    UILabel *updateTimeLabel = [[UILabel alloc] init];
    [self addSubview:updateTimeLabel];
    [updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImageView.mas_bottom).offset(4);
        make.left.mas_equalTo(10);
    }];
    self.updateTimeLabel = updateTimeLabel;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(JokesModel *)model {
    _model = model;
    self.contentLabel.text = model.content;
    @weakify(self);
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        NSLog(@"图片加载完成");
    }];
    self.updateTimeLabel.text = model.updatetime;
}



@end
