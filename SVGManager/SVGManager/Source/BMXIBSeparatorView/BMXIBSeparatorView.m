//
//  BMXIBSeparatorView.m
//  BMWash
//
//  Created by fenglh on 2016/10/26.
//  Copyright © 2016年 月亮小屋（中国）有限公司. All rights reserved.
//

#import "BMXIBSeparatorView.h"

@implementation BMXIBSeparatorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.constant == 1) {
            constraint.constant = 1.0 / [UIScreen mainScreen].scale;
        }
    }
}
@end
