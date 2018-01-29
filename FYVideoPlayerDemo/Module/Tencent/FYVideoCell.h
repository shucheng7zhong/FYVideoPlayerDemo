//
//  FYVideoCell.h
//  FYVideoPlayerDemo
//
//  Created by fangYong on 17/9/11.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface FYVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *videoPlayerButton;
@property (strong, nonatomic) VideoModel *videoModel;

@end
