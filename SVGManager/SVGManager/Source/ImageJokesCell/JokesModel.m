//
//  JokesModel.m
//  DouQu
//
//  Created by ljh on 14/12/14.
//  Copyright (c) 2014年 Jianghuai Li. All rights reserved.
//

#import "JokesModel.h"

@implementation JokesModel
- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}



/**********************/
/*       归档          */
/**********************/

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    @autoreleasepool {
        [self continueEncodeIvarOfClass:[self class] withCoder:aCoder];
    }
}

//解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        @autoreleasepool {
            [self continueDecodeIvarOfClass:[self class] withCoder:aDecoder];
        }
    }
    return self;
}

- (void)encodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder {
    unsigned int numIvars = 0;
    Ivar *ivars = class_copyIvarList(class, &numIvars);
    for (int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [self valueForKey:key];
        if ([key hasPrefix:@"parent"]) {
            [coder encodeConditionalObject:value forKey:key];
        } else {
            [coder encodeObject:value forKey:key];
        }
    }
    if (ivars != NULL) {
        free(ivars);
    }
}

- (void)continueEncodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder {
    if (class_respondsToSelector(class, @selector(encodeWithCoder:))) {
        [self encodeIvarOfClass:class withCoder:coder];
        [self continueEncodeIvarOfClass:class_getSuperclass(class) withCoder:coder];
    }
}

- (void)decodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder {
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList(class, &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [coder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    if (ivars != NULL) {
        free(ivars);
    }
}

- (void)continueDecodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder {
    if (class_respondsToSelector(class, @selector(initWithCoder:))) {
        [self decodeIvarOfClass:class withCoder:coder];
        [self continueDecodeIvarOfClass:class_getSuperclass(class) withCoder:coder];
    }
}

@end
