//
//  ImageJokesCell.m
//  SVGManager
//
//  Created by 冯立海 on 2018/5/19.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ImageJokesCell.h"
#import "FLAnimatedImageView+WebCache.h"


@interface ImageJokesCell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end
@implementation ImageJokesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.contentLabel];
        [self.bgImageView addSubview:self.contentImageView];
        [self.bgImageView addSubview:self.updateTimeLabel];
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-10);
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
        }];
        [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentImageView.mas_bottom).offset(10);
            make.left.mas_equalTo(0);
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor grayColor];
    }
    return _bgImageView;
}

- (FLAnimatedImageView *)contentImageView {
    if (nil == _contentImageView) {
        
        _contentImageView = [[FLAnimatedImageView alloc] init];
        _contentImageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        _contentImageView.userInteractionEnabled = NO;
        
    }
    
    return _contentImageView;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

- (UILabel *)updateTimeLabel
{
    if (_updateTimeLabel == nil) {
        _updateTimeLabel = [[UILabel alloc] init];
    }
    return _updateTimeLabel;
}
@end
