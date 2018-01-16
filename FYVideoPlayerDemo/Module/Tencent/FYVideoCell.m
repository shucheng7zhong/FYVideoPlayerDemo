//
//  FYVideoCell.m
//  FYVideoPlayerDemo
//
//  Created by fangYong on 17/9/11.
//  Copyright © 2017年 fangYong. All rights reserved.
//

#import "FYVideoCell.h"
#import "UIImageView+WebCache.h"


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
}


- (void)setVideoModel:(VideoModel *)videoModel {
    
    _videoModel = videoModel;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = videoModel.title;
    self.subTitleLabel.text = videoModel.descriptionDe;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.playerCountLabel.text = [NSString stringWithFormat:@"%ld.%ld万",videoModel.playCount/10000,videoModel.playCount/1000-videoModel.playCount/10000];
    self.timeLabel.text = [videoModel.ptime substringWithRange:NSMakeRange(12, 4)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
