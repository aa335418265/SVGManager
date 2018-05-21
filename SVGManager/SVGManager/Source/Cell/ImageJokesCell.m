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
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.numberLabel];
        [self.bgImageView addSubview:self.contentLabel];
        [self.bgImageView addSubview:self.contentImageView];
        [self.bgImageView addSubview:self.updateTimeLabel];
        self.bgImageView.layer.cornerRadius = 2.f;
        self.bgImageView.clipsToBounds = YES;
        

        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8);
            make.right.mas_offset(-10);
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
        
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
        }];
        
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.numberLabel.mas_bottom).offset(4);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(0);
        }];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(24);
            make.left.mas_equalTo(10);
        }];
        [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentImageView.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.05];
    }
    return _bgImageView;
}

- (FLAnimatedImageView *)contentImageView {
    if (nil == _contentImageView) {
        
        _contentImageView = [[FLAnimatedImageView alloc] init];
        _contentImageView.userInteractionEnabled = NO;
        
    }
    
    return _contentImageView;
}

- (UILabel *)numberLabel
{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
//        _numberLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:239/255.0 blue:107/255.0 alpha:0.2];
        _numberLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:239/255.0 blue:107/255.0 alpha:0.8];
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.numberOfLines = 1;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:12];
    }
    return _numberLabel;
}
- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

- (UILabel *)updateTimeLabel
{
    if (_updateTimeLabel == nil) {
        _updateTimeLabel = [[UILabel alloc] init];
        _updateTimeLabel.textColor = [UIColor grayColor];
        _updateTimeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _updateTimeLabel;
}
@end
