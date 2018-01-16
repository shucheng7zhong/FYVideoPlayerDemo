//
//  FYPlayer.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/18.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "FYPlayer.h"

@interface FYPlayer()

@property (assign, nonatomic) BOOL isInitPlayer;

@end

@implementation FYPlayer

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createContentView];
    }
    return self;
}


- (void)createContentView {
    
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor blackColor];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    [self createPlayer];
}

- (void)createPlayer {
    
    self.urlAsset = [[AVURLAsset alloc]initWithURL:[NSURL URLWithString:self.urlString] options:nil];
    
    self.playItem  = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    [self.layer addSublayer:self.playerLayer];
}

- (void)play {
    
    [self.player play];
}

@end
