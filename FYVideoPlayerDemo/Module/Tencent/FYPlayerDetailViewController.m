//
//  FYPlayerDetailViewController.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/25.
//  Copyright © 2017年 fangYong. All rights reserved.
// http://flv3.bn.netease.com/videolib3/1710/25/tJXAl8381/SD/tJXAl8381-mobile.mp4

#import "FYPlayerDetailViewController.h"
#import "FYPlayer.h"

@interface FYPlayerDetailViewController ()
@property (strong, nonatomic) FYPlayer *fyPlayer;
@end

@implementation FYPlayerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createContentView];
}

- (void)createContentView {
    
    self.fyPlayer = [[FYPlayer alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.fyPlayer];
    self.fyPlayer.urlString = @"http://flv3.bn.netease.com/videolib3/1710/25/tJXAl8381/SD/tJXAl8381-mobile.mp4";
    [self.fyPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.right.equalTo(self.view);
        make.height.equalTo(@300);
    }];
    [self.fyPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
