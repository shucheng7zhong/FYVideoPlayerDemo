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


- (void)play;

@end
