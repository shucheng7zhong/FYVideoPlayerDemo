//
//  DataManager.h
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/19.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^onSuccess)(NSArray *videoArray,NSArray *sideArray);
typedef void(^onFailed)(NSError *error);

@interface DataManager : NSObject

+ (DataManager *)shareInstance;

- (void)loadDataWithUrlString:(NSString *)URL
                        param:(NSDictionary *)param
                      success:(onSuccess)success
                       failed:(onFailed)failed;
@end
