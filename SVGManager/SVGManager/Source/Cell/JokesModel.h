//
//  JokesModel.h
//  DouQu
//
//  Created by ljh on 14/12/14.
//  Copyright (c) 2014年 Jianghuai Li. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JokesModelType) {
    ///文字笑话
    JokesModelTypeText = 1,
    ///图片
    JokesModelTypeImage,
    ///广告
    JokesModelTypeYouMiAD
};

@interface JokesModel : NSObject

@property JokesModelType type;


@property(strong,nonatomic)NSString* content;
@property(strong,nonatomic)NSString* updatetime;
@property(strong,nonatomic)NSString* url;
@property (assign, nonatomic) double imgHeight;

@property int rowIndex;

@property int cellHeight;
//@property int imageCellHeight;
@end
