//
//  FSTestTableViewCell.m
//  FSAutoAdjust-cellHeightDemo
//
//  Created by 冯顺 on 2017/7/9.
//  Copyright © 2017年 shunFSKi. All rights reserved.
//

#import "FSTestTableViewCell.h"
#import "UITableViewCell+FSAutoCountHeight.h"
#import <UIImageView+WebCache.h>
#define randomColor [UIColor colorWithRed:(arc4random() % 25)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1];


@implementation FSTestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:15];
        [self.contentLab sizeToFit];
        self.contentLab.numberOfLines = 0;
        self.contentLab.textColor = [UIColor colorWithRed:117/255.0 green:115/255.0 blue:128/255.0 alpha:1];
        [self.contentView addSubview:self.contentLab];
        
        self.contentImageView = [[UIImageView alloc]init];
        [self.contentImageView sizeToFit];
        [self.contentView addSubview:self.contentImageView];
        

        
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.font = [UIFont systemFontOfSize:14];
        [self.timeLab sizeToFit];
        self.timeLab.textColor = [UIColor colorWithRed:217/255.0 green:215/255.0 blue:224/255.0 alpha:1];
        [self.contentView addSubview:self.timeLab];
        
        {

            
            [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).with.offset(5);
                make.left.equalTo(self.contentView.mas_left).with.offset(10);
                make.right.lessThanOrEqualTo(self.contentView.mas_right).with.offset(-10);
            }];
            
            [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLab.mas_bottom).with.offset(10);
                make.left.mas_equalTo(self.contentLab);
            }];
            
            
            [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.self.contentImageView);
                make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            }];
        }
    }
    self.FS_cellBottomView = self.timeLab;//尽量传入底视图，不传也不会报错
    return self;
}

- (void)setModel:(JokesModel *)model {
    
    self.contentLab.backgroundColor = [UIColor clearColor];
    self.contentImageView.backgroundColor = [UIColor clearColor];
    self.timeLab.backgroundColor = [UIColor clearColor];
    self.contentLab.text = model.content;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.url]];

    self.timeLab.text = model.updatetime;
}


@end
