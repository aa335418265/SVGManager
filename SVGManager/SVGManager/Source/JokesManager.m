//
//  JokesManager.m
//  SVGManager
//
//  Created by fenglh on 2018/5/21.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "JokesManager.h"

@interface JokesManager ()

@property (nonatomic, strong) NSMutableDictionary *likedDict;
@property (nonatomic, strong) NSMutableDictionary *collectedDict;
@property (nonatomic, strong) YYCache *cache;

@end

@implementation JokesManager

+ (instancetype)sharedInstance
{
    static JokesManager *sharedInstance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[JokesManager alloc] init];
        sharedInstance.likedDict = [NSMutableDictionary dictionary];
        sharedInstance.collectedDict = [NSMutableDictionary dictionary];
        sharedInstance.cache = [YYCache cacheWithName:@"cache"];
        [sharedInstance unArchive];
    });
    return sharedInstance;
}

- (NSArray *)collectedModels {
    return [self.collectedDict allValues];
}

- (void)likeModel:(JokesModel *)model liked:(BOOL)liked
{
    if (liked) {
        [self.likedDict setObject:model forKey:model.hashId];
    }else{
        [self.likedDict removeObjectForKey:model.hashId];
    }
    
    [self archiveLikedDict];
}

- (void)colletedModel:(JokesModel *)model collected:(BOOL)collected {
    
    if (collected) {
        [self.collectedDict setObject:model forKey:model.hashId];
    }else{
        [self.collectedDict removeObjectForKey:model.hashId];
    }
    
    [self archiveCollectedDict];
}

- (BOOL)isLikedHashId:(NSString *)hashId {
    return [self.likedDict containsObjectForKey:hashId];
}

- (BOOL)isColletedHashId:(NSString *)hashId {
    return [self.collectedDict containsObjectForKey:hashId];
}

- (void)archiveLikedDict {
    [self.cache setObject:self.likedDict forKey:@"likedDict"];
}

- (void)archiveCollectedDict {
    [self.cache setObject:self.collectedDict forKey:@"collectedDict"];
}
- (void)archive {
    
    [self archiveLikedDict];
    [self archiveCollectedDict];
}

- (void)unArchive {
    self.likedDict = [(NSMutableDictionary *)[self.cache objectForKey:@"likedDict"] mutableCopy];
    self.collectedDict = [(NSMutableDictionary *)[self.cache objectForKey:@"collectedDict"] mutableCopy];
}

@end
