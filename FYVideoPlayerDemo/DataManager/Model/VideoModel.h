//
//  fyVideoModel.h
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/23.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * descriptionDe;
@property (nonatomic, assign) NSInteger  length;
@property (nonatomic, copy) NSString * m3u8_url;
@property (nonatomic, copy) NSString * m3u8Hd_url;
@property (nonatomic, copy) NSString * mp4_url;
@property (nonatomic, copy) NSString * mp4_Hd_url;
@property (nonatomic, assign) NSInteger  playCount;
@property (nonatomic, copy) NSString * playersize;
@property (nonatomic, copy) NSString * ptime;
@property (nonatomic, copy) NSString * replyBoard;
@property (nonatomic, copy) NSString * replyCount;
@property (nonatomic, copy) NSString * replyid;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * vid;
@property (nonatomic, copy) NSString * videosource;


@end
