//
//  FYPlayer.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 2017/10/18.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "FYPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
@interface FYPlayer()<UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL isInitPlayer;
@property (strong, nonatomic) UIButton *startOrPauseButton;
@property (nonatomic,retain ) UIButton *fullScreenBtn;
@property (nonatomic,retain ) UIButton *closeBtn;


@property (nonatomic,strong) UISlider *progressSlider;
@property (nonatomic,strong) UISlider *volumeSlider;
@property (strong, nonatomic) UIProgressView *loadingProgress;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic,strong) UILabel *leftTimeLabel;
@property (nonatomic,strong) UILabel *rightTimeLabel;

@property (nonatomic, strong)NSDateFormatter *dateFormatter;



@end

@implementation FYPlayer
{
    UITapGestureRecognizer* singleTap;
    
}

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
    
    self.loadView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_contentView addSubview:self.loadView];
    [self.loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(_contentView);
    }];
    [self.loadView startAnimating];
    
    self.topView = [UIImageView new];
    self.topView.image = [UIImage imageNamed:@"top_shadow"];
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.trailing.leading.equalTo(_contentView);
        make.height.mas_equalTo(70);
    }];
    
    self.bottomView = [UIImageView new];
    self.bottomView.image = [UIImage imageNamed:@"bottom_shaow"];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.bottom.equalTo(_contentView);
        make.height.mas_equalTo(50);
    }];
    
    self.startOrPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.startOrPauseButton];
    [self.startOrPauseButton addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.startOrPauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self.startOrPauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
    self.startOrPauseButton.selected = YES;
    [self.startOrPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.bottom.equalTo(_contentView);
        make.width.height.mas_equalTo(50);
    }];
    
    MPVolumeView *volumeView = [[MPVolumeView alloc]init];
    for (UIControl *view in volumeView.subviews) {
        if ([view.superclass isSubclassOfClass:[UISlider class]]) {
            self.volumeSlider = (UISlider *)view;
        }
    }
    
    self.progressSlider = [UISlider new];
    self.progressSlider.minimumValue = 0.0;
    self.progressSlider.maximumValue = 1.0;
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
    self.progressSlider.minimumTrackTintColor = [UIColor greenColor];
    self.progressSlider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.progressSlider.value = 0.0;//指定初始值
    //进度条的拖拽事件
    [self.progressSlider addTarget:self action:@selector(stratDragSlide:)  forControlEvents:UIControlEventValueChanged];
    //进度条的点击事件
    [self.progressSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventTouchUpInside];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    self.tap.delegate = self;
    [self.progressSlider addGestureRecognizer:self.tap];
    [self.bottomView addSubview:self.progressSlider];
    self.progressSlider.backgroundColor = [UIColor clearColor];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.bottomView).offset(45);
        make.trailing.equalTo(self.bottomView).offset(-45);
        make.centerY.equalTo(self.bottomView);
        make.height.mas_equalTo(30);
    }];
    
    self.loadingProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.loadingProgress.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    self.loadingProgress.trackTintColor    = [UIColor clearColor];
    [self.bottomView addSubview:self.loadingProgress];
    [self.loadingProgress setProgress:0.0 animated:NO];
    
    [self.loadingProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(45);
        make.right.equalTo(self.bottomView).offset(-45);
        make.centerY.equalTo(self.bottomView);
    }];
    [self.bottomView sendSubviewToBack:self.loadingProgress];
    
    self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fullScreenBtn.showsTouchWhenHighlighted = YES;
    [self.fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"smallscreen"] forState:UIControlStateSelected];
    [self.bottomView addSubview:self.fullScreenBtn];
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).with.offset(0);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.bottomView).with.offset(0);
        make.width.mas_equalTo(50);
    }];

    self.leftTimeLabel = [[UILabel alloc]init];
    self.leftTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.leftTimeLabel.textColor = [UIColor whiteColor];
    self.leftTimeLabel.backgroundColor = [UIColor clearColor];
    self.leftTimeLabel.font = [UIFont systemFontOfSize:11];
    [self.bottomView addSubview:self.leftTimeLabel];
    [self.leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).with.offset(45);
        make.right.equalTo(self.bottomView).with.offset(-45);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.bottomView).with.offset(0);
    }];
    self.leftTimeLabel.text = [self convertTime:0.0];//设置默认值
    
    //rightTimeLabel显示右边的总时间
    self.rightTimeLabel = [[UILabel alloc]init];
    self.rightTimeLabel.textAlignment = NSTextAlignmentRight;
    self.rightTimeLabel.textColor = [UIColor whiteColor];
    self.rightTimeLabel.backgroundColor = [UIColor clearColor];
    self.rightTimeLabel.font = [UIFont systemFontOfSize:11];
    [self.bottomView addSubview:self.rightTimeLabel];
    [self.rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).with.offset(45);
        make.right.equalTo(self.bottomView).with.offset(-45);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.bottomView).with.offset(0);
    }];
    self.rightTimeLabel.text = [self convertTime:0.0];//设置默认值

    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.showsTouchWhenHighlighted = YES;
    [_closeBtn addTarget:self action:@selector(colseTheVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self.topView).with.offset(20);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.topView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(45);
        make.right.equalTo(self.topView).with.offset(-45);
        make.center.equalTo(self.topView);
        make.top.equalTo(self.topView).with.offset(0);
    }];
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTouchesRequired = 1; //手指数
    doubleTap.numberOfTapsRequired = 2; // 双击
    // 解决点击当前view时候响应其他控件事件
    [singleTap setDelaysTouchesBegan:YES];
    [doubleTap setDelaysTouchesBegan:YES];
    [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击成立，则取消单击手势（双击的时候不回走单击事件）
    [self.contentView addGestureRecognizer:doubleTap];
    
}

- (void)createPlayer {
    
    self.playItem  = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.urlString]];
    self.player = [AVPlayer playerWithPlayerItem:self.playItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    [self.contentView.layer addSublayer:self.playerLayer];
}

- (void)play {
    [self createPlayer];
    
    [self.player play];
}

- (void)playOrPause:(UIButton *)sender {
    
}

- (void)stratDragSlide:(UISlider *)sender {
    
}

- (void)updateProgress:(UISlider *)sender {
    
}

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    
}

- (void)fullScreenAction:(UIButton *)sender {
    
}

- (void)colseTheVideo:(UIButton *)sender {
    
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    
}

- (NSString *)convertTime:(float)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    return [[self dateFormatter] stringFromDate:d];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    }
    return _dateFormatter;
}
@end
