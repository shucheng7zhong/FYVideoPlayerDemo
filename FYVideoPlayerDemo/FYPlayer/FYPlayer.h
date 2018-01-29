//
//  FYPlayer.h
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/18.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;
@interface FYPlayer : UIView

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) AVPlayer *player;

//媒体资源管理对象，管理者视频的一些基本信息和状态，一个AVPlayerItem对应着一个视频资源
@property (strong, nonatomic) AVPlayerItem *playItem;

//AVPlayer继承NSObject,单独使用AVPlayer时无法显示视频的，必须将视频图层添加到AVPlayerLayer中方能显示视频
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

//AVAsset的子类，可以根据一个URL路径创建一个包含媒体信息的AVURLAsset对象。
@property (strong, nonatomic) AVURLAsset *urlAsset;

@property (strong, nonatomic) NSString *urlString;
//菊花
@property (strong, nonatomic) UIActivityIndicatorView *loadView;

@property (strong, nonatomic) UIImageView *topView;

@property (strong, nonatomic) UIImageView *bottomView;

@property (nonatomic,strong) UILabel  *titleLabel;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)play;

@end
