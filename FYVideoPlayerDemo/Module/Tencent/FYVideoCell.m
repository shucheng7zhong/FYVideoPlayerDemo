//
//  FYVideoCell.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 17/9/11.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "FYVideoCell.h"

@interface FYVideoCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *videoPlayerButton;
@property (weak, nonatomic) IBOutlet UILabel *playerCountLabel;

@end

@implementation FYVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
