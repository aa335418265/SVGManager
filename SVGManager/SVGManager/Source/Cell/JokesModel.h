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

@property(strong,nonatomic)NSString* title;
@property(strong,nonatomic)NSString* publisher;
@property(strong,nonatomic)NSString* image;
@property(strong,nonatomic)NSString* content;
@property(strong,nonatomic)NSString* updatetime;
@property(strong,nonatomic)NSString* url;

@property (nonatomic, copy, readonly) NSString *identifier;
@property(strong,nonatomic)NSString* objectId;
@property(strong,nonatomic)NSString* createdAt;
@property(strong,nonatomic)NSString* updatedAt;
@property int rowIndex;

@property int textCellHeight;
@property int imageCellHeight;
@end
