//
//  ImageJokesViewController.m
//  SVGManager
//
//  Created by 冯立海 on 2018/5/19.
//  Copyright © 2018年 ITX. All rights reserved.
//

#import "ImageJokesViewController.h"

@interface ImageJokesViewController ()
/**
 *  存放所有下载操作的队列
 */
@property (nonatomic,strong) NSOperationQueue* queue;

/**
 *  存放所有的下载操作（url是key，operation对象是value）
 */
@property (nonatomic,strong) NSMutableDictionary* operations;
/**
 *  存放所有下载完成的图片，用于缓存
 */
@property (nonatomic,strong) NSMutableDictionary* images;
@end

@implementation ImageJokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSOperationQueue *)queue
{
    if (!_queue) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)operations
{
    if (nil == _operations) {
        
        self.operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}


@end
