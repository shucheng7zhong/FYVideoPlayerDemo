//
//  fyVideoModel.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/23.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descriptionDe = value;
    }
}
@end
