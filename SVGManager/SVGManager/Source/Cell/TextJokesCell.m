//
//  TextJokesCell.m
//  DouQu
//
//  Created by ljh on 14/12/15.
//  Copyright (c) 2014年 Jianghuai Li. All rights reserved.
//

#import "TextJokesCell.h"
#import <UIImage+GIF.h>
#import <UIImageView+WebCache.h>



@implementation TextJokesCell
- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, YYScreenSize().width, 44)];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.size = CGSizeMake(YYScreenSize().width, 44);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    //背景

    self.all_content_bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.width - 20, self.height - 10)];

    self.all_content_bg.clipsToBounds = YES;
    self.all_content_bg.layer.cornerRadius = 2.f;
    self.all_content_bg.backgroundColor = [UIColor colorWithRGB:1 alpha:0.1];
    [self.contentView addSubview:_all_content_bg];

    

    //文本
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 15, self.width - 40, self.height - 30)];
    self.contentTextView.scrollEnabled = NO;
    self.contentTextView.editable = NO;
    _contentTextView.backgroundColor = [UIColor clearColor];

    _contentTextView.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_contentTextView];
    
    
    //更新时间
    self.lb_updatetime = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 16)];
    _lb_updatetime.font = [UIFont systemFontOfSize:11];
    _lb_updatetime.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_lb_updatetime];
    
    [self appThemeDidChanged];
}
-(void)appThemeDidChanged
{
    _all_content_bg.image = [UIImage imageCenterStretchName:@"all_kuang"];
    _all_content_bg.highlightedImage = [UIImage imageCenterStretchName:@"all_kuang_up"];
    
    _lb_updatetime.textColor = colorWithGray;
    _contentTextView.textColor = colorWithBlack;
}
-(NSString *)reuseIdentifier
{
    return @"TextJokesCell";
}
-(void)setModel:(JokesModel *)model
{
    _model = model;
    
    if(model.type == JokesModelTypeYouMiAD)
    {
        _contentTextView.textColor = colorWithRed__;
    }
    else
    {
        _contentTextView.textColor = colorWithGray;
    }
    
    __block int lastBottom = 5;
    


    if(model.content.length > 0)
    {
        _contentTextView.top = lastBottom + 10;
        _contentTextView.width = self.width - 40 ;
        _contentTextView.text = model.content;
        [_contentTextView sizeToFit];
        
        lastBottom = ceil(_contentTextView.bottom);
    }
    else
    {
        _contentTextView.text = nil;
    }
    
    
    
    if(model.updatetime.length > 0)
    {
        NSString* screen_name = model.updatetime;
        if([screen_name hasPrefix:@"@"] == NO)
        {
            screen_name = [@"@" stringByAppendingString:screen_name];
        }
        _lb_updatetime.top = lastBottom + 2;
        _lb_updatetime.text = model.updatetime;
        
        lastBottom = _lb_updatetime.bottom;
    }
    else
    {
        _lb_updatetime.text = nil;
    }
    
    
    model.cellHeight = lastBottom + 15;
    _all_content_bg.height = model.cellHeight - 10;
    self.height = model.cellHeight;
}
    
    
+(int)cellHeightWithModel:(JokesModel *)model
{
    int lastBottom = 5;

    
    if(model.content.length > 0)
    {
        CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(YYScreenSize().width-40, INT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        
        lastBottom = lastBottom + 10 + ceil(size.height);
    }
    if (model.imgHeight ) {
        lastBottom = lastBottom + 10 + model.imgHeight;
    }

    model.cellHeight = lastBottom + 15;
    NSLog(@"计算cell高度:%f", model.cellHeight);
    NSLog(@"cell height :%d", model.cellHeight);
    return model.cellHeight;
}
@end
