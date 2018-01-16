//
//  DataManager.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/19.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "DataManager.h"
#import "VideoModel.h"
#import "VideoSideModel.h"

@implementation DataManager

+(DataManager *)shareInstance {
    
    static DataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)loadDataWithUrlString:(NSString *)URL
                        param:(NSDictionary *)param
                      success:(onSuccess)success
                       failed:(onFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableArray *videoArray = [NSMutableArray array];
    NSMutableArray *videoSidArray = [NSMutableArray array];
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in [responseObject objectForKey:@"videoList"]) {
            VideoModel *videoModel = [[VideoModel alloc]init];
            [videoModel setValuesForKeysWithDictionary:dic];
            [videoArray addObject:videoModel];
        }
        
        for (NSDictionary *dic in [responseObject objectForKey:@"videoSidList"]) {
            VideoSideModel *model = [[VideoSideModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [videoSidArray addObject:model];
        }
        if (success) {
            success(videoArray,videoSidArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failed) {
            failed(error);
        }
    }];
}
@end
