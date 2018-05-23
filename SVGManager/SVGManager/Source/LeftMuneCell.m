//
//  LeftMuneCell.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "LeftMuneCell.h"

@implementation LeftMuneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = (LeftMuneCell *)[[[NSBundle mainBundle] loadNibNamed:@"LeftMuneCell" owner:self options:nil] firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange) name:ThemeManageChangeNotification object:nil];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)themeChange  {
    if ([ThemeManage shareThemeManage].isNight) {
        self.contentLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.contentLabel.textColor = [UIColor darkGrayColor];
    }
    
}

@end
