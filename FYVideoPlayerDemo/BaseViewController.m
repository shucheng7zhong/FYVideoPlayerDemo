//
//  BaseViewController.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2018/1/16.
//  Copyright © 2018年 fangYong. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
@interface BaseViewController ()

@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showHud {
    
    if (!_hud) {
        _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)hideHud {
    
    if (_hud) {
        [_hud removeFromSuperview];
        _hud=nil;
    }
}
@end
