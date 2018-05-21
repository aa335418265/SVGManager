//
//  JokesManager.h
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JokesModel.h"

@interface JokesManager : NSObject
+ (instancetype)sharedInstance;




- (void)likeModel:(JokesModel *)model liked:(BOOL)liked;
- (void)colletedModel:(JokesModel *)model collected:(BOOL)collected;


- (BOOL)isLikedHashId:(NSString *)hashId;
- (BOOL)isColletedHashId:(NSString *)hashId;
@end
