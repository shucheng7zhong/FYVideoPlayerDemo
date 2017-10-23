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
}


- (void)play {
    
    if (_isInitPlayer ) {
        
    }else {
        
        
    }
}

@end
